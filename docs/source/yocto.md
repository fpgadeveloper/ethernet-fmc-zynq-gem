# Yocto

The Yocto flow builds the Linux images with AMD's Embedded Development Framework (EDF), the
announced successor to PetaLinux. It is driven by the same `build.py` runner as the other flows
and produces an image that exercises the Ethernet FMC ports in the same way as the PetaLinux
image, plus a few extras (the board Ethernet port on Zynq-7000, Wi-Fi on the PYNQ-ZU).

```{note}
For 2025.2 both the PetaLinux and Yocto flows are supported. From the next tool version onward,
the PetaLinux flow for this repository will be retired and Yocto will be the only supported flow.
```

The Yocto flow supports all the Zynq-7000 and Zynq UltraScale+ targets of this repository.

## How it works

The build does not depend on an AMD board machine configuration. It turns the Vivado XSA into a
System Device Tree (with `sdtgen` from Vitis) and generates a Yocto machine and device trees from it
(`gen-machineconf parse-sdt`). The PS configuration and the PL hardware of the design (AXI Ethernet,
AXI DMA, GMII-to-RGMII) therefore come straight from your Vivado design. The Ethernet FMC PHYs are
not in the XSA, so two device-tree fragments from this repository are added on top:

* a **port configuration** (`Yocto/bsp/port-configs/ports-*`) with the MAC address, PHY and MDIO
  bus of each port (`ports-0123` for the four-port Zynq UltraScale+ designs, `ports-012-` for
  `zcu102_hpc1`, `ports-0123-axieth` for the Zynq-7000 designs), and
* a **board file** (`Yocto/bsp/<board>/.../system-user.dtsi`) with board-specific fixes.

