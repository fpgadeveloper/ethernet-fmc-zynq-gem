# Description

The reference designs target Zynq-7000, Zynq UltraScale+ MPSoC and Zynq UltraScale+ RFSoC 
boards.

## Zynq-7000 Designs

In the Zynq designs, the first three ports of the Ethernet FMC are connected to the
AXI Ethernet Subsystem IP which are then connected to the system memory via AXI DMA IP.
The fourth port of the Ethernet FMC is connected to the GMII-to-RGMII IP which
connects to hard GEM0 of the Zynq PS via the FPGA fabric (EMIO). The Ethernet port of
the Zynq development board (ie. the on-board Ethernet port) connects directly to the
hard GEM1 of the Zynq PS via MIO.

![Zynq GEM design block diagram](images/zynq-gem-design-block-diagram.png)

## Zynq US+ MPSoC and RFSoC Designs

In the Zynq UltraScale+ designs, all ports of the Ethernet FMC are connected to the GMII-to-RGMII IP
which connects to hard GEMs of the ZynqMP PS via the FPGA fabric (EMIO). The on-board
Ethernet port is left unconnected and is thus unusable in these reference designs.

![ZynqMP GEM design block diagram](images/zynqmp-gem-design-block-diagram.png)

## Hardware Platforms

The hardware designs provided in this reference are based on Vivado and support a range of MPSoC evaluation
boards. The repository contains all necessary scripts and code to build these designs for the supported platforms listed below:

{% for group in data.groups %}
    {% set designs_in_group = [] %}
    {% for design in data.designs %}
        {% if design.group == group.label and design.publish %}
            {% set _ = designs_in_group.append(design.label) %}
        {% endif %}
    {% endfor %}
    {% if designs_in_group | length > 0 %}
### {{ group.name }} platforms

| Target board        | FMC Slot Used | Supported<br>Num. Ports   | Standalone<br> Echo Server | PetaLinux |
|---------------------|---------------|---------|-----|-----|
{% for design in data.designs %}{% if design.group == group.label and design.publish %}| [{{ design.board }}]({{ design.link }}) | {{ design.connector }} | {{ design.lanes | length }}x | {% if design.baremetal %} ✅ {% else %} ❌ {% endif %} | {% if design.petalinux %} ✅ {% else %} ❌ {% endif %} |
{% endif %}{% endfor %}
{% endif %}
{% endfor %}

## Software

These reference designs can be driven by either a standalone application or within a PetaLinux environment. 
The repository includes all necessary scripts and code to build both environments. The table 
below outlines the corresponding applications available in each environment:

| Environment      | Available Applications  |
|------------------|-------------------------|
| Standalone       | lwIP Echo Server |
| PetaLinux        | Built-in Linux commands<br>Additional tools: ethtool, phytool, iperf3 |


[Ethernet FMC]: https://ethernetfmc.com/docs/ethernet-fmc/overview/

