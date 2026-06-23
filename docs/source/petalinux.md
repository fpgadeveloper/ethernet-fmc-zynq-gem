# PetaLinux

PetaLinux can be built for these reference designs with the cross-platform `build.py`
runner at the root of the repository.

## Requirements

To build the PetaLinux projects, you will need a physical or virtual machine running one of the 
[supported Linux distributions] as well as the Vitis Core Development Kit installed.

```{attention}
You cannot build the PetaLinux projects in the Windows operating system. Windows
users are advised to use a Linux virtual machine to build the PetaLinux projects.
```

## How to build

The build runner locates and sources the PetaLinux and Vivado settings itself, so there
is no need to source them by hand. See the [build instructions](build_instructions) for
the full description of the runner.

1. From a command terminal, clone the Git repository (with its submodules) and `cd` into it:
   ```
   git clone --recurse-submodules https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem.git
   cd ethernet-fmc-zynq-gem
   ```
2. Build the PetaLinux image for your target by running the following command and replacing
   `<target>` with one of the target design labels found in the build instructions:
   ```
   ./build.sh petalinux --target <target>
   ```

This will also launch the build process for the corresponding Vivado project if that project
has not already been built and its hardware exported.

```{tip}
The top-level `./build.sh all --target <target>` in the repo root
will also drive the Vivado, Vitis, and PetaLinux builds end-to-end and
collect the SD-card-ready outputs into
`bootimages/ethernet-fmc-zynq-gem_<target>_petalinux-2025-2.zip` (and a
companion `_standalone-2025-2.zip` for the Vitis side). The `boot/`
directory inside that zip mirrors the files that the *Boot from SD card*
section below copies to the FAT32 partition.
```

## Boot from SD card

### Prepare the SD card

Once the build process is complete, you must prepare the SD card for booting PetaLinux.

1. The SD card must first be prepared with two partitions: one for the boot files and another 
   for the root file system.

   * Plug the SD card into your computer and find it's device name using the `dmesg` command.
     The SD card should be found at the end of the log, and it's device name should be something
     like `/dev/sdX`, where `X` is a letter such as a,b,c,d, etc. Note that you should replace
     the `X` in the following instructions.
     
```{warning}
Do not continue these steps until you are certain that you have found the correct
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

2. Copy the following files to the `boot` partition of the SD card.
   In this repo, the PetaLinux build outputs land in
   `PetaLinux/<target>/images/linux/`. Assuming the `boot` partition
   was mounted to `/media/user/boot`, run:
   ```
   $ cd /media/user/boot/
   $ sudo cp <repo>/PetaLinux/<target>/images/linux/BOOT.BIN .
   $ sudo cp <repo>/PetaLinux/<target>/images/linux/boot.scr .
   $ sudo cp <repo>/PetaLinux/<target>/images/linux/image.ub .
   ```

3. Create the root file system by extracting the `rootfs.tar.gz` file to the `root` partition.
   Assuming the `root` partition was mounted to `/media/user/root`, follow these instructions:
   ```
   $ cd /media/user/root/
   $ sudo cp <repo>/PetaLinux/<target>/images/linux/rootfs.tar.gz .
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

```{tip}
You need to install the cable drivers before being able to boot via JTAG.
Note that the Vitis installer does not automatically install the cable drivers, it must be done separately.
For instructions, read section 
[installing the cable drivers](https://docs.amd.com/r/en-US/ug973-vivado-release-notes-install-license/Installing-Cable-Drivers) 
from the Vivado release notes.
```

