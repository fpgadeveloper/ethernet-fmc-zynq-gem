# PetaLinux

PetaLinux can be built for these reference designs by using the Makefile in the `PetaLinux` directory
of the repository.

## Requirements

To build the PetaLinux projects, you will need a physical or virtual machine running one of the 
[supported Linux distributions] as well as the Vitis Core Development Kit installed.

```{attention} You cannot build the PetaLinux projects in the Windows operating system. Windows
users are advised to use a Linux virtual machine to build the PetaLinux projects.
```

## How to build

1. From a command terminal, clone the Git repository and `cd` into it.
   ```
   git clone https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem.git
   cd ethernet-fmc-zynq-gem
   ```
2. Launch PetaLinux by sourcing the `settings.sh` bash script, eg:
   ```
   source <path-to-installed-petalinux>/settings.sh
   ```
3. Launch Vivado by sourcing the `settings64.sh` bash script, eg:
   ```
   source <vivado-install-dir>/settings64.sh
   ```
4. Build the Vivado and PetaLinux project for your specific target platform by running the following
   commands and replacing `<target>` with one of the target labels listed in the target designs table
   in the build instructions.
   ```
   cd PetaLinux
   make petalinux TARGET=<target>
   ```
   
The last command will launch the build process for the corresponding Vivado project if that project
has not already been built and it's hardware exported.

## Boot from SD card

### Prepare the SD card

Once the build process is complete, you must prepare the SD card for booting PetaLinux.

1. The SD card must first be prepared with two partitions: one for the boot files and another 
   for the root file system.

   * Plug the SD card into your computer and find it's device name using the `dmesg` command.
     The SD card should be found at the end of the log, and it's device name should be something
     like `/dev/sdX`, where `X` is a letter such as a,b,c,d, etc. Note that you should replace
     the `X` in the following instructions.
     
```{warning} Do not continue these steps until you are certain that you have found the correct
device name for the SD card. If you use the wrong device name in the following steps, you risk
losing data on one of your hard drives.
```
   * Run `fdisk` by typing the command `sudo fdisk /dev/sdX`
   * Make the `boot` partition: typing `n` to create a new partition, then type `p` to make 
     it primary, then use the default partition number and first sector. For the last sector, type 
     `+1G` to allocate 1GB to this partition.
   * Make the `boot` partition bootable by typing `a`
   * Make the `root` partition: typing `n` to create a new partition, then type `p` to make 
     it primary, then use the default partition number, first sector and last sector.
   * Save the partition table by typing `w`
   * Format the `boot` partition (FAT32) by typing `sudo mkfs.vfat -F 32 -n boot /dev/sdX1`
   * Format the `root` partition (ext4) by typing `sudo mkfs.ext4 -L root /dev/sdX2`

2. Copy the following files to the `boot` partition of the SD card:
   Assuming the `boot` partition was mounted to `/media/user/boot`, follow these instructions:
   ```
   $ cd /media/user/boot/
   $ sudo cp /<petalinux-project>/images/linux/BOOT.BIN .
   $ sudo cp /<petalinux-project>/images/linux/boot.scr .
   $ sudo cp /<petalinux-project>/images/linux/image.ub .
   ```

3. Create the root file system by extracting the `rootfs.tar.gz` file to the `root` partition.
   Assuming the `root` partition was mounted to `/media/user/root`, follow these instructions:
   ```
   $ cd /media/user/root/
   $ sudo cp /<petalinux-project>/images/linux/rootfs.tar.gz .
   $ sudo tar xvf rootfs.tar.gz -C .
   $ sync
   ```
   
   Once the `sync` command returns, you will be able to eject the SD card from the machine.

### Boot PetaLinux

