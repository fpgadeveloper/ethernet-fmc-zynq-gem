============
Description
============

The reference designs target both Zynq boards and Zynq MP (Zynq Ultrascale+) boards. The
designs for the two target devices differ slightly due to the fact that the Zynq devices
have only 2x GEMs whereas the ZynqMP devices have 4x.

Zynq Designs
============

In the Zynq designs, the first three ports of the Ethernet FMC are connected to the
AXI Ethernet Subsystem IP which are then connected to the system memory via AXI DMA IP.
The fourth port of the Ethernet FMC is connected to the GMII-to-RGMII IP which
connects to hard GEM0 of the Zynq PS via the FPGA fabric (EMIO). The Ethernet port of
the Zynq development board (ie. the on-board Ethernet port) connects directly to the
hard GEM1 of the Zynq PS via MIO.

.. figure:: images/zynq-gem-design-block-diagram.png
    :align: center
    :name: zynq-gem-design-block-diagram
    
    Zynq GEM design block diagram
    

ZynqMP Designs
==============

In the ZynqMP designs, all ports of the Ethernet FMC are connected to the GMII-to-RGMII IP
which connects to hard GEMs of the ZynqMP PS via the FPGA fabric (EMIO). The on-board
Ethernet port is left unconnected and is thus unusable in these reference designs.

.. figure:: images/zynqmp-gem-design-block-diagram.png
    :align: center
    :name: zynqmp-gem-design-block-diagram
    
    ZynqMP GEM design block diagram
    
