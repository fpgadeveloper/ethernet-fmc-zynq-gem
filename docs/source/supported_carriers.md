# Supported carrier boards

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

## Unlisted boards

If you need more information on whether the [Ethernet FMC] is compatible with a carrier that is not listed above, please first check the
[compatibility list]. If the carrier is not listed there, please [contact Opsero],
provide us with the pinout of your carrier and we'll be happy to check compatibility and generate a Vivado constraints file for you.

## Board specific notes

### ZCU106

* The HPC0 connector on this board supports all 4 ports of the Ethernet FMC. This design uses up all 4 GEMs,
  leaving the ZCU106's on-board Ethernet port unusable.

### ZCU102

* This design supports the ZCU102 Rev 1.0 board. Use a commit before 2017/02/13 for the older Rev-D board design.
  Note that the FMC pinouts differ between Rev 1.0 and Rev D: [Answer record 68050](https://www.xilinx.com/support/answers/68050.html)
* The HPC0 design uses 4x GEMs to connect to ports 0-3 of the Ethernet FMC. This design uses up all 4 GEMs,
  leaving the ZCU102's on-board Ethernet port unusable.
* The HPC1 design uses 3x GEMs to connect to ports 0-2 of the Ethernet FMC. The 4th port is left unconnected
  because certain pins required by the Ethernet FMC (namely LA30, LA31 and LA32) are left unconnected 
  on the HPC1 connector of the ZCU102 board. The ZCU102's on-board Ethernet port connects to GEM3 and is usable
  in this design.

### UltraZed-EG and UltraZed-EV

* The UltraZed designs use 4x GEMs to connect to ports 0-3 of the Ethernet FMC. These designs use up all 4 GEMs,
  leaving the on-board Ethernet port unusable.

### ZedBoard and PicoZed

When changing `ETH_FMC_PORT` from 0-2 to 3 (ie. when switching to GEM1), it has been noticed that
you have to power cycle the board. When the SDK project is configured for AXI Ethernet, it must make some
Zynq configurations that are not compatible with the GEM1 configuration.

The on-board Ethernet port on all of these designs is connected to GEM0 and is usable.


[contact Opsero]: https://opsero.com/contact-us
[compatibility list]: https://ethernetfmc.com/documentation/compatiblility.html
[Ethernet FMC]: https://ethernetfmc.com
[ZedBoard]: https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/zedboard/zedboard-board-family
[PicoZed FMC Carrier Card V2]: https://www.avnet.com/wps/portal/silica/products/product-highlights/2016/xilinx-picozed-fmc-carrier-card-v2/
[PicoZed 7030]: https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/picozed/picozed-board-family
[UltraZed-EG PCIe Carrier Card]: https://www.xilinx.com/products/boards-and-kits/1-mb9rqb.html
[UltraZed EV Carrier Card]: https://www.xilinx.com/products/boards-and-kits/1-y3n9v1.html
[ZC706 Evaluation board]: https://www.xilinx.com/zc706
[ZCU102 Evaluation board]: https://www.xilinx.com/zcu102
[ZCU104 Evaluation board]: https://www.xilinx.com/zcu104
[ZCU106 Evaluation board]: https://www.xilinx.com/zcu106
[ZCU111 Evaluation board]: https://www.xilinx.com/zcu111
[ZCU208 Evaluation board]: https://www.xilinx.com/zcu208
[PicoZed Hardware User Guide]: https://www.element14.com/community/servlet/JiveServlet/downloadBody/90974-102-2-394635/5279-UG-PicoZed-7015-7030-V2_1.pdf
[PYNQ-ZU Evaluation board]: https://www.tul.com.tw/ProductsPYNQ-ZU.html


