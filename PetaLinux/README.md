PetaLinux Project source files
==============================

### How to build the PetaLinux projects

#### Requirements

* Windows or Linux PC with Vivado installed
* Linux PC or virtual machine with PetaLinux installed

#### Instructions

In order to make use of these source files, you must:

1. First generate the Vivado project hardware design(s) (the bitstream) and export the design(s) to SDK.
2. Launch PetaLinux by sourcing the `settings.sh` bash script, eg: `source <path-to-installed-petalinux>/settings.sh`
3. Build the PetaLinux project(s) by executing the `build-petalinux` script in Linux.

The script will generate a separate PetaLinux project for all of the generated and exported Vivado projects that
it finds in the Vivado directory of this repo.

### UNIX line endings

The scripts and files in the PetaLinux directory of this repository must have UNIX line endings when they are
executed or used under Linux. The best way to ensure UNIX line endings, is to clone the repo directly onto your
Linux machine. If instead you have copied the repo from a Windows machine, the files will have DOS line endings and
you must use the `dos2unix` tool to convert the line endings for UNIX.

1. Copy the cloned repository from your Windows machine to your Linux machine.
2. Use the `cd` command to navigate to the copied repository on your Linux machine.
3. Type `find . -type f -exec dos2unix --keepdate {} +` to convert all of the files
to the Unix format.

### How the script works

The PetaLinux directory contains a `build-petalinux` shell script which can be run in Linux to automatically
generate a PetaLinux project for each of the generated/exported Vivado projects in the Vivado directory.

When executed, the build script searches the Vivado directory for all projects containing `*.sdk` sub-directories.
This locates all projects that have been exported to SDK. Then for every exported project, the script
does the following:

1. Verifies that the `.hdf` and the `.bit` files exist.
2. Determines the CPU type: Zynq or ZynqMP. It currently does this
by looking at the first 3 letters of the project name.
3. Creates a PetaLinux project, referencing the exported hardware design (.hdf).
4. Copies the relevant configuration files from the `src` directory into the created
PetaLinux project.
5. Builds the PetaLinux project.
6. Generates a BOOT.bin and image.ub file.

### Launch PetaLinux on hardware

#### Via JTAG

To launch the PetaLinux project on hardware via JTAG, connect and power up your hardware and then
use the following commands in a Linux command terminal:

1. Change current directory to the PetaLinux project directory:
`cd <petalinux-project-dir>`
2. Download bitstream to the FPGA:
`petalinux-boot --jtag --fpga`
Note that you don't have to specify the bitstream because this command will use the one that it finds
in the `./images/linux` directory.
3. Download the PetaLinux kernel to the FPGA:
`petalinux-boot --jtag --kernel`

#### Via SD card (Zynq)

To launch the PetaLinux project on hardware via SD card, copy the following files to the root of the
SD card:

* `/<petalinux-project>/images/linux/BOOT.bin`
* `/<petalinux-project>/images/linux/image.ub`

Then connect and power your hardware.

### Configuration files

The configuration files contained in the `src` directory include:

* Device tree
* Rootfs configuration (to include ethtool)
* Interface initializations (sets eth0-4 interfaces to DHCP)
* Kernel configuration
* AXI Ethernet driver patch

#### AXI Ethernet driver patch

The AXI Ethernet driver requires a patch for the correct configuration of the RGMII interface's 
RX and TX clock skews.

https://github.com/Xilinx/linux-xlnx/blob/master/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

```		} else if (lp->phy_type == XAE_PHY_TYPE_RGMII_2_0) {
			phydev = of_phy_connect(lp->ndev, lp->phy_node,
						axienet_adjust_link, 0,
						PHY_INTERFACE_MODE_RGMII_ID);
```

The section of the code shown above specifies `PHY_INTERFACE_MODE_RGMII_ID` as the RGMII interface
mode (aka "rgmii-id"). That interface mode enables both the RX and TX clock delays in the PHY but in 
fact we need to enable only the RX delay 
(see http://ethernetfmc.com/rgmii-interface-timing-considerations/ for more information).

Our device tree specifies the correct RGMII configuration with the phy-mode setting ("rgmii-rxid"),
and we have access to this setting via the `lp->phy_interface` variable. So to correct the issue, we
replace the above code with the following:

```		} else if (lp->phy_type == XAE_PHY_TYPE_RGMII_2_0) {
			phydev = of_phy_connect(lp->ndev, lp->phy_node,
						axienet_adjust_link, 0,
						lp->phy_interface);
```

The included patch handles this modification - you do not need to manually modify any code.

#### ZCU104 ZynqMP FSBL patch for 2019.1

The FSBL for Zynq Ultrascale+ needs a patch to properly enable VADJ on the ZCU104 board in the 2019.1
version of PetaLinux. The FSBL released with this version of PetaLinux has code to read the FMC card's
EEPROM and then enable VADJ to the correct value. The released FSBL code in fact reads from the ZCU104
board's EEPROM and not the FMC's EEPROM. It also only reads 32 bytes from the EEPROM, which is not 
sufficient to include the VADJ voltage data. For both of these reasons, the FSBL does not properly 
enable VADJ on this board. 

There is a patch contained in this repo that fixes this issue so that VADJ is correctly enabled on
the ZCU104 board.

#### TEBF0808 ZynqMP FSBL patch

The FSBL for the TEBF0808 board needs some modifications to enable certain clocks before the bitstream
is loaded and application/OS is launched. To incorporate the modifications into the PetaLinux build, 
this repo contains a patch for the FSBL located here:

`<repo>/PetaLinux/src/tebf0808/project-spec/meta-user/recipes-bsp/fsbl/files/tebf0808_fsbl.patch`

### Port configurations

#### MicroZed, PicoZed, ZC702, ZC706, ZedBoard

* eth0: Ethernet port of the dev board (GEM0)
* eth1: Ethernet FMC Port 3 (GEM1)
* eth2: Ethernet FMC Port 0 (AXI Ethernet)
* eth3: Ethernet FMC Port 1 (AXI Ethernet)
* eth4: Ethernet FMC Port 2 (AXI Ethernet)

#### ZCU104, ZCU102 (HPC0), ZCU106 (HPC0) and TEBF0808

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: Ethernet FMC Port 2 (GEM2)
* eth3: Ethernet FMC Port 3 (GEM3)

Note that the Ethernet port of the dev board in these designs is not connected to any GEM and is
thus unusable.

#### ZCU102 (HPC1)

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: Ethernet FMC Port 2 (GEM2)
* eth3: ZCU102 on-board Ethernet port (GEM3)

#### ZCU106 (HPC1)

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: ZCU102 on-board Ethernet port (GEM3)
