# Using and testing the ports

This page applies to both Linux images, [PetaLinux](petalinux.md) and [Yocto](yocto.md). It shows
how to find the Ethernet FMC ports in Linux, bring them up, check the link and the PHY, and
measure the throughput. Both images include `ethtool`, `phytool` and `iperf3`.

## Interface names

Both images use the systemd predictable interface names, so the ports are not called `eth0` to
`eth3`, and **the interface number does not follow the Ethernet FMC port number**. The reliable
way to identify a port is its MAC address, which is fixed by the device tree:

| Port | MAC address |
|------|-------------|
| Ethernet FMC port 0 | `00:0a:35:00:01:22` |
| Ethernet FMC port 1 | `00:0a:35:00:01:23` |
| Ethernet FMC port 2 | `00:0a:35:00:01:24` |
| Ethernet FMC port 3 | `00:0a:35:00:01:25` |
| Board Ethernet port, Zynq-7000 | `00:0a:35:00:01:26` |
| Board Ethernet port, `zcu102_hpc1` | `00:0a:35:00:01:25` |

List the interfaces with their MAC addresses, and the hardware each one belongs to:

```
ip -br link
for n in /sys/class/net/e*; do echo "$(basename $n) -> $(basename $(readlink -f $n/device)) $(cat $n/address)"; done
```

The hardware names are the base addresses of the MACs: on Zynq UltraScale+ GEM0 to GEM3 are
`ff0b0000` to `ff0e0000`; on Zynq-7000 GEM0 is `e000b000`, GEM1 is `e000c000` and the AXI
Ethernet cores are `41000000`, `41040000` and `41080000` (ports 0, 1, 2).

### Yocto images

| Target | FMC port 0 | FMC port 1 | FMC port 2 | FMC port 3 | Board port |
|--------|-----------|-----------|-----------|-----------|------------|
| Zynq UltraScale+, four ports | `end3` | `end2` | `end1` | `end0` | - |
| `zcu102_hpc1` | `end3` | `end2` | `end1` | - | `end0` |
| Zynq-7000 | `end2` | `end0` | `end1` | `end4` | `end3` |

On Zynq UltraScale+, Linux numbers the GEMs from the highest base address down, so GEM3 (FMC port
3) is `end0` and GEM0 (FMC port 0) is `end3`. On Zynq-7000 the PS GEMs and the AXI Ethernet cores
are numbered in the order the drivers find them. The names above were observed on the ZCU102,
ZCU104, ZCU106, UltraZed-EV, PYNQ-ZU and ZedBoard; the other boards of each family use the same
device-tree description and are expected to match, but always confirm with the commands above.

### PetaLinux images

| Target | FMC port 0 | FMC port 1 | FMC port 2 | FMC port 3 | Board port |
|--------|-----------|-----------|-----------|-----------|------------|
| Zynq UltraScale+, four ports | `end0` | `end1` | `end2` | `end3` | - |
| `zcu102_hpc1` | `end0` | `end1` | `end2` | - | `end3` |
| Zynq-7000 | `enx000a35000122` | `enx000a35000123` | `enx000a35000124` | `enx000a35000125` | `enx000a35000126` |

On the Zynq-7000 the PetaLinux interface names are derived from the MAC address (`enx<mac>`).

## Bring a port up

**Yocto:** the image runs `systemd-networkd`, which brings every wired port up and requests an
address by DHCP as soon as it has a link. A port connected to a network with a DHCP server
therefore has an address shortly after boot:

```
ip -br addr
```

