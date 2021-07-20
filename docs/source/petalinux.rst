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

When executed, the build script searches the Vivado directory for all projects containing a ``.xsa`` exported
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

Example Usage
=============

Enable port
-----------

This example will bring up a port.

.. code-block::

   root@zynqgem:~# ifconfig eth1 up
   [  378.871550] pps pps1: new PPS source ptp1
   [  378.875583] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
   [  382.943505] macb ff0c0000.ethernet eth1: unable to generate target frequency: 125000000 Hz
   [  382.951774] macb ff0c0000.ethernet eth1: link up (1000/Full)
   [  382.957441] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready

Enable port with fixed IP address
---------------------------------

This example sets a fixed IP address to a port.

.. code-block::

   root@zynqgem:~# ifconfig eth1 192.168.2.31 up
   [  424.839768] pps pps1: new PPS source ptp1
   [  424.843798] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
   [  428.927505] macb ff0c0000.ethernet eth1: unable to generate target frequency: 125000000 Hz
   [  428.935778] macb ff0c0000.ethernet eth1: link up (1000/Full)
   [  428.941450] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready

Enable port using DHCP
----------------------

This example enables a port and obtains an IP address for the port via DHCP. Note that the
port must be connected to a DHCP enabled router.

.. code-block::

   root@zynqgem:~# udhcpc -i eth1
   udhcpc: started, v1.31.0
   [  314.831199] macb ff0c0000.ethernet eth1: unable to generate target frequency: 125000000 Hz
   [  314.839489] macb ff0c0000.ethernet eth1: link up (1000/Full)
   [  314.845181] pps pps1: new PPS source ptp1
   [  314.849205] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
   [  314.855955] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
   udhcpc: sending discover
   udhcpc: sending select for 192.168.2.24
   udhcpc: lease of 192.168.2.24 obtained, lease time 259200
   RTNETLINK answers: File exists
   /etc/udhcpc.d/50default: Adding DNS 192.168.2.1

Check port status
-----------------

In this example, we use the ``ifconfig`` command with no arguments to check the port status.
The first interface (eth1) is connected to the Ethernet FMC port 0 and it has
been enabled and configured with IP address 192.168.2.23.

.. code-block::

   root@zynqgem:~# ifconfig
   eth0      Link encap:Ethernet  HWaddr 00:0A:35:00:01:22
             inet addr:192.168.2.23  Bcast:192.168.2.255  Mask:255.255.255.0
             inet6 addr: fe80::20a:35ff:fe00:122/64 Scope:Link
             UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
             RX packets:5 errors:0 dropped:0 overruns:0 frame:0
             TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:1000
             RX bytes:794 (794.0 B)  TX bytes:2000 (1.9 KiB)
             Interrupt:30
   
   lo        Link encap:Local Loopback
             inet addr:127.0.0.1  Mask:255.0.0.0
             inet6 addr: ::1/128 Scope:Host
             UP LOOPBACK RUNNING  MTU:65536  Metric:1
             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:1000
             RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

We can also use ``ethtool`` to check the port status as follows.

.. code-block::

   root@zynqgem:~# ethtool eth0
   Settings for eth0:
           Supported ports: [ TP MII FIBRE ]
           Supported link modes:   10baseT/Half 10baseT/Full
                                   100baseT/Half 100baseT/Full
                                   1000baseT/Half 1000baseT/Full
           Supported pause frame use: Symmetric Receive-only
           Supports auto-negotiation: Yes
           Supported FEC modes: Not reported
           Advertised link modes:  10baseT/Half 10baseT/Full
                                   100baseT/Half 100baseT/Full
                                   1000baseT/Half 1000baseT/Full
           Advertised pause frame use: No
           Advertised auto-negotiation: Yes
           Advertised FEC modes: Not reported
           Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                                100baseT/Half 100baseT/Full
                                                1000baseT/Full
           Link partner advertised pause frame use: No
           Link partner advertised auto-negotiation: Yes
           Link partner advertised FEC modes: Not reported
           Speed: 1000Mb/s
           Duplex: Full
           Port: MII
           PHYAD: 0
           Transceiver: internal
           Auto-negotiation: on
           Link detected: yes

Ping link partner using specific port
-------------------------------------

In this example we ping the link partner at IP address 192.168.2.10 from interface eth1.

.. code-block::

   root@zynqgem:~# ping -I eth0 192.168.2.10
   PING 192.168.2.10 (192.168.2.10): 56 data bytes
   64 bytes from 192.168.2.10: seq=0 ttl=128 time=0.448 ms
   64 bytes from 192.168.2.10: seq=1 ttl=128 time=0.416 ms
   64 bytes from 192.168.2.10: seq=2 ttl=128 time=0.418 ms
   64 bytes from 192.168.2.10: seq=3 ttl=128 time=0.409 ms

Known Issues
============

AXI Ethernet issue on Zynq designs 2020.2
-----------------------------------------

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
does not affect the Zynq Ultrascale+ based designs. This issue does not affect the stand-alone echo server
operation. We have not yet determined the cause of this issue
but if you have any information, please let us know.

