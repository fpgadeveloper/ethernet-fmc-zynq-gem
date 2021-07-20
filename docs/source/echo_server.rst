================================
Stand-alone lwIP Echo Server
================================

These reference designs can be used with the stand-alone lwIP echo server application template that is 
part of Vitis; however, some modifications are required. The lwIP library needs some modifications to be able to 
properly configure the Marvell PHYs (88E1510) that are on the Ethernet FMC. The ``Vitis`` directory of the 
source repository contains a script that can be used to setup a Vitis workspace containing the echo server 
application and the modified lwIP library.

The build script does the following:

#. Creates a Vitis workspace in the ``Vitis`` directory of the source repository.
#. Creates a subdirectory called ``embeddedsw`` to be used as a local software repository
   containing the modified lwIP library.
#. Copies the sources from the ``EmbeddedSw`` directory of the repository to the local 
   software repository (``embeddedsw``), then copies any remaining/unmodified sources
   from the Vitis installation directory into the local software repository.
#. Generates a lwIP Echo Server example application for each exported Vivado design
   that is found in the ``Vivado`` directory. Most users will only have one exported
   Vivado design.

Building the Vitis workspace
================================

To build the Vitis workspace and echo server application, you must first generate
the Vivado project hardware design (the bitstream) and export the hardware.
Once the bitstream is generated and exported, then you can build the
Vitis workspace using the provided ``Vitis/build-vitis.tcl`` script.

Windows users
-------------

To build the Vitis workspace, Windows users can run the ``build-vitis.bat`` file which
launches the Tcl script.

Linux users
-----------

Linux users must use the following commands to run the build script:

.. code-block::

  cd <path-to-repo>/Vitis
  /<path-to-xilinx-tools>/Vitis/2020.2/bin/xsct build-vitis.tcl

Run the application
===================

#. Open Xilinx Vitis.
#. Power up your hardware platform and ensure that the JTAG is
   connected properly.
#. In the Vitis Explorer panel, double-click on the System project that you want to run -
   this will reveal the applications contained in the project. The System project will have 
   the postfix "_system".
#. Now click on the application that you want to run. It should have the postfix "_echo_server".
#. Select the option "Run Configurations" from the drop-down menu contained under the Run
   button on the toolbar (play symbol).
#. Double-click on "Single Application Debug" to create a run configuration for this 
   application. Then click "Run".

The run configuration will first program the FPGA with the bitstream, then load and run the 
application. You can view the UART output of the application in a console window.

UART settings
=============

To receive the UART output of this standalone application, you will need to connect the
USB-UART of the development board to your PC and run a console program such as 
`Putty`_. The following UART settings must be used:

* 115200 baud

IP address
==========

By default, the echo server attempts to obtain an IP address from a DHCP server. This is useful
if the echo server is connected to a network. Once the IP address is obtained, it is printed out
in the UART console output.

If instead the echo server is connected directly to a PC, the DHCP attempt will fail and the echo
server's IP address will default to 192.168.1.10. To be able to communicate with the echo server
from the PC, the PC should be configured with a fixed IP address on the same subnet, for example:
192.168.1.20.

Change the targetted port
=========================

The echo server example design currently can only target one Ethernet port at a time.
Selection of the Ethernet port can be changed by modifying the defines contained in the
``platform_config.h`` file in the application sources. Set ``PLATFORM_EMAC_BASEADDR``
to one of the following values:

ZedBoard, MicroZed and PicoZed designs
--------------------------------------

* Ethernet FMC Port 0: ``XPAR_AXIETHERNET_0_BASEADDR``
* Ethernet FMC Port 1: ``XPAR_AXIETHERNET_1_BASEADDR``
* Ethernet FMC Port 2: ``XPAR_AXIETHERNET_2_BASEADDR``
* Ethernet FMC Port 3: ``XPAR_XEMACPS_1_BASEADDR``
* On-board Ethernet port: ``XPAR_XEMACPS_0_BASEADDR``

ZCU102 design (HPC0)
--------------------

* Ethernet FMC Port 0: ``XPAR_XEMACPS_0_BASEADDR``
* Ethernet FMC Port 1: ``XPAR_XEMACPS_1_BASEADDR``
* Ethernet FMC Port 2: ``XPAR_XEMACPS_2_BASEADDR``
* Ethernet FMC Port 3: ``XPAR_XEMACPS_3_BASEADDR``
* ZCU102's on-board Ethernet port: Not usable