**PetaLinux:** bring the port up by hand, as shown in [Example Usage](petalinux.md#example-usage):

```
sudo ifconfig end1 up                  # link only
sudo ifconfig end1 192.168.2.31 up     # fixed address
sudo udhcpc -i end1                    # DHCP
```

**Fixed address (both images):** when a port is connected directly to a PC, there is no DHCP
server; give the port a fixed address and the PC an address in the same subnet:

```
sudo ip addr add 192.168.1.10/24 dev end3
sudo ip link set end3 up
```

```{important}
Each port that Linux manages must be on its own subnet. If two ports have addresses in the same
subnet, Linux sends the traffic for that subnet through only one of them. For example, use
192.168.1.0/24 on one port, 192.168.2.0/24 on the next and so on.
```

## Check the link

`ethtool` shows the negotiated speed and the link state:

```
$ sudo ethtool end3 | grep -E "Speed|Duplex|Link detected"
	Speed: 1000Mb/s
	Duplex: Full
	Link detected: yes
```

The kernel log shows the PHY that each port found and every link change:

```
$ dmesg | grep -E "PHY \[|Link is"
macb ff0b0000.ethernet end3: PHY [ff0b0000.ethernet-ffffffff:00] driver [Marvell 88E1510] (irq=POLL)
macb ff0b0000.ethernet end3: Link is Up - 1Gbps/Full - flow control off
```

Every Ethernet FMC port should report the `Marvell 88E1510` driver at address `00` of its own
MDIO bus. If a port reports `Generic PHY` or no PHY at all, see
[Troubleshooting](troubleshooting.md).

## Read the PHY registers

`phytool` reads the PHY registers through the port's MDIO bus (`<interface>/<PHY address>/<register>`;
the Ethernet FMC PHYs are at address 0):

```
$ sudo phytool read end3/0/1
0x796d
$ sudo phytool read end3/0/10
0x3800
```

Register 1 (basic status) reads `0x796d` with the link up and auto-negotiation complete.
Register 10 (1000BASE-T status) reads `0x3800` on a healthy gigabit link: local and remote receiver
OK, link partner capable of 1000BASE-T full duplex, and an idle error count of 0 in the low byte.
A non-zero idle error count that keeps rising points to a cabling or signal integrity problem.

## Measure the throughput

Run an `iperf3` server on the PC at the other end of the link:

```
iperf3 -s
```

On the board, send for 10 seconds, then receive for 10 seconds (`-R`), binding the test to the
port under test:

```
iperf3 -c <PC address> --bind-dev end3 -t 10
iperf3 -c <PC address> --bind-dev end3 -t 10 -R
```

Then check the error counters of the port; they should not increase during the test:

```
ip -s link show end3
sudo ethtool -S end3 | grep -iE "err|crc|fcs|overrun|resource" | grep -v ": 0$"
```

### Expected results

**Zynq UltraScale+.** Every port runs at Gigabit line rate. Measured with the Yocto images (one
port at a time, 10 s per direction, standard 1500-byte MTU):

| Board | Board to PC | PC to board | Errors |
|-------|-------------|-------------|--------|
| ZCU102 (HPC0 and HPC1), ZCU104, ZCU106, UltraZed-EV, PYNQ-ZU | 941-943 Mbit/s | 934-940 Mbit/s | 0 |

The PYNQ-ZU ports also ran for 120 s in each direction at 936-941 Mbit/s with no MAC, FCS or PHY
errors. Retransmissions reported by `iperf3` on the sending side can come from the PC or from the
network in between; what matters is that the error counters of the port stay at 0.

**Zynq-7000.** The throughput is limited by the dual Cortex-A9 processor, not by the link, and
varies from run to run. Measured on the ZedBoard with the Yocto image:

| Port | Board to PC | PC to board |
|------|-------------|-------------|
| FMC port 0 (AXI Ethernet) | 591-772 Mbit/s | 665-674 Mbit/s |
| FMC port 3 (GEM1) | 646-655 Mbit/s | 617-627 Mbit/s |
| Board Ethernet port (GEM0) | 547-679 Mbit/s | 666-674 Mbit/s |

Treat well above 400 Mbit/s on a GEM port (and above about 250 Mbit/s on an AXI Ethernet port) as
a working port. When the PC sends at full rate, the GEM ports can count a few `rx_resource_errors`
in `ethtool -S` (and receive errors in `ip -s link`): the GEM ran out of receive buffers because the
processor could not keep up. They are not link errors, and TCP recovers from them.

## Benign messages

* `macb ... unable to generate target frequency: 125000000 Hz`: the GEMs on EMIO take their
  transmit clock from the PL (the GMII-to-RGMII core), so the driver cannot set the clock
  itself. The link still trains at 1 Gbps full duplex; nothing needs to be done.
* `xgmiitorgmii ... Couldn't find phydev` early in the kernel log (Zynq UltraScale+): the
  GMII-to-RGMII core is probed before the PHY on its MDIO bus. The port works normally once the
  PHY driver is attached (the `PHY [...] driver [Marvell 88E1510]` line follows a few seconds
  later).

[Ethernet FMC]: https://docs.opsero.com/op031/datasheet/overview/
