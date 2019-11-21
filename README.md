ethernet-fmc-zynq-gem
=====================

Example design for using the [Quad Gigabit Ethernet FMC](http://ethernetfmc.com "Ethernet FMC") with the Zynq/ZynqUS+ PS hard 
Gigabit Ethernet MACs (GEM) and the GMII-to-RGMII IP.

![Ethernet FMC](http://ethernetfmc.com/wp-content/uploads/2015/07/zedboard_eth_fmc_3.jpg "Ethernet FMC")

## Requirements

This project is designed for version 2019.2 of the Xilinx tools (Vivado/SDK/PetaLinux). If you are using an older version of the 
Xilinx tools, then refer to the [release tags](https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem/releases "releases")
to find the version of this repository that matches your version of the tools.

* Vivado 2019.2
* [Ethernet FMC](http://ethernetfmc.com "Ethernet FMC")
* One of the below listed Zynq or Zynq Ultrascale+ boards
* For designs containing AXI Ethernet Subsystem IP: [Xilinx Soft TEMAC license](http://ethernetfmc.com/getting-a-license-for-the-xilinx-tri-mode-ethernet-mac/ "Xilinx Soft TEMAC license")

## Supported boards

* Zynq-7000 [ZedBoard](http://zedboard.org "ZedBoard")
  * LPC connector
* [MicroZed FMC Carrier](http://zedboard.org/product/microzed-fmc-carrier "MicroZed FMC Carrier") with [MicroZed 7020](http://microzed.org "MicroZed")
  * LPC connector
* Zynq-7000 [PicoZed FMC Carrier Card V2](http://zedboard.org/product/picozed-fmc-carrier-card-v2 "PicoZed FMC Carrier Card V2") with [PicoZed 7030](http://picozed.org "PicoZed")
  * LPC connector
* Zynq-7000 [ZC706 Evaluation board](http://www.xilinx.com/products/boards-and-kits/ek-z7-zc706-g.html "ZC706 Evaluation board") (LPC only)
  * LPC connector
* Zynq UltraScale+ [ZCU102 Evaluation board Rev 1.0](http://www.xilinx.com/products/silicon-devices/soc/zynq-ultrascale-mpsoc.html "ZCU102 Evaluation board Rev 1.0")
  * HPC0 connector
  * HPC1 connector (3 ports only)
* Zynq UltraScale+ [ZCU104 Evaluation board](https://www.xilinx.com/products/boards-and-kits/zcu104.html "ZCU104 Evaluation board")
  * LPC connector
* Zynq UltraScale+ [ZCU106 Evaluation board](https://www.xilinx.com/products/boards-and-kits/zcu106.html "ZCU106 Evaluation board")
  * HPC0 connector
  * HPC1 connector (2 ports only)
* Zynq UltraScale+ [UltraZed PCIe Carrier Card](http://zedboard.org/product/ultrazed-pcie-carrier-card "UltraZed PCIe Carrier Card") with [UltraZed-EG](http://zedboard.org/product/ultrazed-EG "UltraZed")
  * LPC connector
* Zynq UltraScale+ [TE0808-04-09-1EE-S Starter Kit](https://shop.trenz-electronic.de/en/TE0808-04-09-1EE-S-TE0808-04-09-1EE-S-Starter-Kit "TE0808-04-09-1EE-S Starter Kit") with [TE0808 UltraSOM+ MPSoC Module](https://shop.trenz-electronic.de/en/TE0808-04-09EG-1EE-UltraSOM-MPSoC-Module-with-Zynq-UltraScale-XCZU9EG-1FFVC900E-4-GB-DDR4 "TE0808 SoM")
  * HPC connector

## Description

This project demonstrates the use of the Opsero [Quad Gigabit Ethernet FMC](http://ethernetfmc.com "Ethernet FMC").
The design demonstrates use of the GMII-to-RGMII IP core to connect the hard GEMs of the Zynq PS to the Ethernet FMC
PHYs. All designs use the hard GEMs but some also use AXI Ethernet Subsystem IP.

![Ethernet FMC Quad Gig AXI Ethernet](http://ethernetfmc.com/wp-content/uploads/2014/10/qgige_gmii_to_rgmii.png "Zynq Quad Gig Ethernet All AXI Ethernet")

## Build instructions

To use the sources in this repository, please follow these steps:

### Windows users

1. Download the repo as a zip file and extract the files to a directory
   on your hard drive --OR-- Git users: clone the repo to your hard drive
2. Open Windows Explorer, browse to the repo files on your hard drive.
3. In the Vivado directory, you will find multiple batch files (*.bat).
   Double click on the batch file that is appropriate to your hardware,
   for example, double-click `build-zedboard.bat` if you are using the ZedBoard.
   This will generate a Vivado project for your hardware platform.
4. Run Vivado and open the project that was just created.
5. Click Generate bitstream.
6. When the bitstream is successfully generated, select `File->Export->Export Hardware`.
   In the window that opens, tick "Include bitstream" and "Local to project".
7. Return to Windows Explorer and browse to the SDK directory in the repo.
8. Double click the `build-sdk.bat` batch file. The batch file will run the
   `build-sdk.tcl` script and build the SDK workspace containing the hardware
   design and the software application.
9. Run Xilinx SDK (DO NOT use the Launch SDK option from Vivado) and select the workspace to be the SDK directory of the repo.
10. Select `Project->Build automatically`.
11. Connect and power up the hardware.
12. Open a Putty terminal to view the UART output.
13. In the SDK, select `Xilinx Tools->Program FPGA`.
14. Right-click on the application and select `Run As->Launch on Hardware (System Debugger)`

### Linux users

1. Download the repo as a zip file and extract the files to a directory
   on your hard drive --OR-- Git users: clone the repo to your hard drive
2. Launch the Vivado GUI.
3. Open the Tcl console from the Vivado welcome page. In the console, `cd` to the repo files
   on your hard drive and into the Vivado subdirectory. For example: `cd /media/projects/ethernet-fmc-zynq-gem/Vivado`.
3. In the Vivado subdirectory, you will find multiple Tcl files. To list them, type `exec ls {*}[glob *.tcl]`.
   Determine the Tcl script for the example project that you would like to generate (for example: `build-zcu104.tcl`), 
   then `source` the script in the Tcl console: For example: `source build-zcu104.tcl`
4. Vivado will run the script and generate the project. When it's finished, click Generate bitstream.
5. When the bitstream is successfully generated, select `File->Export->Export Hardware`.
   In the window that opens, tick "Include bitstream" and "Local to project".
6. To build the SDK workspace, open a Linux command terminal and `cd` to the SDK directory in the repo.
7. The SDK directory contains the `build-sdk.tcl` script that will build the SDK workspace containing the hardware design and
   the software application. Run the build script by typing the following command: 
   `<path-of-xilinx-sdk>/bin/xsdk -batch -source build-sdk.tcl`. Note that you must replace `<path-of-xilinx-sdk>` with the 
   actual path to your Xilinx SDK installation.
8. Run Xilinx SDK (DO NOT use the Launch SDK option from Vivado) and select the workspace to be the SDK subdirectory of the 
   repo.
10. Select `Project->Build automatically`.
11. Connect and power up the hardware.
12. Open a Putty terminal to view the UART output.
13. In the SDK, select `Xilinx Tools->Program FPGA`.
14. Right-click on the application and select `Run As->Launch on Hardware (System Debugger)`

## Stand-alone software application

The software application used to test these projects is the lwIP Echo Server example that is built into
Xilinx SDK. The application relies on the lwIP library (also built into Xilinx SDK) but with a few modifications.
The modified version of the lwIP library is contained in the `EmbeddedSw` directory, which is added as a
local SDK repository to the SDK workspace. See the "README.md" file in the SDK directory for more information.

## PetaLinux

This repo contains a script and configuration files for a PetaLinux project for each one of the hardware platforms. To build
the PetaLinux project, please refer to the "README.md" file in the PetaLinux subdirectory of this repo.

## Board specific notes

### ZCU106

* The HPC0 connector on this board supports all 4 ports of the Ethernet FMC. This design uses up all 4 GEMs,
leaving the ZCU106's on-board Ethernet port unusable.
* The HPC1 connector only has LA00-LA16 pins connected to the FPGA, therefore our example can only
support 2 ports of the Ethernet FMC. The ZCU106's on-board Ethernet port connects to GEM3 and is usable in this design.

### ZCU102

* This design supports the ZCU102 Rev 1.0 board. Use a commit before 2017/02/13 for the older Rev-D board design.
Note that the FMC pinouts differ between Rev 1.0 and Rev D: https://www.xilinx.com/support/answers/68050.html
* The HPC0 design uses 4x GEMs to connect to ports 0-3 of the Ethernet FMC. This design uses up all 4 GEMs,
leaving the ZCU102's on-board Ethernet port unusable.
* The HPC1 design uses 3x GEMs to connect to ports 0-2 of the Ethernet FMC. The 4th port is left unconnected
because certain pins required by the Ethernet FMC (namely LA30, LA31 and LA32) are left unconnected 
on the HPC1 connector of the ZCU102 board. The ZCU102's on-board Ethernet port connects to GEM3 and is usable
in this design.

### UltraZed

* The UltraZed design uses 4x GEMs to connect to ports 0-3 of the Ethernet FMC. This design uses up all 4 GEMs,
leaving the UltraZed PCIe Card's on-board Ethernet port unusable.

### Trenz TE0808 Starter Kit

The base board TEBF0808 has a DIP switch that must be set correctly to enable VADJ of 1.8V. Set S5-4 to ON in order
to set VADJ to 1.8V.

This design uses up all 4 GEMs, leaving the TEBF0808's on-board Ethernet port unusable.

### ZedBoard, MicroZed and PicoZed

When changing `ETH_FMC_PORT` from 0-2 to 3 (ie. when switching to GEM1), it has been noticed that
you have to power cycle the board. When the SDK project is configured for AXI Ethernet, it must make some
Zynq configurations that are not compatible with the GEM1 configuration.

The on-board Ethernet port on all of these designs is connected to GEM0 and is usable.

### Installation of MicroZed, PicoZed, UltraZed, TE0808 board definition files

To use the projects for the MicroZed, PicoZed and UltraZed, you must first install the board definition files
for those boards into your Vivado and Xilinx SDK installation.

The following folders contain the board definition files and can be found in this project repository at this location:

https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem/tree/master/Vivado/boards/board_files

* `microzed_7020`
* `picozed_7030_fmc2`
* `ultrazed_3eg_pciecc`
* `TE0808_9EG_1E`

Copy those folders and their contents into the `C:\Xilinx\Vivado\2019.2\data\boards\board_files` folder (this may
be different on your machine, depending on your Vivado installation directory). You also need to make a copy into the
Xilinx SDK installation at this location: `C:\Xilinx\SDK\2019.2\data\boards\board_files`.

### Single port limit

The echo server example design currently can only target one Ethernet port at a time.
Selection of the Ethernet port can be changed by modifying the defines contained in the
`platform_config.h` file in the application sources. Set `PLATFORM_EMAC_BASEADDR`
to one of the following values depending on the port you want to target, and the hardware platform:

#### ZedBoard, MicroZed and PicoZed designs

* Ethernet FMC Port 0: `XPAR_AXIETHERNET_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_AXIETHERNET_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_AXIETHERNET_2_BASEADDR`
* Ethernet FMC Port 3: `XPAR_XEMACPS_1_BASEADDR`
* On-board Ethernet port: `XPAR_XEMACPS_0_BASEADDR`

#### ZCU102 design (HPC0)

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_XEMACPS_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_XEMACPS_2_BASEADDR`
* Ethernet FMC Port 3: `XPAR_XEMACPS_3_BASEADDR`
* ZCU102's on-board Ethernet port: Not usable

#### ZCU102 design (HPC1)

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_XEMACPS_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_XEMACPS_2_BASEADDR`
* ZCU102's on-board Ethernet port: `XPAR_XEMACPS_3_BASEADDR`

#### ZCU106 design (HPC0)

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_XEMACPS_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_XEMACPS_2_BASEADDR`
* Ethernet FMC Port 3: `XPAR_XEMACPS_3_BASEADDR`
* ZCU106's on-board Ethernet port: Not usable

#### ZCU106 design (HPC1)

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_XEMACPS_1_BASEADDR`
* Ethernet FMC Port 2: Not usable
* ZCU106's on-board Ethernet port: `XPAR_XEMACPS_3_BASEADDR`

#### UltraZed, TE0808 design

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_XEMACPS_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_XEMACPS_2_BASEADDR`
* Ethernet FMC Port 3: `XPAR_XEMACPS_3_BASEADDR`
* On-board Ethernet port: Not usable

#### BSP Setting

* When using ports that use AXI Ethernet IP, the BSP setting "use_axieth_on_zynq" must be set to 1.
* When using ports that use Zynq GEM, the BSP setting "use_axieth_on_zynq" must be set to 0.

To change BSP settings: right click on the BSP and click `Board Support Package Settings` from the context menu.

## Troubleshooting

Check the following if the project fails to build or generate a bitstream:

### 1. Are you using the correct version of Vivado for this version of the repository?
Check the version specified in the Requirements section of this readme file. Note that this project is regularly maintained to the latest
version of Vivado and you may have to refer to an earlier commit of this repo if you are using an older version of Vivado.

### 2. Did you correctly follow the Build instructions in this readme file?
All the projects in the repo are built, synthesised and implemented to a bitstream before being committed, so if you follow the
instructions, there should not be any build issues.

### 3. Did you copy/clone the repo into a short directory structure?
Vivado doesn't cope well with long directory structures, so copy/clone the repo into a short directory structure such as
`C:\projects\`. When working in long directory structures, you can get errors relating to missing files, particularly files 
that are normally generated by Vivado (FIFOs, etc).

## For more information

If you need more information on whether the Ethernet FMC is compatible with your carrier, please contact me [here](http://ethernetfmc.com/contact/ "Ethernet FMC Contact form").
Just provide me with the pinout of your carrier and I'll be happy to check compatibility and generate a Vivado constraints file for you.

## License

Feel free to modify the code for your specific application.

## About us

This project was developed by [Opsero Inc.](http://opsero.com "Opsero Inc."),
a tight-knit team of FPGA experts delivering FPGA products and design services to start-ups and tech companies. 
Follow our blog, [FPGA Developer](http://www.fpgadeveloper.com "FPGA Developer"), for news, tutorials and
updates on the awesome projects we work on.