ethernet-fmc-zynq-gem
=====================

Example design for using the [Quad Gigabit Ethernet FMC](http://ethernetfmc.com "Ethernet FMC") with the Zynq PS hard 
Gigabit Ethernet MACs (GEM) and the GMII-to-RGMII IP.

### Supported boards

* Zynq-7000 [ZedBoard](http://zedboard.org "ZedBoard")
  * LPC connector (use zedboard.xdc)
* [MicroZed FMC Carrier](http://zedboard.org/product/microzed-fmc-carrier "MicroZed FMC Carrier") with [MicroZed 7Z010 or 7Z020](http://microzed.org "MicroZed")
  * LPC connector (use mzfmc-7z010.xdc or mzfmc-7z020.xdc)
* Zynq UltraScale+ [ZCU102 Evaluation board Rev 1.0](http://www.xilinx.com/products/silicon-devices/soc/zynq-ultrascale-mpsoc.html "ZCU102 Evaluation board Rev 1.0")
  * HPC0 connector (use zcu102-hpc0.xdc)
  * HPC1 connector (use zcu102-hpc1.xdc)

### Description

This project demonstrates the use of the Opsero [Quad Gigabit Ethernet FMC](http://ethernetfmc.com "Ethernet FMC").
The design demonstrates use of the GMII-to-RGMII IP core to connect the hard GEMs of the Zynq PS to the Ethernet FMC
PHYs. All designs use the hard GEMs but some also use AXI Ethernet Subsystem IP.

![Ethernet FMC Quad Gig AXI Ethernet](http://ethernetfmc.com/wp-content/uploads/2014/10/qgige_gmii_to_rgmii.png "Zynq Quad Gig Ethernet All AXI Ethernet")

### Requirements

* Vivado 2016.4
* [Ethernet FMC](http://ethernetfmc.com "Ethernet FMC")
* One of the above listed Zynq boards
* For designs containing AXI Ethernet Subsystem IP: [Xilinx Soft TEMAC license](http://ethernetfmc.com/getting-a-license-for-the-xilinx-tri-mode-ethernet-mac/ "Xilinx Soft TEMAC license")

### Build instructions

To use the sources in this repository, please follow these steps:

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

The software application used to test these projects is the lwIP Echo Server example that is built into
Xilinx SDK. The application relies on the lwIP library (also built into Xilinx SDK) but with a few modifications.
The modified version of the lwIP library is contained in the `EmbeddedSw` directory, which is added as a
local SDK repository to the SDK workspace. See the readme in the SDK directory for more information.

### Board specific notes

#### ZCU102

* This design supports the ZCU102 Rev 1.0 board. Use a commit before 2016-02-13 for the older Rev-D board design.
Note that the FMC pinouts differ between Rev 1.0 and Rev D: https://www.xilinx.com/support/answers/68050.html
* This design uses 3x GEMs to connect to ports 0-2 of the Ethernet FMC. The 4th port is left unconnected.

#### ZedBoard and MicroZed

When changing `ETH_FMC_PORT` from 0-2 to 3 (ie. when switching to GEM1), it has been noticed that
you have to power cycle the board. When the SDK project is configured for AXI Ethernet, it must make some
Zynq configurations that are not compatible with the GEM1 configuration.

#### MicroZed

##### Uses Zynq Fabric clocks

To generate the 125MHz and 200MHz clocks required by the AXI Ethernet IPs, this design uses two Zynq
fabric clocks rather than using the Ethernet FMC's on-board 125MHz clock. Generally this is due to resource
limitations of the MicroZed 7Z010, but to be more specific:

* Using the on-board 125MHz clock + Zynq fabric 200MHz clock leads to a timing closure problem that I have not
yet been able to get around.
* Using the on-board 125MHz clock into a clock wizard to generate the 200MHz clock is not possible due to the Zynq 7Z010
only containing two MMCMs.

##### Installation of MicroZed board definition files

To use this project, you must first install the board definition files
for the MicroZed into your Vivado installation.

The following folders contain the board definition files and can be found in this project repository at this location:

https://github.com/fpgadeveloper/microzed-qgige/tree/master/Vivado/boards/board_files

* `microzed_7010`
* `microzed_7020`

Copy those folders and their contents into the `C:\Xilinx\Vivado\2016.4\data\boards\board_files` folder (this may
be different on your machine, depending on your Vivado installation directory).

#### Single port limit

The echo server example design currently can only target one Ethernet port at a time.
Selection of the Ethernet port can be changed by modifying the defines contained in the
`platform_config.h` file in the application sources. Set `PLATFORM_EMAC_BASEADDR`
to one of the following values depending on the port you want to target, and the hardware platform:

##### ZedBoard and MicroZed designs

* Ethernet FMC Port 0: `XPAR_AXIETHERNET_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_AXIETHERNET_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_AXIETHERNET_2_BASEADDR`
* Ethernet FMC Port 3: `XPAR_XEMACPS_1_BASEADDR`

##### ZCU102 designs (HPC0 and HPC1)

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_XEMACPS_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_XEMACPS_2_BASEADDR`

##### BSP Setting

* When using ports that use AXI Ethernet IP, the BSP setting "use_axieth_on_zynq" must be set to 1.
* When using ports that use Zynq GEM, the BSP setting "use_axieth_on_zynq" must be set to 0.

To change BSP settings: right click on the BSP and click `Board Support Package Settings` from the context menu.

### License

Feel free to modify the code for your specific application.

### About us

This project was developed by [Opsero Inc.](http://opsero.com "Opsero Inc."),
a tight-knit team of FPGA experts delivering FPGA products and design services to start-ups and tech companies. 
Follow our blog, [FPGA Developer](http://www.fpgadeveloper.com "FPGA Developer"), for news, tutorials and
updates on the awesome projects we work on.