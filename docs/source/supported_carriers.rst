========================
Supported carrier boards
========================

List of supported boards
========================

+-----------------------------------------------------------------------+---------------------------+ 
| Carrier board                                                         | FMC connector             |
+=======================================================================+===========================+ 
| Zynq-7000 `ZedBoard`_                                                 | LPC                       |
+-----------------------------------------------------------------------+---------------------------+ 
| | Zynq-7000 `MicroZed FMC Carrier`_                                   | LPC                       |
| | with `MicroZed 7Z020`_.                                             |                           |
+-----------------------------------------------------------------------+---------------------------+ 
| | Zynq-7000 `PicoZed FMC Carrier Card V2`_                            | LPC                       |
| | with `PicoZed 7030`_                                                |                           |
+-----------------------------------------------------------------------+---------------------------+ 
| Zynq-7000 `ZC706 Evaluation board`_                                   | LPC                       |
+-----------------------------------------------------------------------+---------------------------+ 
| Zynq UltraScale+ `ZCU102 Evaluation board`_                           | HPC0 and HPC1             |
|                                                                       | (HPC1 limited to 3 ports) |
+-----------------------------------------------------------------------+---------------------------+ 
| Zynq UltraScale+ `ZCU104 Evaluation board`_                           | LPC                       |
+-----------------------------------------------------------------------+---------------------------+ 
| Zynq UltraScale+ `ZCU106 Evaluation board`_                           | HPC0 and HPC1             |
|                                                                       | (HPC1 limited to 2 ports) |
+-----------------------------------------------------------------------+---------------------------+ 
| Zynq UltraScale+ `UltraZed-EG PCIe Carrier Card`_                     | LPC                       |
+-----------------------------------------------------------------------+---------------------------+ 
| Zynq UltraScale+ `UltraZed EV Carrier Card`_                          | HPC                       |
+-----------------------------------------------------------------------+---------------------------+ 
| | Zynq UltraScale+ `TE0808-04-09-1EE-S Starter Kit`_                  | HPC                       |
| | with `TE0808 UltraSOM+ MPSoC Module`_                               |                           |
+-----------------------------------------------------------------------+---------------------------+
| Zynq UltraScale+ `PYNQ-ZU Evaluation board`_                          | LPC                       |
+-----------------------------------------------------------------------+---------------------------+
| Zynq UltraScale+ RFSoC `ZCU111 Evaluation board`_                     | FMC+                      |
+-----------------------------------------------------------------------+---------------------------+ 
 
Unlisted boards
===============

If you need more information on whether the `Ethernet FMC`_ is compatible with a carrier that is not listed above, please first check the
`compatibility list`_. If the carrier is not listed there, please `contact Opsero`_,
provide us with the pinout of your carrier and we'll be happy to check compatibility and generate a Vivado constraints file for you.

Board specific notes
====================

ZCU106
------

* The HPC0 connector on this board supports all 4 ports of the Ethernet FMC. This design uses up all 4 GEMs,
  leaving the ZCU106's on-board Ethernet port unusable.
* The HPC1 connector only has LA00-LA16 pins connected to the FPGA, therefore our example can only
  support 2 ports of the Ethernet FMC. The ZCU106's on-board Ethernet port connects to GEM3 and is usable in this design.

ZCU102
------

* This design supports the ZCU102 Rev 1.0 board. Use a commit before 2017/02/13 for the older Rev-D board design.
  Note that the FMC pinouts differ between Rev 1.0 and Rev D: https://www.xilinx.com/support/answers/68050.html
* The HPC0 design uses 4x GEMs to connect to ports 0-3 of the Ethernet FMC. This design uses up all 4 GEMs,
  leaving the ZCU102's on-board Ethernet port unusable.
* The HPC1 design uses 3x GEMs to connect to ports 0-2 of the Ethernet FMC. The 4th port is left unconnected
  because certain pins required by the Ethernet FMC (namely LA30, LA31 and LA32) are left unconnected 
  on the HPC1 connector of the ZCU102 board. The ZCU102's on-board Ethernet port connects to GEM3 and is usable
  in this design.