ZCU102 design (HPC1)
--------------------

* Ethernet FMC Port 0: ``XPAR_XEMACPS_0_BASEADDR``
* Ethernet FMC Port 1: ``XPAR_XEMACPS_1_BASEADDR``
* Ethernet FMC Port 2: ``XPAR_XEMACPS_2_BASEADDR``
* ZCU102's on-board Ethernet port: ``XPAR_XEMACPS_3_BASEADDR``

ZCU106 design (HPC0)
--------------------

* Ethernet FMC Port 0: ``XPAR_XEMACPS_0_BASEADDR``
* Ethernet FMC Port 1: ``XPAR_XEMACPS_1_BASEADDR``
* Ethernet FMC Port 2: ``XPAR_XEMACPS_2_BASEADDR``
* Ethernet FMC Port 3: ``XPAR_XEMACPS_3_BASEADDR``
* ZCU106's on-board Ethernet port: Not usable

ZCU106 design (HPC1)
--------------------

* Ethernet FMC Port 0: ``XPAR_XEMACPS_0_BASEADDR``
* Ethernet FMC Port 1: ``XPAR_XEMACPS_1_BASEADDR``
* Ethernet FMC Port 2: Not usable
* ZCU106's on-board Ethernet port: ``XPAR_XEMACPS_3_BASEADDR``

UltraZed, TE0808 design
-----------------------

* Ethernet FMC Port 0: ``XPAR_XEMACPS_0_BASEADDR``
* Ethernet FMC Port 1: ``XPAR_XEMACPS_1_BASEADDR``
* Ethernet FMC Port 2: ``XPAR_XEMACPS_2_BASEADDR``
* Ethernet FMC Port 3: ``XPAR_XEMACPS_3_BASEADDR``
* On-board Ethernet port: Not usable

BSP Setting
-----------

* When using ports that use AXI Ethernet IP, the BSP setting ``use_axieth_on_zynq`` must be set to 1.
* When using ports that use Zynq GEM, the BSP setting ``use_axieth_on_zynq`` must be set to 0.

To change BSP settings: right click on the BSP and click ``Board Support Package Settings`` from the context menu.

Example usage
=============

Ping the port
-------------

The echo server can be "pinged" from a connected PC, or if connected to a network, from
another device on the network. The UART console output will tell you what the IP address of the 
echo server is. To ping the echo server, use the ``ping`` command from a command console of a PC
that is connected to the echo server (either directly or via network).

Example command: ``ping 192.168.1.10``

Connect with telnet
-------------------

We can also connect to the echo server using telnet and confirm that it is sending back (echoing) the data
that we are sending it. From the command prompt of a PC on the same network as the echo server, run the
following command:

Example command: ``telnet 192.168.1.10 7``

The first argument of the telnet command specifies the IP address of the device to connect to (in our case
the echo server). The last argument in the command specifies the port number, which should be 7 for the 
echo server.

In the blank screen that opens after running the command, you can type letters and they will be sent to the 
echo server and be echoed back.

Patches
=======

TEBF0808 ZynqMP FSBL patch
--------------------------

The FSBL for the TEBF0808 board needs some modifications to enable certain clocks before the bitstream is loaded 
and application/OS is launched. To incorporate the modifications, this repo contains a modified version of the 
ZynqMP FSBL in the ``EmbeddedSw`` directory. The Vitis build script sets the ``EmbeddedSw`` directory as a local software 
repository, thus all ZynqMP applications in the workspace use the modified ZynqMP FSBL. However, the TEBF0808 
specific modifications are braced with ``#if defined`` statements so that they are only applied to the TEBF0808 design.

UltraZed EG psu_init patch
--------------------------

Since tool version 2020.1, the psu_init sequence contains a function called ``serdes_illcalib()`` which hangs when 
executed on the UltraZed EG SoM. We have not yet been able to determine why this function hangs on the UltraZed 
EG SoM, but the current workaround is to bypass the function call.

To patch the ``psu_init.c`` file containing the function call, we've added code to the ``build-vitis.tcl`` script to modify 
the file after it has been automatically generated by Vitis. If you manually create a platform project for the 
UltraZed EG project (uz_pci_qgige), you will have to manually open the ``psu_init.c`` file and comment out the function 
call to ``serdes_illcalib()``.


.. _Putty: https://www.putty.org