The bitstream is embedded in `BOOT.BIN`, and the FSBL programs the FPGA at boot. More details are
in `Yocto/README.md` and on the [Advanced](advanced.md#yocto-side) page.

## Requirements

* A physical or virtual machine running one of the [supported Linux distributions] (the Yocto
  flow cannot run on Windows or in WSL).
* Vivado 2025.2 and Vitis 2025.2. The flow uses `sdtgen`/`xsct`, which ship with Vitis. The build
  runner finds and sources the tools itself.
* [Google's repo tool](https://gerrit.googlesource.com/git-repo/) on your `PATH`, and the Yocto
  host packages. On Ubuntu 22.04 / 24.04:
  ```
  sudo apt-get install repo gawk wget git diffstat unzip texinfo gcc \
      build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
      xz-utils debianutils iputils-ping python3-git python3-jinja2 \
      python3-subunit zstd liblz4-tool file locales libacl1 bmap-tools
  ```
* Disk space: a fresh Yocto workspace takes roughly 40 to 60 GB per target.
* An internet connection for the first build (or an sstate mirror, see
  [Offline build](#offline-build)).

## Build

1. Clone the repository (with its submodules) and change into it:
   ```
   git clone --recurse-submodules https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem.git
   cd ethernet-fmc-zynq-gem
   ```
2. Build the image, replacing `<target>` with one of the target labels from the
   [build instructions](build_instructions.md#target-designs):
   ```
   ./build.sh yocto --target <target>
   ```

This builds the Vivado project and XSA first if they don't exist yet. The first build of a target
downloads the Yocto layers (`repo sync`) and sources and builds everything from scratch, so it
takes a long time; later builds are incremental. To also package the result:

```
./build.sh package --target <target>
```

### Outputs

The output products are gathered into `Yocto/<target>/images/linux/`:

| File | Description |
| --- | --- |
| `BOOT.BIN` | Boot image (FSBL, PMU firmware and TF-A on Zynq UltraScale+, bitstream, U-Boot) |
| `boot.scr` | U-Boot boot script; it builds the kernel command line |
| `uImage` / `Image` | Linux kernel (`uImage` on Zynq-7000, `Image` on Zynq UltraScale+) |
| `system.dtb` | Linux device tree |
| `rootfs.wic.xz` | Full SD card disk image (this is what you write to the card) |
| `rootfs.wic.bmap` | Block map for `bmaptool` (fast writing) |
| `rootfs.tar.gz` | Root file system tarball |

`./build.sh package` (or `all`) puts `rootfs.wic.xz`, `rootfs.wic.bmap`, `BOOT.BIN` and a short
`readme.txt` into `bootimages/ethernet-fmc-zynq-gem_<target>_yocto-2025-2.zip`.

### Offline build

To build without downloading the Yocto shared-state cache, download and extract the AMD sstate
mirror for 2025.2 and write the path of the extracted directory, on a single line, into
`Yocto/offline.txt`. The build looks for the subdirectories `aarch64/` (Zynq UltraScale+),
`arm/` (Zynq-7000), `microblaze/` (the Zynq UltraScale+ PMU firmware) and, optionally,
`downloads/` (source mirror) under that path.

## What is in the image

| Item | Value |
|------|-------|
| Distribution | AMD Embedded Development Framework (Yocto scarthgap), Linux 6.12, systemd |
| Hostname | `<board>-zynqgem-2025-2`, for example `zcu102-zynqgem-2025-2`, `zedboard-zynqgem-2025-2`, `pz-zynqgem-2025-2`, `pynqzu-zynqgem-2025-2` |
| Login | user `amd-edf`, no password; you must choose a password at the first login. `sudo` asks for that password. |
| Serial console | PS UART 0 (`ttyPS0`), 115200 baud |
| Networking | `systemd-networkd`: DHCP on every wired port; OpenSSH server |
| Added tools | `ethtool`, `phytool`, `iperf3`, `mtd-utils`, `can-utils`, `nfs-utils`, `pciutils`; `bridge-utils` on Zynq-7000; Wi-Fi tools on the PYNQ-ZU |

The kernel command line is made by `boot.scr` from fixed arguments plus the board's arguments
(`BSP_EXTRA_BOOTARGS` in `Yocto/bsp/<board>/conf/local.conf.append`):

| Target | Kernel command line |
|--------|---------------------|
| Zynq UltraScale+ (AMD boards, PYNQ-ZU) | `earlycon console=ttyPS0,115200 clk_ignore_unused init_fatal_sh=1 root=/dev/mmcblk0p3 ro rootwait uio_pdrv_genirq.of_id=generic-uio cma=1536M` |
| UltraZed-EG, UltraZed-EV | as above, but `root=/dev/mmcblk1p3` and `cma=1000M` |
| ZedBoard | `root=/dev/mmcblk0p3 ro rootwait uio_pdrv_genirq.of_id=generic-uio earlycon console=ttyPS0,115200 clk_ignore_unused cma=256M` |
| PicoZed 7030, ZC706 | as ZedBoard, with `cma=512M` |

The root file system is mounted read-only first and remounted read-write by systemd.

## Prepare the SD card

The Yocto flow produces a full SD card image (`rootfs.wic.xz`) with all its partitions. Write it to
the SD card's raw device, then copy `BOOT.BIN` onto the first partition. The card layout is:

| Partition | Type | Contents |
|-----------|------|----------|
| 1 | FAT32 (ESP) | `BOOT.BIN` (you copy it here; the BootROM loads it from this partition) |
| 2 | ext4 (`boot`) | kernel, `boot.scr`, `system.dtb` |
| 3 | ext4 | root file system |
| 4 | FAT32 | empty, free for your data (Zynq UltraScale+) |

```{warning}
Writing an image to a raw block device cannot be undone. Be absolutely certain that you have
identified the SD card's device node before running the commands below; with the wrong device you
can destroy the data on one of your hard drives.
```

1. Identify the SD card device. With the card **un**plugged, run `lsblk -o NAME,SIZE,RM,TYPE`,
   insert the card, and run it again. The new entry, typically `/dev/sdX` with `RM=1`
   (removable) and a size matching your card, is your target. Replace `sdX` with that device,
   and `<target>` with your target, below.
2. Unmount any partitions that the desktop mounted automatically:
   ```
   for p in /dev/sdX?*; do sudo umount "$p" 2>/dev/null; done
   ```
3. Write the image to the raw device. With `bmaptool` (fast, writes only the used blocks):
   ```
   sudo bmaptool copy --bmap Yocto/<target>/images/linux/rootfs.wic.bmap \
                            Yocto/<target>/images/linux/rootfs.wic.xz \
                            /dev/sdX
   ```
   Or, without `bmaptool`:
   ```
   xzcat Yocto/<target>/images/linux/rootfs.wic.xz \
       | sudo dd of=/dev/sdX bs=4M status=progress conv=fsync
   ```
4. **Copy `BOOT.BIN` onto the first partition.** The image leaves the first FAT32 partition
   without a boot image, and the BootROM only loads `BOOT.BIN` from there; without this step the
   board does not boot (nothing at all appears on the UART):
   ```
   sudo partprobe /dev/sdX
   sudo mkdir -p /mnt/sd_esp
   sudo mount /dev/sdX1 /mnt/sd_esp
   sudo cp Yocto/<target>/images/linux/BOOT.BIN /mnt/sd_esp/BOOT.BIN
   sync
   sudo umount /mnt/sd_esp && sudo rmdir /mnt/sd_esp
   ```
5. Eject the card cleanly so that all writes are flushed: `sudo eject /dev/sdX`.

If you use the zip from `bootimages/`, run the same commands on `rootfs.wic.xz`,
`rootfs.wic.bmap` and `BOOT.BIN` from the zip.

## Boot

1. Plug the SD card into the board and set the board to boot from the SD card. The boot-mode
   switch settings are the same as for PetaLinux; see [Boot PetaLinux](petalinux.md#boot-petalinux)
   and the board's user guide.
2. Plug the [Ethernet FMC] into the board's FMC connector (see the
   [target designs](build_instructions.md#target-designs) table for the connector) and check that
   its voltage variant matches the board's VADJ
   ([Choosing the FMC variant](requirements.md#choosing-the-fmc-variant)).
3. Connect the ports you want to use to your network or PC.
4. Connect the USB-UART to your PC and open a terminal emulator at 115200 baud (8N1), see
   [UART terminal](petalinux.md#uart-terminal). On the PYNQ-ZU the console is the second of the two
   serial ports that the board's USB-UART creates.
5. Power up the board.

The boot takes about 30 seconds from power-on to the login prompt. A boot on the PYNQ-ZU looks like
this (shortened):

```
U-Boot 2025.01 ...

CPU:   ZynqMP
Chip:  zu5
Model: TUL PYNQ-ZU RevB
DRAM:  2 GiB (effective 4 GiB)
...
Bootmode: SD_MODE
Net:
ZYNQ GEM: ff0e0000, mdio bus ff0e0000, phyaddr 8, interface gmii
ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 8, interface gmii
ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 8, interface gmii
ZYNQ GEM: ff0b0000, mdio bus ff0b0000, phyaddr 8, interface gmii
...
Found U-Boot script /boot.scr
...
[    0.000000] Linux version 6.12.40-xilinx-...
[    0.000000] Kernel command line: earlycon console=ttyPS0,115200 clk_ignore_unused init_fatal_sh=1 root=/dev/mmcblk0p3 ro rootwait uio_pdrv_genirq.of_id=generic-uio cma=1536M
[    2.190370] macb ff0b0000.ethernet eth0: Cadence GEM rev 0x50070106 at 0xff0b0000 irq 44 (00:0a:35:00:01:22)
[    2.216109] macb ff0c0000.ethernet eth1: Cadence GEM rev 0x50070106 at 0xff0c0000 irq 45 (00:0a:35:00:01:23)
[    2.241858] macb ff0d0000.ethernet eth2: Cadence GEM rev 0x50070106 at 0xff0d0000 irq 46 (00:0a:35:00:01:24)
[    2.267498] macb ff0e0000.ethernet eth3: Cadence GEM rev 0x50070106 at 0xff0e0000 irq 47 (00:0a:35:00:01:25)

Welcome to AMD Embedded Development Framework Linux distribution 25.11.1+release-... (scarthgap)!

[    3.810715] systemd[1]: Hostname set to <pynqzu-zynqgem-2025-2>.
...
[    6.650358] macb ff0d0000.ethernet end1: renamed from eth2
[    6.667891] macb ff0b0000.ethernet end3: renamed from eth0
[    6.686063] macb ff0c0000.ethernet end2: renamed from eth1
[    6.702032] macb ff0e0000.ethernet end0: renamed from eth3
...
[  OK  ] Started Serial Getty on ttyPS0.
[  OK  ] Reached target Multi-User System.

pynqzu-zynqgem-2025-2 login:
```

On the PYNQ-ZU, U-Boot also prints `failed to set vqmmc-voltage to 3.3V` three times before it
starts the kernel; the boot continues normally.

## Log in

Log in as `amd-edf`. There is no password the first time; you are asked to choose one straight away:

```
pynqzu-zynqgem-2025-2 login: amd-edf
You are required to change your password immediately (administrator enforced).
New password:
Retype new password:
```

Use `sudo` (with the password you chose) for commands that need root. Once a port has an address,
you can also log in over SSH: `ssh amd-edf@<board address>`.

## Use and test the Ethernet FMC ports

Every wired port that has a link gets an address by DHCP. List them, and identify each port by its
MAC address:

```
ip -br addr
ip -br link
```

On the Zynq UltraScale+ targets FMC port 0 is `end3` and FMC port 3 is `end0`; the full table for
every target, and how to check the link, read the PHY registers and measure the throughput with
`iperf3` (with the results to expect), are on the [Using and testing the ports](testing.md) page.

On the Zynq-7000 targets the board's own Ethernet port is available too (`end3`, MAC
`00:0a:35:00:01:26`), and on `zcu102_hpc1` the ZCU102's own port is `end0`.

## Wi-Fi on the PYNQ-ZU

The PYNQ-ZU has no Ethernet port of its own, but it has on-board Wi-Fi (a Microchip WILC3000 on the
PS SD1 interface). The Yocto image for `pynqzu` supports it as a Wi-Fi station (client):

* the kernel's `wilc1000-sdio` driver with WILC3000 support added, and the WILC3000 firmware
  (`atmel/wilc3000_wifi_firmware-1.bin`, version 16.1.2);
* `wpa_supplicant`, `wpa_cli`, `wpa_passphrase` and `iw`;
* a `wpa_supplicant@wlan0` service that starts when `wlan0` appears, and a `systemd-networkd`
  configuration that requests an address by DHCP on `wlan0` once it has associated;
* the `wifi-sta-setup` helper.

The image contains **no Wi-Fi credentials**. Until you set them up, `wlan0` stays down and the
radio firmware is not loaded.

### Connect to a network

Run `wifi-sta-setup` with the network name (SSID) and, optionally, your two-letter country code
(regulatory domain; the default is `US`). It reads the passphrase from its standard input, so that
the passphrase never appears on the command line. For example, to type the passphrase without it
being shown on the screen:

```
read -rs PSK; printf '%s\n' "$PSK" | sudo wifi-sta-setup '<SSID>' CA; unset PSK
```

(type the passphrase after the first command and press Enter). For an open network, use
`sudo wifi-sta-setup --open '<SSID>' CA`.

`wifi-sta-setup` writes `/etc/wpa_supplicant/wpa_supplicant-wlan0.conf` (readable by root only,
with the passphrase stored as a PSK hash, not in plain text), restarts `wpa_supplicant@wlan0`, and
waits up to 60 seconds for a DHCP address. On success it prints the address:

```
wlan0 up: 192.168.2.179/24
```

The first connection takes about 7 seconds. From then on the board connects by itself at every boot,
about 12 seconds after the kernel starts, and has a DHCP address a few seconds later. The wired
ports keep priority for the default route (route metric 10, `wlan0` 20).

To check the connection:

```
wpa_cli -i wlan0 status        # wpa_state=COMPLETED when connected
iw dev wlan0 link              # signal level and bit rate
ip -br addr show wlan0
```

To change the network, run `wifi-sta-setup` again. To stop using Wi-Fi, delete
`/etc/wpa_supplicant/wpa_supplicant-wlan0.conf` and run `sudo systemctl stop wpa_supplicant@wlan0`.
To write the configuration by hand instead, start from
`/etc/wpa_supplicant/wpa_supplicant-wlan0.conf.example`.

### What to expect

The Wi-Fi throughput depends on your access point and the radio environment. As an example, with an
access point on 2.4 GHz channel 6 at -45 dBm (72 Mbit/s link rate):

| Test | Result |
|------|--------|
| `ping -I wlan0` to a PC on the same LAN | 0% loss, average round trip 2.8 ms |
| `iperf3` board to PC | 17 Mbit/s |
| `iperf3` PC to board | 37 Mbit/s |

Wi-Fi power saving is switched off by the `wpa_supplicant@wlan0` service, to keep the latency low.

## BSP changes and fixes

The per-board changes of the Yocto flow live under `Yocto/bsp/` (the full list is on the
[Advanced](advanced.md#yocto-side) page). The ones that change what you see on the board:

* **Ethernet FMC PHY wiring.** The external PHYs are not in the XSA, so each target adds a
  port-configuration overlay that gives every active port its MAC address, PHY and MDIO bus (and,
  on Zynq UltraScale+, the GMII-to-RGMII converter at MDIO address 8).
* **Kernel arguments and hostname.** The EDF boot flow ignores the usual kernel-argument settings,
  so the board's arguments (console and `clk_ignore_unused` on Zynq-7000, the `cma=` size on all
  boards) were missing and the hostname was the generic `amd-edf`. The board arguments are now added
  to `boot.scr`, and every image has its own hostname, `<board>-zynqgem-2025-2`.
* **Zynq-7000: kernel did not boot.** The generated device tree lost the `xlnx,zynq-7000`
  compatible string, so the kernel did not recognise the Zynq and stopped during early clock setup.
  The board file puts the compatible string back.
* **Zynq-7000: board Ethernet port.** The board's own port (GEM0) is now described in the device
  tree (PHY and MAC address `00:0a:35:00:01:26`) instead of being disabled. Disabling it was a
  workaround for a U-Boot crash on a GEM without a PHY description, which a described PHY avoids.
  The same change is in the PetaLinux BSPs.
* **ZC706: board PHY address.** The ZC706's board PHY is at MDIO address 7, not 0 as on the
  ZedBoard and PicoZed. A ZC706 device-tree file corrects it; because it must override the shared
  port-configuration overlay, the build includes it after the overlay.
* **ZCU104: FMC not powered.** The stock FSBL never switched on the FMC VADJ supply on the ZCU104,
  so no FMC port could work. The FSBL is patched to read the voltage record from the FMC card's
  EEPROM and enable VADJ.
* **ZynqMP serial console.** The generated device tree numbered the UARTs so that `ttyPS0` was
  not the USB-UART on some boards; the board files fix the UART numbering so that the console is
  always `ttyPS0`.
* **PYNQ-ZU: Wi-Fi.** WILC3000 support added to the kernel's `wilc1000` driver, with its firmware
  and the station setup described above. Two further fixes make the first connection reliable:
  * A station query sent by the network manager while `wlan0` was still down (before the radio
    firmware had ever been started) was left queued in the driver and broke the following firmware
    start, so the first attempt to bring Wi-Fi up failed with "WLAN initialization FAILED" (a second
    attempt worked). The driver now refuses such requests until the firmware runs.
  * `wlan0` is now brought up only by `wpa_supplicant`, once credentials exist, and the service
    retries the bring-up once if it fails.
* **PYNQ-ZU: serial console.** The image no longer starts a login prompt on the second PS UART
  (`ttyPS1`), which is not connected to the USB-UART on the PYNQ-ZU; that login service kept failing
  and left the system in the "degraded" state.

[Ethernet FMC]: https://docs.opsero.com/op031/datasheet/overview/
[supported Linux distributions]: https://docs.amd.com/r/en-US/ug1144-petalinux-tools-reference-guide/Setting-Up-Your-Environment