UltraZed-EG and UltraZed-EV
---------------------------

* The UltraZed designs use 4x GEMs to connect to ports 0-3 of the Ethernet FMC. These designs use up all 4 GEMs,
  leaving the on-board Ethernet port unusable.

Trenz TE0808 Starter Kit
------------------------

The base board TEBF0808 has a DIP switch that must be set correctly to enable VADJ of 1.8V. Set S5-4 to ON in order
to set VADJ to 1.8V.

This design uses up all 4 GEMs, leaving the TEBF0808's on-board Ethernet port unusable.

ZedBoard, MicroZed and PicoZed
------------------------------

When changing ``ETH_FMC_PORT`` from 0-2 to 3 (ie. when switching to GEM1), it has been noticed that
you have to power cycle the board. When the SDK project is configured for AXI Ethernet, it must make some
Zynq configurations that are not compatible with the GEM1 configuration.

The on-board Ethernet port on all of these designs is connected to GEM0 and is usable.

Installation of MicroZed, PicoZed, UltraZed, TE0808 board definition files
--------------------------------------------------------------------------

To use the projects for the MicroZed, PicoZed and UltraZed, you must first install the board definition files
for those boards into your Vivado and Xilinx SDK installation.

The following folders contain the board definition files and can be found in this project repository at this location:

https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem/tree/master/Vivado/boards/board_files

* ``microzed_7020``
* ``picozed_7030_fmc2``
* ``ultrazed_3eg_pciecc``
* ``TE0808_9EG_1E``

Copy those folders and their contents into the ``C:\Xilinx\Vivado\2020.2\data\boards\board_files`` folder (this may
be different on your machine, depending on your Vivado installation directory). You also need to make a copy into the
Xilinx SDK installation at this location: ``C:\Xilinx\SDK\2020.2\data\boards\board_files``.



.. _contact Opsero: https://opsero.com/contact-us
.. _compatibility list: https://ethernetfmc.com/documentation/compatiblility.html
.. _Ethernet FMC: https://ethernetfmc.com
.. _ZedBoard: http://zedboard.org
.. _MicroZed FMC Carrier: http://zedboard.org/product/microzed-fmc-carrier
.. _MicroZed 7Z020: http://microzed.org
.. _PicoZed FMC Carrier Card V2: http://zedboard.org/product/picozed-fmc-carrier-card-v2
.. _PicoZed 7030: http://picozed.org
.. _UltraZed-EG PCIe Carrier Card: https://www.xilinx.com/products/boards-and-kits/1-mb9rqb.html
.. _UltraZed EV Carrier Card: https://www.xilinx.com/products/boards-and-kits/1-y3n9v1.html
.. _ZC702 Evaluation board: https://www.xilinx.com/zc702
.. _ZC706 Evaluation board: https://www.xilinx.com/zc706
.. _ZCU102 Evaluation board: https://www.xilinx.com/zcu102
.. _ZCU104 Evaluation board: https://www.xilinx.com/zcu104
.. _ZCU106 Evaluation board: https://www.xilinx.com/zcu106
.. _ZCU111 Evaluation board: https://www.xilinx.com/zcu111
.. _PYNQ-ZU Evaluation board: https://www.tul.com.tw/ProductsPYNQ-ZU.html
.. _TE0808-04-09-1EE-S Starter Kit: https://shop.trenz-electronic.de/en/TE0808-04-09-1EE-S-TE0808-04-09-1EE-S-Starter-Kit
.. _TE0808 UltraSOM+ MPSoC Module: https://shop.trenz-electronic.de/en/TE0808-04-09EG-1EE-UltraSOM-MPSoC-Module-with-Zynq-UltraScale-XCZU9EG-1FFVC900E-4-GB-DDR4