```{warning}
If you boot the Zynq-7000, Zynq UltraScale+ or Zynq RFSoC designs via JTAG, you must still
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

```{note}
PetaLinux 2025.2 ships with systemd-based predictable interface
names. Zynq-7000 designs (which expose the PS GEM as an `axi_ethernet`-
adjacent `macb` interface) typically rename the interface from `ethN` to
`enx<mac>` (MAC-derived). Zynq UltraScale+ designs rename the PS GEMs to
`end0`–`end3`. The logical port-to-MAC assignments below are unchanged;
only the interface name changes. Use `ip link` or the `ifconfig` output
to see the actual name on your board.
```

### PicoZed, ZC706, ZedBoard

The Zynq-7000 designs use three AXI Ethernet Subsystem cores plus one PS
GEM for the FMC ports. The on-board RJ45 of these boards is wired to
PS GEM0; in the current PetaLinux configuration `gem0` is left disabled
(see *Zynq-7000 BSPs (gem-disable workaround)* in [advanced](advanced.md))
so the on-board Ethernet is **not** available under Linux in this repo's
PetaLinux images, despite being usable electrically:

* GEM1 (Ethernet FMC Port 3) → `enx<mac>` (the example logs show
  `enx000a35000125`, i.e. MAC `00:0A:35:00:01:25`)
* AXI Ethernet 0 (Ethernet FMC Port 0) → `enx<mac>` (`...122`)
* AXI Ethernet 1 (Ethernet FMC Port 1) → `enx<mac>` (`...123`)
* AXI Ethernet 2 (Ethernet FMC Port 2) → `enx<mac>` (`...124`)

To enable the on-board Ethernet port, remove the `&gem0 { status =
"disabled"; }` stanza from `PetaLinux/bsp/<board>/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi`.
The cost of doing so is that U-Boot will crash on first boot due to a
missing `phy-handle`; see the advanced page for the workaround used.

### ZCU104, ZCU102 (HPC0), ZCU106 (HPC0), UltraZed-EG, UltraZed-EV, PYNQ-ZU, ZCU111, ZCU208

All four PS GEMs are used for the Ethernet FMC ports:

* GEM0 (Ethernet FMC Port 0) → `end0`
* GEM1 (Ethernet FMC Port 1) → `end1`
* GEM2 (Ethernet FMC Port 2) → `end2`
* GEM3 (Ethernet FMC Port 3) → `end3`

Note that the Ethernet port of the dev board in these designs is not connected to any GEM and is
thus unusable.

### ZCU102 (HPC1)

Three of the four FMC ports are wired and the on-board RJ45 stays connected:

* GEM0 (Ethernet FMC Port 0) → `end0`
* GEM1 (Ethernet FMC Port 1) → `end1`
* GEM2 (Ethernet FMC Port 2) → `end2`
* GEM3 (ZCU102 on-board Ethernet port) → `end3`

## Example Usage

The PetaLinux 2025.2 images in this repo log in as user `petalinux` with
password `petalinux` (you will be prompted to change the password on
first login on most targets). The shell prompt is
`<hostname>-zynq-gem-2025-2:~$` and commands that need root privilege are
run via `sudo`. The hostname is set per-target (e.g. `zcu102-zynq-gem-2025-2`,
`pynqzu-zynq-gem-2025-2`, `zed-zynq-gem-2025-2`).

The examples below use `end1` (ZynqMP) as the interface name; substitute
the actual name from the port-configuration table above for your target
(`end<N>` on ZynqMP, `enx<mac>` on Zynq-7000).

### Enable port

This example will bring up a port.

```
zcu102-zynq-gem-2025-2:~$ sudo ifconfig end1 up
[  378.871550] pps pps1: new PPS source ptp1
[  378.875583] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
[  382.943505] macb ff0c0000.ethernet end1: unable to generate target frequency: 125000000 Hz
[  382.951774] macb ff0c0000.ethernet end1: Link is Up - 1Gbps/Full - flow control off
[  382.957441] IPv6: ADDRCONF(NETDEV_CHANGE): end1: link becomes ready
```

### Enable port with fixed IP address

This example sets a fixed IP address to a port.

```
zcu102-zynq-gem-2025-2:~$ sudo ifconfig end1 192.168.2.31 up
[  424.839768] pps pps1: new PPS source ptp1
[  424.843798] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
[  428.927505] macb ff0c0000.ethernet end1: unable to generate target frequency: 125000000 Hz
[  428.935778] macb ff0c0000.ethernet end1: Link is Up - 1Gbps/Full - flow control off
[  428.941450] IPv6: ADDRCONF(NETDEV_CHANGE): end1: link becomes ready
```

### Enable port using DHCP

This example enables a port and obtains an IP address for the port via DHCP. Note that the
port must be connected to a DHCP enabled router.

```
zcu102-zynq-gem-2025-2:~$ sudo udhcpc -i end1
udhcpc: started, v1.36.1
[  314.831199] macb ff0c0000.ethernet end1: unable to generate target frequency: 125000000 Hz
[  314.839489] macb ff0c0000.ethernet end1: Link is Up - 1Gbps/Full - flow control off
[  314.845181] pps pps1: new PPS source ptp1
[  314.849205] macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
[  314.855955] IPv6: ADDRCONF(NETDEV_CHANGE): end1: link becomes ready
udhcpc: broadcasting discover
udhcpc: broadcasting select for 192.168.2.24, server 192.168.2.1
udhcpc: lease of 192.168.2.24 obtained from 192.168.2.1, lease time 259200
RTNETLINK answers: File exists
/etc/udhcpc.d/50default: Adding DNS 192.168.2.1
```

### Check port status

In this example, we use the `ifconfig` command with no arguments to check the port status,
taken from a ZCU102 (HPC0) running PetaLinux 2025.2. `end3` is connected to the Ethernet FMC
port 3 and obtained 192.168.2.64 via DHCP; the other FMC ports are present but down.

```
zcu102-zynq-gem-2025-2:~$ ifconfig
end0      Link encap:Ethernet  HWaddr 00:0A:35:00:01:22
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:50

end1      Link encap:Ethernet  HWaddr 00:0A:35:00:01:23
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          ...

end3      Link encap:Ethernet  HWaddr 00:0A:35:00:01:25
          inet addr:192.168.2.64  Bcast:192.168.2.255  Mask:255.255.255.0
          inet6 addr: fe80::20a:35ff:fe00:125/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:25 errors:0 dropped:2 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2431 (2.3 KiB)  TX bytes:1678 (1.6 KiB)
          Interrupt:53

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          ...
```

We can also use `ethtool` to check the port status as follows.

```
zcu102-zynq-gem-2025-2:~$ ethtool end3
Settings for end3:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Speed: 1000Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Link detected: yes
```

### Ping link partner using specific port

In this example we ping a link partner at 192.168.2.98 over `end3`.

```
zcu102-zynq-gem-2025-2:~$ ping 192.168.2.98
PING 192.168.2.98 (192.168.2.98): 56 data bytes
64 bytes from 192.168.2.98: seq=0 ttl=64 time=0.297 ms
64 bytes from 192.168.2.98: seq=1 ttl=64 time=0.137 ms
64 bytes from 192.168.2.98: seq=2 ttl=64 time=0.125 ms
64 bytes from 192.168.2.98: seq=3 ttl=64 time=0.197 ms
^C
--- 192.168.2.98 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 0.125/0.189/0.297 ms
```

To restrict the source interface explicitly, use `ping -I <iface> <addr>`.

[Ethernet FMC]: https://docs.opsero.com/op031/datasheet/overview/
[supported Linux distributions]: https://docs.amd.com/r/en-US/ug1144-petalinux-tools-reference-guide/Setting-Up-Your-Environment

