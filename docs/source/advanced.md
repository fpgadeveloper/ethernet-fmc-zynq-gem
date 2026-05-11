# Advanced: project structure and customization

This section is intended for users who want to modify the reference
designs — adding IP to the block design, changing constraints, modifying
the standalone application, or adding packages or drivers to the
PetaLinux project. It describes how the repository is laid out, how the
Make-driven build flow works, how the Vitis and PetaLinux sides are
organised, and what modifications have been added on top of the stock
AMD BSPs.

The actual *build* instructions are in [build_instructions](build_instructions);
this section is about understanding the project well enough to modify
it.

## Repository layout

```
.
├── Makefile                   <- Top-level build entry point
├── README.md
├── config/                    <- Source-of-truth design metadata and auto-generation
│   ├── data.json
│   └── update.py
├── docs/                      <- This documentation (Sphinx + Read the Docs)
├── EmbeddedSw/                <- Vendored AMD BSP libraries used by the Vitis build
├── PetaLinux/
│   ├── Makefile               <- PetaLinux build orchestration
│   └── bsp/                   <- Per-board and per-port-config BSP fragments
│       ├── pz/, uzev/, zcu102/, …          <- board-specific overlays
│       └── ports-0123/, ports-012-/, …     <- port-config overlays
├── Vivado/
│   ├── Makefile               <- Vivado build orchestration
│   ├── scripts/
│   │   ├── build.tcl          <- Project creation + block design assembly
│   │   └── xsa.tcl            <- Synthesis, implementation, XSA export
│   └── src/
│       ├── bd/
│       │   ├── bd_zynq.tcl    <- Block design for Zynq-7000 targets
│       │   └── bd_zynqmp.tcl  <- Block design for Zynq UltraScale+ targets
│       └── constraints/
│           └── <target>.xdc   <- One XDC per target (pin assignments, timing)
└── Vitis/
    ├── Makefile               <- Vitis workspace + boot-image orchestration
    ├── py/
    │   ├── args.json          <- Repo-specific Vitis flow configuration
    │   ├── build-vitis.py     <- Universal Vitis Python build driver
    │   ├── make-boot.py       <- BOOT.BIN packaging
    │   ├── pre_build.py       <- Per-build hook (e.g. constants generation)
    │   └── pre_platform_build.py
    ├── common/
    │   └── src/               <- Standalone application source (echo_server)
    └── <target>_workspace/    <- Per-target Vitis workspace (generated)
```

Per-target build outputs are written to `Vivado/<target>/`,
`Vitis/<target>_workspace/`, and `PetaLinux/<target>/`; packaged
boot-image zips are written to `bootimages/`. None of these are
committed.

## Target naming

A `TARGET` is the canonical handle for a single design and is the only
parameter passed through the build flow. It encodes the board and, for
boards with multiple FMC connectors, the connector:

```
<board>[_<connector>]
```

Examples: `uzev`, `zcu102_hpc0`, `zcu102_hpc1`, `zc706_lpc`,
`uzeg_pci`, `zedboard`, `pynqzu`. The first underscore-delimited token
is taken as the *target board* and is what `PetaLinux/Makefile` uses
to select the BSP under `PetaLinux/bsp/<board>/`.

The complete list of valid targets is in the `UPDATER START` block of
each Makefile and is generated from `config/data.json` (see below).

## `config/data.json` and `config/update.py`

`config/data.json` is the canonical source of truth for the set of
supported designs and their per-target metadata (board name, processor
family, FMC connector, port lane mapping, baremetal-vs-PetaLinux
support, etc.). `config/update.py` reads `data.json` and regenerates
the auto-managed sections of the four Makefiles, the top-level
`README.md`, and `.gitignore` — the sections delimited by
`UPDATER START` / `UPDATER END` comment markers.

When adding or modifying a target, edit `data.json` and re-run
`update.py`. Do not hand-edit content between the `UPDATER START` /
`UPDATER END` markers; it will be overwritten on the next regeneration.

## Make-driven build flow

There are four Makefiles in the repository, each scoped to a stage of
the build:

| Makefile              | Scope                                                                                          |
|-----------------------|------------------------------------------------------------------------------------------------|
| `./Makefile`          | Top-level orchestration; assembles boot-image zips for one or all targets.                     |
| `./Vivado/Makefile`   | Creates the Vivado project, runs synthesis and implementation, exports the XSA.                |
| `./Vitis/Makefile`    | Creates the Vitis workspace and platform from the XSA, builds the standalone application, packages BOOT.BIN. |
| `./PetaLinux/Makefile`| Creates the PetaLinux project from the XSA, applies BSP overlays, builds, packages.            |

A `make bootimage TARGET=<t>` invocation at the top level cascades:

```
make bootimage TARGET=t
  -> Vitis side:
       Vitis/Makefile workspace TARGET=t -> bootfile TARGET=t
         -> ensures Vivado XSA exists
              Vivado/Makefile xsa TARGET=t
                -> vivado -mode batch -source scripts/build.tcl   (creates project)
                -> vivado -mode batch -source scripts/xsa.tcl     (synth, impl, XSA export)
         -> vitis -source py/build-vitis.py  ... (creates platform + app, builds)
         -> python3 py/make-boot.py          ... (packages BOOT.BIN)
  -> PetaLinux side:
       PetaLinux/Makefile petalinux TARGET=t
         -> petalinux-create --template <zynq|zynqMP> --name t
         -> petalinux-config --get-hw-description <XSA>
         -> copy bsp/<board>/project-spec/* into the project
         -> copy bsp/<port-config>/project-spec/* into the project   (overlay)
         -> petalinux-config --silentconfig
         -> petalinux-build
         -> petalinux-package boot ...
  -> zip the resulting boot files into bootimages/
```

