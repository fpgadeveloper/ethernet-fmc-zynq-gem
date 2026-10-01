# Stand-alone lwIP Echo Server

The standalone (bare-metal) application is the lwIP TCP echo server from the Vitis
`lwip_echo_server` template. It brings up **one** Ethernet FMC port, gets an IP address by
DHCP (or falls back to a fixed address) and echoes back whatever is sent to TCP port 7. It is
the quickest way to check the hardware without building Linux, and it can be built on Windows
as well as on Linux.

The build adds the following to the stock template:

* A port selector (`ETHERNET_PORT` in `platform_config.h.in`) that picks which Ethernet FMC
  port the application uses (see [Change the target port](#change-the-target-port)).
* lwIP 2.2 with DHCP and an enlarged packet-buffer pool, and the `xiltimer` interval timer that
  lwIP needs for its DHCP and TCP timers.
* A modified lwIP adapter (in the `EmbeddedSw` directory of the repository) that configures the
  Marvell 88E1510 PHYs of the Ethernet FMC, and, on Zynq UltraScale+, PS clock control so that
  the GEM clock follows the negotiated link speed.
* On the ZCU104, an FSBL that enables the FMC VADJ supply (see
  [Board specific notes](supported_carriers.md#zcu104)).

## Build

Prerequisites: Vivado 2025.2 and Vitis 2025.2 (see [Requirements](requirements.md)). From the
root of the repository:

```
./build.sh standalone --target <target>
```

(`build.bat standalone --target <target>` from a Windows Command Prompt or PowerShell.) This
builds the Vivado XSA first if needed, then creates the Vitis workspace
`Vitis/<target>_workspace` (platform, BSP and the `echo_server` application) and packages the
boot file:

| Output | Description |
|--------|-------------|
| `Vitis/boot/<target>/BOOT.BIN` | FSBL + bitstream + `echo_server` application, for SD card boot |
| `Vitis/<target>_workspace/echo_server/build/echo_server.elf` | The application, for loading through JTAG |
| `bootimages/ethernet-fmc-zynq-gem_<target>_standalone-2025-2.zip` | `BOOT.BIN` in a zip (made by `./build.sh package` or `all`) |

See [Build instructions](build_instructions.md) for the list of targets.

## Hardware setup

1. Plug the [Ethernet FMC] into the FMC connector given for your target in the
   [target designs](build_instructions.md#target-designs) table, and check that its voltage
   variant matches the board's VADJ ([Choosing the FMC variant](requirements.md#choosing-the-fmc-variant)).
2. Connect the Ethernet FMC port that the application uses (port 0 by default) to your PC, or to
   a router or switch on your network.
3. Connect the board's USB-UART to your PC and open a terminal emulator (for example [Putty] on
   Windows, or `screen /dev/ttyUSB0 115200` on Linux) at **115200 baud**, 8 data bits, no
   parity, 1 stop bit.

## Run the application from the SD card

1. Copy `Vitis/boot/<target>/BOOT.BIN` to the first (FAT32) partition of an SD card.
2. Set the board to boot from the SD card. The boot-mode switch settings for each board are listed
   in [Boot PetaLinux](petalinux.md#boot-petalinux); see also the board's user guide (linked from the
   [Supported boards](supported_carriers.md) page).
3. Insert the card and power up the board. The FSBL programs the FPGA and starts the application.

## Run the application through JTAG

You need the JTAG cable drivers installed (see the tip in [Boot via JTAG](petalinux.md#boot-via-jtag)),
and the board set to boot from JTAG.

1. Open the workspace in the Vitis Unified IDE: `vitis -w Vitis/<target>_workspace`
2. Select the `echo_server` application component.
3. In the **Flow** view, click **Run**. Vitis programs the FPGA with the bitstream, initializes
   the PS and downloads and starts the application.

## Expected output

On the UART console, the application should print something like this:

```
-----lwIP TCP echo server ------
TCP packets sent to port 6001 will be echoed back
Start PHY autonegotiation 
Waiting for PHY to complete autonegotiation.
autonegotiation complete 
link speed for phy address 0: 1000
Board IP: 192.168.2.72
Netmask : 255.255.255.0
Gateway : 192.168.2.1
TCP echo server started @ port 7
```

The above output results when the target port is connected to a router with DHCP. The assigned
board IP can vary. On Zynq-7000 designs the link-speed line may instead read
`auto-negotiated link speed: 1000` depending on which lwIP MAC backend the selected port uses
(AXI Ethernet for ports 0-2, GEM for port 3).

## IP address

By default, the echo server attempts to obtain an IP address from a DHCP server. This is useful
if the echo server is connected to a network. Once the IP address is obtained, it is printed out
in the UART console output.

If instead the echo server is connected directly to a PC, the DHCP attempt will fail and the echo
server's IP address will default to 192.168.1.10. To be able to communicate with the echo server
from the PC, the PC should be configured with a fixed IP address on the same subnet, for example:
192.168.1.20.

## Test the port

### Ping the port

From a PC connected to the echo server (directly, or through the same network), ping the address
that the console printed:

```
ping 192.168.1.10
```

### Connect with telnet

Connect to TCP port 7 of the echo server and type a few characters; each line you send comes
back:

```
telnet 192.168.1.10 7
```

The first argument of the telnet command is the IP address of the echo server and the second is
the port number, which should be 7.

## Change the target port

The echo server can only use one Ethernet port at a time. The port is selected by the
`ETHERNET_PORT` define in the application's `platform_config.h.in`
(`Vitis/<target>_workspace/echo_server/src/platform_config.h.in`). Set it to one of:

* `0`: Ethernet FMC port 0
* `1`: Ethernet FMC port 1
* `2`: Ethernet FMC port 2
* `3`: Ethernet FMC port 3 (not available on `zcu102_hpc1`, which has ports 0-2 only)

The MAC for the selected port is resolved automatically from the target hardware: on the
Zynq-7000 designs (ZedBoard, PicoZed, ZC706) ports 0-2 use the AXI Ethernet cores and port 3 uses
the PS GEM1; on the Zynq UltraScale+ designs port *n* uses GEM*n*.

After changing the port, rebuild the application in the Vitis IDE (select the `echo_server`
component and click **Build** in the **Flow** view). To run it through JTAG, click **Run**. To make
a new SD card boot file, run
`./build.sh standalone --target <target>` afterwards; the runner re-packages `BOOT.BIN` whenever
the application is newer than the boot file.

```{note}
On the Zynq-7000 boards, power-cycle the board when you switch between port 3 (GEM1) and one of
ports 0-2 (AXI Ethernet); see [Board specific notes](supported_carriers.md#zedboard-picozed-and-zc706).
```

[Ethernet FMC]: https://docs.opsero.com/op031/datasheet/overview/
[Putty]: https://www.putty.org