1. Plug the SD card into your target board.
2. Ensure that the target board is configured to boot from SD card:
   * **PicoZed:** DIP switch SW1 (on the SoM) is set to 11 (1=ON,2=ON)
   * **ZedBoard:** Jumpers MIO6-2 must be set to 01100
   * **ZC706:** DIP switch SW11 must be set to 00110 (1=OFF,2=OFF,3=ON,4=ON,5=OFF)
   * **UltraZed-EG PCI:** DIP switch SW2 (on the SoM) is set to 1000 (1=ON,2=OFF,3=OFF,4=OFF)
   * **UltraZed-EV:** DIP switch SW2 (on the SoM) is set to 1000 (1=ON,2=OFF,3=OFF,4=OFF)
   * **PYNQ-ZU:** Switch labelled "JTAG SD" must be flipped to the right (towards "SD")
   * **ZCU10x:** DIP switch SW6 must be set to 1000 (1=ON,2=OFF,3=OFF,4=OFF)
   * **ZCU111:** DIP switch SW6 must be set to 1000 (1=ON,2=OFF,3=OFF,4=OFF)
   * **ZCU208:** DIP switch SW2 must be set to 1000 (1=ON,2=OFF,3=OFF,4=OFF)
3. Connect the [Ethernet FMC] to the FMC connector of the target board.
4. Connect the USB-UART to your PC and then open a UART terminal set to 115200 baud and the 
   comport that corresponds to your target board.
5. Connect and power your hardware.

## Boot via JTAG

```{tip} You need to install the cable drivers before being able to boot via JTAG.
Note that the Vitis installer does not automatically install the cable drivers, it must be done separately.
For instructions, read section 
[installing the cable drivers](https://docs.amd.com/r/en-US/ug973-vivado-release-notes-install-license/Installing-Cable-Drivers) 
from the Vivado release notes.
```

```{warning} If you boot the Zynq-7000, Zynq UltraScale+ or Zynq RFSoC designs via JTAG, you must still
first prepare the SD card. The reason is because these designs are configured to use the SD card to store
the root filesystem. If you boot these designs via JTAG without preparing and connecting the SD card, the
boot will hang during at a message similar to this: `Waiting for root device /dev/mmcblk0p2...`
```

### Setup hardware