Per-target lock files (`.<target>.lock` in each Makefile's directory)
prevent two concurrent builds of the same target from clobbering each
other.

## Vivado side

### Block design

The block-design scripts live under `Vivado/src/bd/`, one per
processor family:

* `bd_zynq.tcl`   — Zynq-7000 targets (`pz_7030`, `zc706_lpc`,
  `zedboard`). The Zynq-7000 only has two hard GEMs, so these designs
  use one for the on-board RJ45 and the other for one of the Ethernet
  FMC ports. The remaining ports use AXI Ethernet Subsystem IP.
* `bd_zynqmp.tcl` — Zynq UltraScale+ targets. These use the PS GEMs
  (GEM0–GEM3) with PL-side GMII-to-RGMII bridges.

Each script contains per-board conditional blocks where a target needs
to deviate from the family defaults — typically for clock-source
selection, PS configuration, or FMC connector routing.

After sourcing the BD script, `scripts/build.tcl` runs
`validate_bd_design -force`, which triggers parameter propagation and
fills in connection-automation rules. As a result the final
implemented design may contain nets that aren't visible in the BD TCL
source — to see the actual netlist as built, inspect the saved `.bd`
file under `Vivado/<target>/<target>.srcs/sources_1/bd/<bd_name>/` or
use `write_bd_tcl` to export a complete script from an open project.

### Constraints

`Vivado/src/constraints/<target>.xdc` contains pin assignments and any
target-specific timing constraints. Constraints common to all targets
of a given family are not factored out — each target's XDC is
self-contained.

### Build scripts

* `Vivado/scripts/build.tcl` creates the Vivado project, adds the
  target's XDC, sources the appropriate `bd_*.tcl`, and validates the
  block design. Invoked via `make project TARGET=<t>`.
* `Vivado/scripts/xsa.tcl` opens the existing project, runs synthesis
  and implementation, exports the XSA, and writes the bitstream into
  the implementation run directory. Invoked via `make xsa TARGET=<t>`.

Both scripts check `XILINX_VIVADO` to confirm the installed Vivado
version matches the `version_required` constant at the top of the
file. Bumping the project to a new Vivado release means changing those
constants and re-testing — the BD TCL APIs are not stable across major
releases.

### Modifying the block design

Edit the block-design script for the appropriate processor family
directly. If the change applies only to some targets in the family,
wrap the additions in the appropriate per-board conditional block.

Once the script is edited, delete any existing per-target Vivado
project directory (`rm -rf Vivado/<target>`) and re-run the Vivado
build through the Makefile:

```
make -C Vivado xsa TARGET=<target>
```

This re-creates the project, sources the modified BD script, runs
`validate_bd_design`, synthesises, implements, and re-exports the XSA.
Downstream Vitis / PetaLinux / boot-image steps will pick up the new
XSA on the next `make` at the top level.

### Adding or modifying constraints

Edit `Vivado/src/constraints/<target>.xdc` directly. If a constraint
applies to all targets in a family, it still needs to be replicated to
each target's XDC — there is no shared XDC.

## Vitis side

The standalone (baremetal) build runs the lwIP echo-server example
against the FMC Ethernet ports. The application source is shared
across all targets.

### Layout

```
Vitis/
├── Makefile
├── py/
│   ├── args.json
│   ├── build-vitis.py        <- Universal Vitis Python build driver
│   ├── make-boot.py          <- BOOT.BIN packaging
│   ├── pre_build.py          <- Hook run before each app build
│   └── pre_platform_build.py <- Hook run before each platform build
├── common/
│   └── src/                  <- Application source (echo_server)
├── boot/<target>/            <- Per-target packaged boot files
└── <target>_workspace/       <- Generated Vitis workspace per target
```

### `args.json`

`Vitis/py/args.json` is the repo-specific configuration that drives
the universal `build-vitis.py` driver. Key fields:

* `bd_name` — block-design name (`zynqgem`).
* `app_name` — name of the Vitis application (`echo_server`).
* `app_template` — `lwip_echo_server`.
* `bsp_libs` — `lwip220` with DHCP + ACD check + enlarged pbuf pool,
  and `xiltimer` with the interval timer enabled.
* `src` — `"all": "common/src"`, every target uses the same source.
* `combine_bit_elf` — `true`, so the bitstream and ELF are combined
  into a single download image where applicable.

### Modifying the standalone application

Edit `Vitis/common/src/*.c` directly. The next `make -C Vitis bootfile
TARGET=<t>` rebuilds the application against the existing platform; if
you've changed the hardware (XSA) you'll need a fresh workspace
(`make -C Vitis clean TARGET=<t>` first).

### Modifying BSP libraries or build hooks

Adjust the corresponding entry in `Vitis/py/args.json`. The two hook
scripts in `py/` are repo-specific Python; edit them when the change
is more elaborate than a `bsp_libs` config tweak.

## PetaLinux side

### BSP composition

The PetaLinux project for a given target is composed at build time
from two BSP fragments copied into the target's project directory:

1. A **board BSP** at `PetaLinux/bsp/<board>/` (for example `pynqzu/`,
   `uzev/`, `zcu102/`, `zedboard/`). Provides board-specific kernel
   and U-Boot configuration, the system device-tree fragment for the
   board, and any board-specific patches.
2. A **port-config overlay** at `PetaLinux/bsp/<port-config>/`.
   Provides `port-config.dtsi` — the device-tree fragment that wires
   up the Ethernet ports active on this target.

The mapping from target to (board BSP, port-config overlay) is encoded
in `PetaLinux/Makefile`'s `UPDATER` block. The last column names the
port-config overlay; the board BSP is derived from the first token of
the target name.

The port-config overlay variants are:

* `ports-0123` — four-port designs that use the PS GEMs + PL
  GMII-to-RGMII bridges. The overlay configures `gem0`…`gem3` with
  their respective MDIO PHYs and GMII-to-RGMII shims. Used by all
  ZynqMP targets except `zcu102_hpc1`.
* `ports-012-` — three-port designs (currently `zcu102_hpc1`, where
  the FMC routes only three lanes).
* `ports-0123-axieth` — four-port designs that use the AXI Ethernet
  Subsystem IP instead of PS GEMs. The overlay configures
  `axi_ethernet_0`…`axi_ethernet_3` with `phy-mode = "rgmii-rxid"`.
  Used by the Zynq-7000 targets (`pz_7030`, `zc706_lpc`, `zedboard`),
  which don't have enough PS GEMs to drive all four FMC ports.
* `ports-3` — port-3-only fragment, currently not assigned to any
  active target; retained as a starting point for single-port
  variants.

### Layout of a board BSP

```
PetaLinux/bsp/<board>/project-spec/
├── configs/
│   ├── config                <- petalinux-config: bootargs, rootfs, hostname
│   ├── rootfs_config         <- petalinux-config -c rootfs: included packages
│   ├── init-ifupdown/
│   │   └── interfaces        <- /etc/network/interfaces
│   └── busybox/
│       └── inetd.conf
└── meta-user/
    ├── conf/
    │   ├── user-rootfsconfig <- declares additional rootfs config options
    │   ├── petalinuxbsp.conf
    │   └── layer.conf
    ├── recipes-bsp/
    │   ├── device-tree/
    │   │   ├── device-tree.bbappend
    │   │   └── files/
    │   │       └── system-user.dtsi    <- board-specific DT additions
    │   ├── u-boot/
    │   │   ├── u-boot-xlnx_%.bbappend
    │   │   └── files/
    │   │       ├── bsp.cfg             <- U-Boot Kconfig additions
    │   │       ├── platform-top.h
    │   │       └── *.patch             <- U-Boot source patches
    │   └── embeddedsw/                 <- (zcu104 only)
    │       ├── fsbl-firmware_%.bbappend
    │       └── files/
    │           └── zcu104_vadj_fsbl.patch
    └── recipes-kernel/
        └── linux/
            ├── linux-xlnx_%.bbappend
            └── linux-xlnx/
                └── bsp.cfg             <- kernel Kconfig additions
```

### Adding a package to the root filesystem

1. Append the new option to `bsp/<board>/project-spec/configs/rootfs_config`.
2. If the package is not in the default `petalinux-config -c rootfs`
   menu, also append a declaration line to
   `bsp/<board>/project-spec/meta-user/conf/user-rootfsconfig`.
3. If the package is not provided by an existing meta-layer, add a
   recipe under
   `bsp/<board>/project-spec/meta-user/recipes-apps/<package>/<package>.bb`.

### Adding a kernel config option

Append the option to
`bsp/<board>/project-spec/meta-user/recipes-kernel/linux/linux-xlnx/bsp.cfg`.

### Adding a device-tree fragment

For per-board fragments, edit
`bsp/<board>/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi`.
For per-port-config fragments, edit the corresponding
`bsp/<port-config>/project-spec/meta-user/recipes-bsp/device-tree/files/port-config.dtsi`.

### Adding a kernel patch or out-of-tree driver

1. Drop the patch file into
   `bsp/<board>/project-spec/meta-user/recipes-kernel/linux/linux-xlnx/`.
2. Add `SRC_URI:append = " file://<your-patch>.patch"` to
   `recipes-kernel/linux/linux-xlnx_%.bbappend`.

### Modifying U-Boot

The same pattern as the kernel, under
`bsp/<board>/project-spec/meta-user/recipes-bsp/u-boot/`. `bsp.cfg`
adds U-Boot Kconfig options; `platform-top.h` overrides the U-Boot
platform header; patches are listed in `SRC_URI:append` in
`u-boot-xlnx_%.bbappend`.

## Modifications layered on the stock BSPs

The board BSPs in this repository started as the corresponding stock
AMD reference BSPs and have been modified in the following ways. This
list is the answer to *"what would I lose if I overwrote the BSP with
the stock one?"* — it is what to re-apply if you ever do that.

### All BSPs

* **Root filesystem additions** in `configs/rootfs_config`:
  `ethtool`, `iperf3`, `phytool` (plus `ethtool-dev` and `ethtool-dbg`
  on ZynqMP).
* **Hostname / product name** set in `configs/config` via
  `CONFIG_SUBSYSTEM_HOSTNAME` and `CONFIG_SUBSYSTEM_PRODUCT`.
* **`system-user.dtsi`** includes `port-config.dtsi`. The matching
  `device-tree.bbappend` adds both files to `SRC_URI:append`.
* **Kernel configs** in `linux-xlnx/bsp.cfg`:
  `CONFIG_XILINX_GMII2RGMII`, `CONFIG_MARVELL_PHY`, `CONFIG_AMD_PHY`,
  `CONFIG_XILINX_PHY` (needed for the GMII-to-RGMII shim and the
  on-board PHYs used by the Ethernet FMC).

### Zynq-7000 and ZynqMP BSPs

* **SD-card root filesystem** configured in `configs/config`:
  `CONFIG_SUBSYSTEM_ROOTFS_EXT4`, `CONFIG_SUBSYSTEM_SDROOT_DEV`,
  `CONFIG_SUBSYSTEM_USER_CMDLINE` (with `cma=1536M` for the AXI DMA
  buffers).
* **U-Boot patch `0001-ubifs-distroboot-support.patch`** on most
  ZynqMP boards.

### ZynqMP BSPs (additionally)

* **Kernel configs** in `linux-xlnx/bsp.cfg`:
  `CONFIG_XILINX_DMA_ENGINES`, `CONFIG_XILINX_DPDMA`,
  `CONFIG_XILINX_ZYNQMP_DMA`.

### UltraZed-EV (uzev) and UltraZed-EG (uzeg) BSPs

* **`CONFIG_YOCTO_MACHINE_NAME="zynqmp-generic"`** in `configs/config`
  (the UZ-EV / UZ-EG are not stock Xilinx eval boards).
* **SD-card device set to `/dev/mmcblk1p2`** rather than the ZynqMP
  default `mmcblk0p2`.
* **`PRIMARY_SD_PSU_SD_1_SELECT=y`** to route the boot SD interface
  through PSU SD1 instead of SD0.
* **Custom `system-user.dtsi`** with carrier-specific peripheral
  configuration.
* **`meta-xilinx-tools/recipes-bsp/uboot-device-tree/`** overlay that
  overrides the U-Boot device tree.

### ZCU104 BSP

* **FSBL patch `zcu104_vadj_fsbl.patch`** in
  `recipes-bsp/embeddedsw/files/`, registered via
  `fsbl-firmware_%.bbappend`. The ZCU104 FSBL is patched to program the
  on-board IRPS5401 PMBus regulator to 1.8V before the FMC PHYs come
  out of reset.

### Port-config overlays

The four overlays in `PetaLinux/bsp/ports-*/` are not derived from
any stock BSP — they exist solely to add the device-tree fragment
that wires up the FMC Ethernet ports. Each contains a single
`port-config.dtsi` (the surrounding directory structure is needed so
that Yocto picks it up via the `SRC_URI:append = " file://port-config.dtsi"`
line in `device-tree.bbappend`).

## Where build outputs land

| Path                                | Contents                                                                       |
|-------------------------------------|--------------------------------------------------------------------------------|
| `Vivado/<target>/`                  | Vivado project. `<bd_name>_wrapper.xsa` is the export.                          |
| `Vivado/<target>/<target>.runs/impl_1/<bd_name>_wrapper.bit` | Bitstream.                                              |
| `Vivado/logs/`                      | Per-target Vivado build logs (xpr + xsa).                                       |
| `Vitis/<target>_workspace/`         | Per-target Vitis workspace (platform + application + BSP).                      |
| `Vitis/boot/<target>/`              | Packaged Vitis boot files (`BOOT.BIN`).                                         |
| `PetaLinux/<target>/`               | PetaLinux project. All Yocto build state lives here.                            |
| `PetaLinux/<target>/images/linux/`  | `BOOT.BIN`, `image.ub`, `boot.scr`, `rootfs.tar.gz`, etc.                       |
| `PetaLinux/<target>/build/build.log`| PetaLinux build log.                                                            |
| `bootimages/`                       | Per-target zipped boot files (`<prj>_<target>_petalinux-<ver>.zip` and `<prj>_<target>_standalone-<ver>.zip`). |

None of these directories are committed to the repository.
