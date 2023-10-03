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
4. **Windows users only:** In a text editor, open the `Vivado/build-<target>.bat` file for
   the design that you wish to update, and update the tools version number to the one you are using 
   (eg. 2022.1).

After completing the above, you should now be able to use the [build instructions](build_instructions) to
build the Vivado project. If there were no significant changes to the tools and/or IP, the build script 
should succeed and you will be able to open and generate a bitstream.

## PetaLinux

The main procedure for updating the PetaLinux project is to update the BSP for the target platform.
The BSP files for each supported target platform are contained in the `PetaLinux/bsp` directory.

1. Download and install the PetaLinux release that you intend to use.
2. Download and install the BSP for the target platform for the release that you intend to use.

   * For MicroZed, PicoZed, ZedBoard, UltraZed-EG and UltraZed-EV contact your [Avnet rep](https://www.avnet.com)
   * For ZC706, ZCU102, ZCU104 and ZCU106, download the BSP from the 
     [Xilinx downloads] page
   * For PYNQ-ZU, there is a PetaLinux BSP maintainted in the [PYNQ-ZU Git repo](https://github.com/Xilinx/PYNQ-ZU)

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

1. Append the following line after `/include/ "system-conf.dtsi"` in `project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi`:

```
/include/ "port-config.dtsi"
```

2. Append the following line after `SRC_URI += "file://system-user.dtsi"` in `project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend`:

```
SRC_URI += "file://port-config.dtsi"
```

### Add kernel configs

This BSP modification applies to all target platforms.

1. Add the following lines to the top of file `project-spec/meta-user/recipes-kernel/linux/linux-xlnx/bsp.cfg`:

```
# Required by all designs
CONFIG_XILINX_GMII2RGMII=y

# Required by BSP
```

### Mods for ZCU104

These modifications are specific to the ZCU104 BSP.

1. Append the following lines to `project-spec/configs/config`:

```
# ZCU104 port configs

CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_0_SELECT=y
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_1_SELECT=n
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_2_SELECT=n
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_3_SELECT=n
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_0_USE_DHCP=y
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_1_USE_DHCP=y
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_2_USE_DHCP=y
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_3_USE_DHCP=y
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_0_MAC="00:0a:35:00:22:01"
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_1_MAC="00:0a:35:00:22:02"
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_2_MAC="00:0a:35:00:22:03"
CONFIG_SUBSYSTEM_ETHERNET_PSU_ETHERNET_3_MAC="00:0a:35:00:22:04"
```
   
2. Add patch for FSBL to `project-spec/meta-user/recipes-bsp/fsbl/`. You will have to update this
   patch for the version of PetaLinux that you are using. Refer to the existing patch files in that
   location for guidance.

### Mods for ZCU106

These modifications are specific to the ZCU106 BSP.

1. Append the following lines to `project-spec/configs/config`. The first option prevents the removal of
   the PL DTB nodes that we need in this design. The second option disables the FPGA manager.

```
# ZCU106 configs

CONFIG_SUBSYSTEM_REMOVE_PL_DTB=n
CONFIG_SUBSYSTEM_FPGA_MANAGER=n
```
   


