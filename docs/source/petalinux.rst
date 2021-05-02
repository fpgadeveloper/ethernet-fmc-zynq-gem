=========
PetaLinux
=========

PetaLinux can be built for these reference designs by using the script in the ``PetaLinux`` directory
of the repository.

How to build
============

Requirements
------------

* Windows or Linux PC with Vivado installed
* Linux PC or virtual machine with PetaLinux installed

Instructions
------------

1. First generate the Vivado project hardware design(s) (the bitstream) and export the design(s).
2. Launch PetaLinux by sourcing the ``settings.sh`` bash script, eg: ``source <path-to-installed-petalinux>/settings.sh``
3. Build the PetaLinux project(s) by executing the ``build-petalinux`` script in Linux.

The script will generate a separate PetaLinux project for all of the generated and exported Vivado projects that
it finds in the Vivado directory of this repo.

UNIX line endings
=================

The scripts and files in the PetaLinux directory of this repository must have UNIX line endings when they are
executed or used under Linux. The best way to ensure UNIX line endings, is to clone the repo directly onto your
Linux machine. If instead you have copied the repo from a Windows machine, the files will have DOS line endings and
you must use the ``dos2unix`` tool to convert the line endings for UNIX.

#. Copy the cloned repository from your Windows machine to your Linux machine.
#. Use the ``cd`` command to navigate to the copied repository on your Linux machine.
#. Type ``find . -type f -exec dos2unix --keepdate {} +`` to convert all of the files
   to the Unix format.

How the script works
====================

The PetaLinux directory contains a ``build-petalinux`` shell script which can be run in Linux to automatically
generate a PetaLinux project for each of the generated/exported Vivado projects in the Vivado directory.

When executed, the build script searches the Vivado directory for all projects containing a `.xsa` exported
hardware design file. Then for every exported project, the script does the following:

#. Verifies that the ``.bit`` file exists.
#. Determines the CPU type: Zynq or ZynqMP. It does this
   by reading the Vivado project file.
#. Creates a PetaLinux project, referencing the exported hardware design (.xsa).
#. Copies the relevant configuration files from the ``src`` directory into the created
   PetaLinux project.
#. Builds the PetaLinux project.
#. Generates a BOOT.BIN, boot.scr and image.ub file.

Launch PetaLinux on hardware
============================

Via JTAG
--------

To launch the PetaLinux project on hardware via JTAG, connect and power up your hardware and then
use the following commands in a Linux command terminal:

#. Change current directory to the PetaLinux project directory:
   ``cd <petalinux-project-dir>``
#. Download bitstream to the FPGA:
   ``petalinux-boot --jtag --fpga``
   Note that you don't have to specify the bitstream because this command will use the one that it finds
   in the ``./images/linux`` directory.
   
#. Download bitstream to the FPGA: 
   ``petalinux-boot --jtag --fpga --bitstream ./images/linux/system.bit`` If you don't use the --bitstream option to 
   specify the bitstream, then PetaLinux will download the ./images/linux/download.bit bitstream containing the FSBL. 
   We don't want to run the FSBL when booting via JTAG.
#. Download the PetaLinux kernel to the FPGA:
   ``petalinux-boot --jtag --kernel``

Via SD card
-----------

To launch the PetaLinux project on hardware via SD card, copy the following files to the root of the
SD card:

* ``/<petalinux-project>/images/linux/BOOT.bin``
* ``/<petalinux-project>/images/linux/boot.scr``
* ``/<petalinux-project>/images/linux/image.ub``

Then connect and power your hardware.

Configuration files
===================

The configuration files contained in the `src` directory include:

* Device tree
* Rootfs configuration (to include ethtool)
* Interface initializations (sets eth0-4 interfaces to DHCP)
* Kernel configuration
* Board BSPs
* Patches (see below)

ZCU104 ZynqMP FSBL patch
------------------------

The FSBL for Zynq Ultrascale+ needs a patch to properly enable VADJ on the ZCU104 board. The FSBL has 
code to read the FMC card's EEPROM and then enable VADJ to the correct value. The code in fact reads 
from the ZCU104 board's EEPROM and not the FMC's EEPROM. It also only reads 32 bytes from the EEPROM, 
which is not sufficient to include the VADJ voltage data. For both of these reasons, the FSBL does 
not properly enable VADJ on this board.

There is a patch contained in this repo that fixes this issue so that VADJ is correctly enabled on the 
ZCU104 board.

TEBF0808 ZynqMP FSBL patch
--------------------------

The FSBL for the TEBF0808 board needs some modifications to enable certain clocks before the bitstream 
is loaded and application/OS is launched. To incorporate the modifications into the PetaLinux build, 
this repo contains a patch for the FSBL located here:

``<repo>/PetaLinux/src/tebf0808/project-spec/meta-user/recipes-bsp/fsbl/files/tebf0808_fsbl.patch``

Port configurations
===================

MicroZed, PicoZed, ZC702, ZC706, ZedBoard
-----------------------------------------

* eth0: Ethernet port of the dev board (GEM0)
* eth1: Ethernet FMC Port 3 (GEM1)
* eth2: Ethernet FMC Port 0 (AXI Ethernet)
* eth3: Ethernet FMC Port 1 (AXI Ethernet)
* eth4: Ethernet FMC Port 2 (AXI Ethernet)

ZCU104, ZCU102 (HPC0), ZCU106 (HPC0) and TEBF0808
-------------------------------------------------

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: Ethernet FMC Port 2 (GEM2)
* eth3: Ethernet FMC Port 3 (GEM3)

Note that the Ethernet port of the dev board in these designs is not connected to any GEM and is
thus unusable.

ZCU102 (HPC1)
-------------

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: Ethernet FMC Port 2 (GEM2)
* eth3: ZCU102 on-board Ethernet port (GEM3)

ZCU106 (HPC1)
-------------

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: ZCU102 on-board Ethernet port (GEM3)


AXI Ethernet issue on Zynq designs 2020.2
=========================================

There is an issue in the PetaLinux 2020.2 release that affects the **AXI Ethernet** connected ports on
**Zynq** based designs. On these ports, it seems to be necessary to use the following procedure to bring 
up a port. Note that the interface and IP address were chosen as examples, but this procedure applies to 
all AXI Ethernet connected ports (eth2, eth3 and eth4) on the Zynq based designs (MicroZed, PicoZed, 
ZedBoard, ZC702 and ZC706).

.. code-block::

  ifconfig eth0 up
  ifconfig eth0 down
  ifconfig eth0 192.168.1.10 up

In earlier releases, it was only necessary to run the last command to bring up a port. This issue
does not affect the Zynq Ultrascale+ based designs. We have not yet determined the cause of this issue
but if you have any information, please let us know.

