# Revision History

## 2025.2 Changes

### Yocto flow, board Ethernet ports, PYNQ-ZU Wi-Fi

* Added the Yocto / AMD EDF flow for every Zynq-7000 and Zynq UltraScale+ target
  (`./build.sh yocto --target <target>`), producing a full SD card image
  (`rootfs.wic.xz`) and a `bootimages/*_yocto-2025-2.zip`. See [Yocto](yocto.md).
* Yocto images: the board's kernel arguments (console on Zynq-7000, `cma=` size) are now added to
  the boot script (they were missing before), and each image has its own hostname
  (`<board>-zynqgem-2025-2`). `ethtool`, `phytool` and `iperf3` are included.
* Zynq-7000 (ZedBoard, PicoZed, ZC706): the board's own Ethernet port (GEM0) is now described in
  the device tree (PHY and MAC address) instead of being disabled, in both the PetaLinux and the
  Yocto images, so it can be used next to the four FMC ports. The ZC706's board PHY is at MDIO
  address 7 and is described as such.
* Zynq-7000 Yocto images: fixed a kernel panic during early boot (the generated device tree lacked
  the `xlnx,zynq-7000` compatible string).
* ZCU104 Yocto image: the FSBL is patched to enable the FMC VADJ supply, as in the PetaLinux and
  standalone flows; without it no FMC port works.
* PYNQ-ZU Yocto image: on-board Wi-Fi (WILC3000) as a station, with `wifi-sta-setup`. The first
  Wi-Fi bring-up no longer fails when the network manager queries the interface before the radio
  firmware has started; `wlan0` is raised only by `wpa_supplicant`, with one retry. No login
  prompt on `ttyPS1` any more (it kept failing and left the system "degraded").
* `package` rewrites a boot image zip when the artifacts are newer than the zip (it used to keep
  shipping an old zip after a rebuild).
* Documentation: new block diagrams generated from the block design (the Zynq-7000 diagram had GEM0
  and GEM1 swapped), new [Using and testing the ports](testing.md) page with the interface names
  and expected `iperf3` results, how-to guides for the standalone, PetaLinux and Yocto flows,
  FMC voltage variant guidance and troubleshooting.

### Tool update

* Updated for Vivado / Vitis / PetaLinux 2025.2.
* Vitis flow migrated to the universal Python driver (`Vitis/py/build-vitis.py`)
  with per-target workspace layout and SDT-mode platforms.
* PetaLinux BSPs reorganised under `PetaLinux/bsp/<board>` and
  `PetaLinux/bsp/ports-<config>` overlays; per-target projects composed
  at build time by `PetaLinux/Makefile`.
* Added top-level `Makefile` that produces SD-card-ready boot zips under
  `bootimages/`.
* Workarounds applied for known 2025.2 quirks on Zynq-7000: PS `gem0`
  disabled in `system-user.dtsi` to avoid a U-Boot data abort caused by
  a missing `phy-handle` in `pcw.dtsi` (superseded: `gem0` is now
  described with its PHY, see above); `cma=256M` instead of the stock
  template's `cma=1536M`; explicit DDR size in `configs/config` to
  override the stock 2 GiB default on boards with 512 MiB / 1 GiB.
* UltraZed-EG / UltraZed-EV BSPs use `cma=1000M` and route the rootfs
  through PSU SD1 (`mmcblk1p2`).
* PetaLinux predictable interface names: ZynqMP ports appear as
  `end0`–`end3`; Zynq-7000 ports as `enx<mac>`.

## 2024.1 Changes

* Improved documentation, centralized target design info to a JSON file

## 2022.1 Changes

* Added Makefiles to improve the build experience for Linux users
* Consolidated Vivado batch files (user is prompted to select target design)
* Vitis build script now creates a separate workspace for each target design (improved user experience)
* Converted documentation to markdown (from reStructuredText)
* Removed the unnecessary postfix _qgige from all designs
* Removed design for MicroZed FMC carrier (Avnet has discontinued the product).
* Removed design for TEBF0808 due to errors when applying the board preset:
```
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
INFO: [PSU-1]  DP_AUDIO clock source: RPLL is also being used by other peripheral clocks. Their outputs may get impacted if any driver changes DP_AUDIO PLL source to support runtime audio change 
INFO: [PSU-0] Address Range of DDR (0x7ff00000 to 0x7fffffff) is reserved by PMU for internal purpose.
ERROR: [IP_Flow 19-3478] Validation failed for parameter 'SD0 IO(PSU__SD0__PERIPHERAL__IO)' with value 'EMIO' for BD Cell 'zynq_ultra_ps_e_0'. PARAM PSU__SD0__PERIPHERAL__IO :: MIO 13 .. 22 is out of range { EMIO,MIO 13 .. 16 21 22,MIO 38 .. 44,MIO 64 .. 70 }
ERROR: [IP_Flow 19-3478] Validation failed for parameter 'POW IO(PSU__SD0__GRP_POW__IO)' with value 'EMIO' for BD Cell 'zynq_ultra_ps_e_0'. PARAM PSU__SD0__GRP_POW__IO :: MIO 23 is out of range { EMIO }
INFO: [IP_Flow 19-3438] Customization errors found on 'zynq_ultra_ps_e_0'. Restoring to previous valid configuration.
ERROR: [Common 17-39] 'set_property' failed due to earlier errors.
ERROR: [BD 41-1273] Error running apply_rule TCL procedure: ERROR: [Common 17-39] 'set_property' failed due to earlier errors.
    ::xilinx.com_bd_rule_zynq_ultra_ps_e::apply_rule Line 29
INFO: [BD 5-145] Automation rule xilinx.com:bd_rule:zynq_ultra_ps_e was not applied to object zynq_ultra_ps_e_0
apply_bd_automation: Time (s): cpu = 00:00:08 ; elapsed = 00:00:06 . Memory (MB): peak = 9306.859 ; gain = 4.980 ; free physical = 506141 ; free virtual = 510967
INFO: [Common 17-17] undo 'apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]'
ERROR: [Common 17-39] 'apply_bd_automation' failed due to earlier errors.
```
* Removed design for ZCU106 HPC1 connector because it only supports two ports and those two ports have sub-optimal placement 
  for a global clock-capable IO pin and BUFG pair, which leads to poor timing performance.

