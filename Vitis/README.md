Vitis Project files
===================

### Important patch for Vitis 2019.2

To use the build script in this directory, you must first apply the following patch
to your Vitis installation:

https://www.xilinx.com/support/answers/73252.html

### How to build the Vitis workspace

In order to make use of these source files, you must first generate
the Vivado project hardware design (the bitstream) and export the hardware.
Check the `Vivado` folder for instructions on doing this from Vivado.

Once the bitstream is generated and exported, then you can build the
Vitis workspace using the provided `build-vitis.tcl` script.

### Scripted build

The Vitis directory contains a `build-vitis.tcl` script which can be run to automatically
generate the Vitis workspace. Windows users can run the `build-vitis.bat` file which
launches the Tcl script. Linux users must use the following commands to run the build
script:
```
cd <path-to-repo>/Vitis
/<path-to-xilinx-tools>/Vitis/2019.2/bin/xsct build-vitis.tcl
```

The build script does three things:

1. Prepares a local Vitis repository containing a modified version of lwIP library,
required by the echo server example application.
2. Adds the ../EmbeddedSw directory as a local Vitis repository.
3. Generates a lwIP Echo Server example application for each exported Vivado design
that is found in the ../Vivado directory. Most users will only have one exported
Vivado design.

### Run the application

1. Open Xilinx Vitis.
2. Power up your hardware platform and ensure that the JTAG is
connected properly.
3. Select Xilinx Tools->Program FPGA. You only have to do this
once, each time you power up your hardware platform.
4. Click Run from the toolbar to run your application. You can modify the code
and click Run as many times as you like, without going through
the other steps.

### How to change the Ethernet port targetted by the application

The echo server example design currently can only target one Ethernet port at a time.
Selection of the Ethernet port can be changed by modifying the defines contained in the
`platform_config.h` file in the application sources. Set `PLATFORM_EMAC_BASEADDR`
to one of the following values:

#### ZedBoard and MicroZed designs

* Ethernet FMC Port 0: `XPAR_AXIETHERNET_0_BASEADDR`
* Ethernet FMC Port 1: `XPAR_AXIETHERNET_1_BASEADDR`
* Ethernet FMC Port 2: `XPAR_AXIETHERNET_2_BASEADDR`
* Ethernet FMC Port 3: `XPAR_XEMACPS_1_BASEADDR`

#### ZCU102 designs (HPC0 and HPC1)

* Ethernet FMC Port 0: `XPAR_XEMACPS_0_BASEADDR`
* Ethernet FMC Port 2: `XPAR_XEMACPS_1_BASEADDR`

##### BSP Setting

* When using ports that use AXI Ethernet IP, the BSP setting "use_axieth_on_zynq" must be set to 1.
* When using ports that use Zynq GEM, the BSP setting "use_axieth_on_zynq" must be set to 0.

To change BSP settings: right click on the BSP and click `Board Support Package Settings` from the context menu.

#### TEBF0808 ZynqMP FSBL patch

The FSBL for the TEBF0808 board needs some modifications to enable certain clocks before the bitstream
is loaded and application/OS is launched. To incorporate the modifications, this repo contains a
modified version of the ZynqMP FSBL in the `EmbeddedSw` directory. The Vitis build script
sets the `EmbeddedSw` directory as a local software repository, thus all ZynqMP applications in the workspace
use the modified ZynqMP FSBL. However, the TEBF0808 specific modifications are braced with `#if defined` statements
so that they are only applied to the TEBF0808 design.

The Vitis build script also changes the compiler options of the FSBL for this board.
