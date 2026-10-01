# Requirements

In order to build and test this design on hardware, you will need the following:

* Vivado 2025.2
* Vitis 2025.2
* For the PetaLinux images: PetaLinux Tools 2025.2 on a Linux machine
* For the Yocto images: a Linux machine with the Yocto host packages and Google's `repo` tool
  (see [Yocto](yocto.md#requirements))
* [Ethernet FMC] or [Robust Ethernet FMC], in the voltage variant that matches your board's
  VADJ (see [Choosing the FMC variant](#choosing-the-fmc-variant) below)
* One of the supported carrier boards listed below
* For the Zynq-7000 designs (ZedBoard, PicoZed 7030, ZC706): a license for the AMD Tri-Mode
  Ethernet MAC, used by the AXI Ethernet Subsystem cores of FMC ports 0-2
  ([how to get one](https://ethernetfmc.com/getting-a-license-for-the-xilinx-tri-mode-ethernet-mac/));
  an evaluation license is sufficient for testing
* To test the ports: Ethernet cables and a link partner for each port you want to test, such as
  a PC with a Gigabit Ethernet port or a Gigabit switch or router. For throughput tests, a PC
  running `iperf3`.
* A USB cable for the board's USB-UART, and an SD card (8 GB or more is enough for the Yocto
  image) with an SD card reader for your PC

## Choosing the FMC variant

The Ethernet FMC and the Robust Ethernet FMC come in a 1.8 V and a 2.5 V variant. The I/O
voltage of the card must match the VADJ voltage that the carrier board supplies to the FMC
connector. Running a 2.5 V card from a 1.8 V VADJ (or the reverse) is outside the card's
specification, even if the ports appear to work.

| Board | VADJ on the FMC connector | Card variant |
|-------|---------------------------|--------------|
| ZCU102, ZCU104, ZCU106, ZCU111, ZCU208 | 1.8 V | 1.8 V (OP031-1V8 / OP041-1V8) |
| PYNQ-ZU | 1.8 V | 1.8 V |
| ZC706 | 2.5 V | 2.5 V (OP031-2V5 / OP041-2V5) |
| ZedBoard, PicoZed FMC Carrier V2, UltraZed-EG PCIe Carrier, UltraZed-EV Carrier | set on the carrier (jumper or power configuration) | the variant that matches the VADJ you select; refer to the carrier's user guide |

On the ZCU104, VADJ is switched on by the first-stage boot loader (FSBL) after it reads the
voltage record from the FMC card's EEPROM; the FSBL in this repository is patched so that it does
(see [Troubleshooting](troubleshooting.md#no-link-on-any-fmc-port)).

## List of supported boards

{% set unique_boards = {} %}
{% for design in data.designs %}
	{% if design.publish %}
	    {% if design.board not in unique_boards %}
	        {% set _ = unique_boards.update({design.board: {"group": design.group, "link": design.link, "connectors": []}}) %}
	    {% endif %}
	    {% if design.connector not in unique_boards[design.board]["connectors"] and '&' not in design.connector %}
	    	{% set _ = unique_boards[design.board]["connectors"].append(design.connector) %}
	    {% endif %}
	{% endif %}
{% endfor %}

{% for group in data.groups %}
    {% set boards_in_group = [] %}
    {% for name, board in unique_boards.items() %}
        {% if board.group == group.label %}
            {% set _ = boards_in_group.append(board) %}
        {% endif %}
    {% endfor %}

    {% if boards_in_group | length > 0 %}
### {{ group.name }} boards

| Carrier board        | Supported FMC connector(s)    |
|---------------------|--------------|
{% for name,board in unique_boards.items() %}{% if board.group == group.label %}| [{{ name }}]({{ board.link }}) | {% for connector in board.connectors %}{{ connector }} {% endfor %} |
{% endif %}{% endfor %}
{% endif %}
{% endfor %}

For list of the target designs showing the number of ports supported, refer to the build instructions.

[Ethernet FMC]: https://docs.opsero.com/op031/datasheet/overview/
[Robust Ethernet FMC]: https://docs.opsero.com/op041/datasheet/overview/
