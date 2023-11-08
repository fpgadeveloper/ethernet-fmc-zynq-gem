# Updating the projects

This section contains instructions for updating the reference designs. It is intended as a guide
for anyone wanting to attempt updating the designs for a tools release that we do not yet support.
Note that the update process is not always straight-forward and sometimes requires dealing with
new issues or significant changes to the functionality of the tools and/or specific IP. Unfortunately, 
we cannot always provide support if you have trouble updating the designs.

## Vivado projects

1. Download and install the Vivado release that you intend to use.
2. In a text editor, open the `Vivado/scripts/build.tcl` file and perform the following changes:
   * Update the `version_required` variable value to the tools version number 
     that you are using.
   * Update the year in all references to `Vivado Synthesis <year>` to the 
     tools version number that you are using. For example, if you are using tools
     version 2022.1, then the `<year>` should be 2022.
   * Update the year in all references to `Vivado Implementation <year>` to the 
     tools version number that you are using. For example, if you are using tools
     version 2022.1, then the `<year>` should be 2022.
3. In a text editor, open the `Vivado/scripts/xsa.tcl` file and perform the following changes:
   * Update the `version_required` variable value to the tools version number 
     that you are using.
4. **Windows users only:** In a text editor, open the `Vivado/build-vivado.bat` file and update 
   the tools version number to the one you are using (eg. 2022.1).

After completing the above, you should now be able to use the [build instructions](build_instructions) to
build the Vivado project. If there were no significant changes to the tools and/or IP, the build script 
should succeed and you will be able to open and generate a bitstream.

## PetaLinux

The main procedure for updating the PetaLinux project is to update the BSP for the target platform.
The BSP files for each supported target platform are contained in the `PetaLinux/bsp` directory.