1. Prepare the SD card according to the [instructions above](#prepare-the-sd-card) and plug the SD card 
   into your target board.
2. Ensure that the target board is configured to boot from JTAG:
   * **PicoZed:** DIP switch SW1 (on the SoM) is set to 00 (1=OFF,2=OFF)
   * **ZedBoard:** Jumpers MIO6-2 must be set to 00000
   * **ZC706:** DIP switch SW11 must be set to 00000 (1=OFF,2=OFF,3=OFF,4=OFF,5=OFF)
   * **UltraZed-EG PCI:** DIP switch SW2 (on the SoM) is set to 1111 (1=ON,2=ON,3=ON,4=ON)
   * **UltraZed-EV:** DIP switch SW2 (on the SoM) is set to 1111 (1=ON,2=ON,3=ON,4=ON)
   * **PYNQ-ZU:** Switch labelled "JTAG SD" must be flipped to the left (towards "JTAG")
   * **ZCU10x:** DIP switch SW6 must be set to 1111 (1=ON,2=ON,3=ON,4=ON)
   * **ZCU111:** DIP switch SW6 must be set to 1111 (1=ON,2=ON,3=ON,4=ON)
   * **ZCU208:** DIP switch SW2 must be set to 1111 (1=ON,2=ON,3=ON,4=ON)
3. Connect the [Ethernet FMC] to the FMC connector of the target board.
4. Connect the USB-UART to your PC and then open a UART terminal set to 115200 baud and the 
   comport that corresponds to your target board.
5. Connect and power your hardware.

### Boot PetaLinux

To boot PetaLinux on hardware via JTAG, use the following commands in a Linux command terminal:

1. Change current directory to the PetaLinux project directory for your target design:
   ```
   cd <project-dir>/PetaLinux/<target>
   ```
2. Download bitstream to the FPGA:
   ```
   petalinux-boot --jtag --kernel --fpga
   ```

An explanation of the above command is provided by the `petalinux-boot` command:
```none
For microblaze, it will download the bitstream to target board, and
then boot the kernel image on target board.
For Zynq, it will download the bitstream and FSBL to target board,
and then boot the u-boot and then the kernel on target
board.
For Zynq UltraScale+, it will download the bitstream, PMUFW and FSBL,
and then boot the kernel with help of linux-boot.elf to set kernel
start and dtb addresses.
```

## UART terminal

You will need to setup a terminal emulator to use the PetaLinux command line over the USB-UART connection.
Connect with a baud rate of 115200.

### In Windows

You will need to find the comport for the USB-UART in Windows Device Manager. As a terminal emulator, you
can use the open source and free [Putty](https://www.putty.org/).

### In Linux

In Linux, you can find the USB-UART device by running `dmesg | grep tty`. Typically, the device will be
`/dev/ttyUSB0` or it could be followed by a different number. To open a terminal emulator, you can use
the following command:

```
sudo screen /dev/ttyUSB0 115200
```

## Port configurations

### PicoZed, ZC702, ZC706, ZedBoard

* eth0: Ethernet port of the dev board (GEM0)
* eth1: Ethernet FMC Port 3 (GEM1)
* eth2: Ethernet FMC Port 0 (AXI Ethernet)
* eth3: Ethernet FMC Port 1 (AXI Ethernet)
* eth4: Ethernet FMC Port 2 (AXI Ethernet)

### ZCU104, ZCU102 (HPC0), ZCU106 (HPC0)

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: Ethernet FMC Port 2 (GEM2)
* eth3: Ethernet FMC Port 3 (GEM3)

Note that the Ethernet port of the dev board in these designs is not connected to any GEM and is
thus unusable.

### ZCU102 (HPC1)

* eth0: Ethernet FMC Port 0 (GEM0)
* eth1: Ethernet FMC Port 1 (GEM1)
* eth2: Ethernet FMC Port 2 (GEM2)
* eth3: ZCU102 on-board Ethernet port (GEM3)

## Example Usage

### Enable port

This example will bring up a port.

```
root@zynqgem:~# sudo ifconfig eth1 up
[  378.871550] pps pps1: new PPS source ptp1
[  378.875583] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
[  382.943505] macb ff0c0000.ethernet eth1: unable to generate target frequency: 125000000 Hz
[  382.951774] macb ff0c0000.ethernet eth1: link up (1000/Full)
[  382.957441] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
```

### Enable port with fixed IP address

This example sets a fixed IP address to a port.

```
root@zynqgem:~# sudo ifconfig eth1 192.168.2.31 up
[  424.839768] pps pps1: new PPS source ptp1
[  424.843798] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
[  428.927505] macb ff0c0000.ethernet eth1: unable to generate target frequency: 125000000 Hz
[  428.935778] macb ff0c0000.ethernet eth1: link up (1000/Full)
[  428.941450] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
```

### Enable port using DHCP

This example enables a port and obtains an IP address for the port via DHCP. Note that the
port must be connected to a DHCP enabled router.

```
root@zynqgem:~# sudo udhcpc -i eth1
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
```

### Check port status

In this example, we use the `ifconfig` command with no arguments to check the port status.
The first interface (eth1) is connected to the Ethernet FMC port 0 and it has
been enabled and configured with IP address 192.168.2.23.

```
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
```

We can also use `ethtool` to check the port status as follows.

```
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
```

### Ping link partner using specific port

In this example we ping the link partner at IP address 192.168.2.10 from interface eth1.

```
root@zynqgem:~# ping -I eth0 192.168.2.10
PING 192.168.2.10 (192.168.2.10): 56 data bytes
64 bytes from 192.168.2.10: seq=0 ttl=128 time=0.448 ms
64 bytes from 192.168.2.10: seq=1 ttl=128 time=0.416 ms
64 bytes from 192.168.2.10: seq=2 ttl=128 time=0.418 ms
64 bytes from 192.168.2.10: seq=3 ttl=128 time=0.409 ms
```

[Ethernet FMC]: https://ethernetfmc.com/docs/ethernet-fmc/overview/
[supported Linux distributions]: https://docs.amd.com/r/en-US/ug1144-petalinux-tools-reference-guide/Setting-Up-Your-Environment