1. Download and install the PetaLinux release that you intend to use.
2. Download and install the BSP for the target platform for the release that you intend to use.

   * For PicoZed, UltraZed-EG and UltraZed-EV, download the BSP from the [Avnet downloads] page
   * For ZC706, ZCU102, ZCU104 and ZCU106, download the BSP from the 
     [Xilinx downloads] page
   * For PYNQ-ZU, there is a PetaLinux BSP maintainted in the [PYNQ-ZU Git repo](https://github.com/Xilinx/PYNQ-ZU)
   * For the ZedBoard, we use the ZC702 BSP which can be downloaded from the [Xilinx downloads] page

3. Update the BSP files for the target platform in the `PetaLinux/bsp/<platform>` directory. 
   These are the specific directories to update:
   * `<platform>/project-spec/configs/*`
   * `<platform>/project-spec/meta-user/*`   
   The simple way to update the files is to delete the `configs` and `meta-user` folders from the repository
   and copy in those folders from the more recent BSP.
4. Apply the required modifications to the updated BSP files. The modifications are described for each
   target platform in the following sections.
   
### Change project name

This BSP modification applies to all target platforms.

1. Append the following lines to `project-spec/configs/config`:

```
# Set project name
CONFIG_SUBSYSTEM_HOSTNAME="zynqgem"
CONFIG_SUBSYSTEM_PRODUCT="zynqgem"
```
   
Note that this will set the project name to "zynqgem" but you can use a more descriptive name, for example
one that includes the target platform name and the tools version.

### Add tools to root filesystem

This BSP modification applies to all target platforms.

1. Append the following lines to `project-spec/configs/rootfs_config`:

```
# Useful tools for Ethernet FMC
CONFIG_ethtool=y
CONFIG_ethtool-dev=y
CONFIG_ethtool-dbg=y
CONFIG_iperf3=y
```

2. Append the following lines to `project-spec/meta-user/conf/user-rootfsconfig`:

```
CONFIG_iperf3
CONFIG_ethtool
```

### Include port config in device tree

This BSP modification applies to all target platforms.

1. Append the following line after `/include/ "system-conf.dtsi"` in 
   `project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi`:

```
/include/ "port-config.dtsi"
```

2. Append the following line after `SRC_URI:append = " file://config file://system-user.dtsi` in 
   `project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend`:

```
SRC_URI:append = " file://port-config.dtsi"
```

### Add kernel configs

This BSP modification applies to all target platforms.

1. Append the following lines to file `project-spec/meta-user/recipes-kernel/linux/linux-xlnx/bsp.cfg`:

```
# Required by all designs
CONFIG_XILINX_GMII2RGMII=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=y
CONFIG_MARVELL_PHY=y
CONFIG_AMD_PHY=y
CONFIG_XILINX_PHY=y
```

### Mods for all Zynq-7000 designs

The following modifications apply to all the Zynq-7000 based designs (PicoZed, ZC702, ZC706).

1. Append the following lines to `project-spec/configs/config`. These options configure the design
   to use the SD card to store the root filesystem.

```
# SD card for root filesystem

CONFIG_SUBSYSTEM_BOOTARGS_AUTO=n
CONFIG_SUBSYSTEM_USER_CMDLINE="earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/mmcblk0p2 rw rootwait cma=1536M"

CONFIG_SUBSYSTEM_ROOTFS_INITRD=n
CONFIG_SUBSYSTEM_ROOTFS_EXT4=y
CONFIG_SUBSYSTEM_SDROOT_DEV="/dev/mmcblk0p2"
CONFIG_SUBSYSTEM_RFS_FORMATS="tar.gz ext4 ext4.gz "
```

2. Append the following line after `SRC_URI:append = " file://config file://system-user.dtsi` in 
   `project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend`:

```
SRC_URI:append = " file://emacps.patch"
```

3. Add the following EMACs patch to `project-spec/meta-user/recipes-bsp/device-tree/files/emacps.patch`.
   This patch is required to prevent a build error.
   Note that the patch may have to be updated or it may not be necessary in future tool versions.

```
diff --git a/emacps/data/emacps.tcl b/emacps/data/emacps.tcl
index 98f5117..7475ac3 100644
--- a/emacps/data/emacps.tcl
+++ b/emacps/data/emacps.tcl
@@ -166,7 +166,10 @@ proc generate {drv_handle} {
            if {[string match -nocase $node "&gem1"]} {
                 set zynq_periph [get_cells -hier -filter {IP_NAME == processing_system7}]
                 set port0_pins [::hsi::utils::get_sink_pins [get_pins -of_objects [get_cells -hier $zynq_periph] "ENET1_MDIO_O"]]
-                set sink_periph [::hsi::get_cells -of_objects $port0_pins]
+                set sink_periph ""
+                if {[llength $port0_pins]} {
+                    set sink_periph [::hsi::get_cells -of_objects $port0_pins]
+                }
                 if {[llength $sink_periph]} {
                     set ip_name [get_property IP_NAME $sink_periph]
                 }
```

### Mods for all ZynqMP designs

These BSP modifications must be applied to all ZynqMP designs.

1. Append the following lines to `project-spec/configs/config`. These options configure the design
   to use the SD card to store the root filesystem.

```
# SD card for root filesystem

CONFIG_SUBSYSTEM_BOOTARGS_AUTO=n
CONFIG_SUBSYSTEM_USER_CMDLINE="earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/mmcblk0p2 rw rootwait cma=1536M"

CONFIG_SUBSYSTEM_ROOTFS_INITRD=n
CONFIG_SUBSYSTEM_ROOTFS_EXT4=y
CONFIG_SUBSYSTEM_SDROOT_DEV="/dev/mmcblk0p2"
CONFIG_SUBSYSTEM_RFS_FORMATS="tar.gz ext4 ext4.gz "
```

### Mods for PicoZed FMC Carrier v2

These modifications are specific to the PicoZed FMC Carrier v2 BSP.

1. Append the following lines to `project-spec/configs/config`:

```
# PZ configs

CONFIG_YOCTO_MACHINE_NAME="zynq-generic"
CONFIG_USER_LAYER_0=""
CONFIG_SUBSYSTEM_PRIMARY_SD_PSU_SD_0_SELECT=n
CONFIG_SUBSYSTEM_PRIMARY_SD_PSU_SD_1_SELECT=y
CONFIG_SUBSYSTEM_SD_PSU_SD_0_SELECT=n
```

2. Append the following lines to file `project-spec/meta-user/recipes-kernel/linux/linux-xlnx/bsp.cfg`:

```
# Required by PZ BSP
CONFIG_USB_ACM=y
CONFIG_USB_F_ACM=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_CDC_COMPOSITE=m
CONFIG_I2C_XILINX=y
```

### Mods for ZedBoard

These modifications are specific to the ZedBoard BSP.

```{note}
Note that Avnet no longer maintains a BSP for the ZedBoard, so we are instead using the BSP for the ZC702
and making modifications for it to work with the ZedBoard.
```

1. Append the following lines to `project-spec/configs/config`:

```
# ZedBoard configs

CONFIG_YOCTO_MACHINE_NAME="zynq-generic"
```

2. Append the following lines to file `project-spec/meta-user/recipes-kernel/linux/linux-xlnx/bsp.cfg`:

```
# Required by ZedBoard BSP
CONFIG_USB_SUSPEND=y
CONFIG_USB_OTG=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_XUSBPS=y
CONFIG_XILINX_ZED_USB_OTG=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_ETH_RNDIS is not set
CONFIG_USB_ZERO=m
```

### Mods for UltraZed-EG PCIe Carrier

These modifications are specific to the UltraZed-EG PCIe Carrier BSP.

1. Append the following lines to `project-spec/configs/config`:

```
# UZ-EG configs

CONFIG_YOCTO_MACHINE_NAME="zynqmp-generic"
CONFIG_USER_LAYER_0=""
CONFIG_SUBSYSTEM_SDROOT_DEV="/dev/mmcblk1p2"
CONFIG_SUBSYSTEM_USER_CMDLINE=" earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/mmcblk1p2 rw rootwait cma=1000M"
CONFIG_SUBSYSTEM_PRIMARY_SD_PSU_SD_0_SELECT=n
CONFIG_SUBSYSTEM_PRIMARY_SD_PSU_SD_1_SELECT=y
CONFIG_SUBSYSTEM_SD_PSU_SD_0_SELECT=n
```

2. Overwrite the device tree file 
   `project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi` with the one that is in the
   repository.

### Mods for UltraZed-EV Carrier

These modifications are specific to the UltraZed-EV BSP.

1. Append the following lines to `project-spec/configs/config`.

```
# UZ-EV configs

CONFIG_YOCTO_MACHINE_NAME="zynqmp-generic"
CONFIG_USER_LAYER_0=""
CONFIG_SUBSYSTEM_SDROOT_DEV="/dev/mmcblk1p2"
CONFIG_SUBSYSTEM_USER_CMDLINE=" earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/mmcblk1p2 rw rootwait cma=1000M"
CONFIG_SUBSYSTEM_PRIMARY_SD_PSU_SD_0_SELECT=n
CONFIG_SUBSYSTEM_PRIMARY_SD_PSU_SD_1_SELECT=y
CONFIG_SUBSYSTEM_SD_PSU_SD_0_SELECT=n
```

2. Append the following lines to `project-spec/meta-user/conf/petalinuxbsp.conf`.

```
IMAGE_BOOT_FILES:zynqmp = "BOOT.BIN boot.scr Image system.dtb"
```

3. Overwrite the device tree file 
   `project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi` with the one that is in the
   repository.

### Mods for ZCU104

These modifications are specific to the ZCU104 BSP.

1. Add patch for FSBL to `project-spec/meta-user/recipes-bsp/embeddedsw/`. You will have to update this
   patch for the version of PetaLinux that you are using. Refer to the existing patch files in that
   location for guidance.

```
project-spec
           +--- meta-user
                        +--- recipes-bsp
                                       +--- embeddedsw
                                                     +--- files
                                                     |        +--- zcu104_vadj_fsbl.patch
                                                     +--- fsbl-firmware_%.bbappend
```

### Mods for ZCU106

These modifications are specific to the ZCU106 BSP.

1. Append the following lines to `project-spec/configs/config`. The first option prevents the removal of
   the PL DTB nodes that we need in this design. The second option disables the FPGA manager.

```
# ZCU106 configs

CONFIG_SUBSYSTEM_REMOVE_PL_DTB=n
CONFIG_SUBSYSTEM_FPGA_MANAGER=n
```
   


[Xilinx downloads]: https://www.xilinx.com/support/download.html
[Avnet downloads]: https://avnet.me/zedsupport

