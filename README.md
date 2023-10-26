# Zynq GEM Reference Designs for Ethernet FMC

## Description

This project demonstrates the use of the Opsero [Quad Gigabit Ethernet FMC](http://ethernetfmc.com "Ethernet FMC").
The design uses the GMII-to-RGMII IP core to connect the hard GEMs of the Zynq PS to the Ethernet FMC
PHYs. The designs target both the Zynq and ZynqMP devices and are illustrated by the block diagrams below.

### Zynq Design

![Zynq GEM design block diagram](docs/source/images/zynq-gem-design-block-diagram.png "Zynq GEM design block diagram")

### ZynqMP Design

![ZynqMP GEM design block diagram](docs/source/images/zynqmp-gem-design-block-diagram.png "ZynqMP GEM design block diagram")

Important links:

* The user guide for these reference designs is hosted here: [Zynq GEM for Ethernet FMC docs](https://zynqgem.ethernetfmc.com "Zynq GEM for Ethernet FMC docs")
* To report a bug: [Report an issue](https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem/issues "Report an issue").
* For technical support: [Contact Opsero](https://opsero.com/contact-us "Contact Opsero").
* To purchase the mezzanine card: [Ethernet FMC order page](https://opsero.com/product/ethernet-fmc "Ethernet FMC order page").

## Requirements

This project is designed for version 2022.1 of the Xilinx tools (Vivado/Vitis/PetaLinux). 
If you are using an older version of the Xilinx tools, then refer to the 
[release tags](https://github.com/fpgadeveloper/ethernet-fmc-zynq-gem/tags "releases")
to find the version of this repository that matches your version of the tools.

In order to test this design on hardware, you will need the following:

* Vivado 2022.1
* Vitis 2022.1
* PetaLinux Tools 2022.1
* [Ethernet FMC](https://ethernetfmc.com "Ethernet FMC")
* One of the [supported evaluation boards](https://zynqgem.ethernetfmc.com/en/latest/supported_carriers.html)
* For designs containing AXI Ethernet Subsystem IP: [Xilinx Soft TEMAC license](http://ethernetfmc.com/getting-a-license-for-the-xilinx-tri-mode-ethernet-mac/ "Xilinx Soft TEMAC license")

### Target boards

#### Zynq boards

* [PicoZed 7030 FMC Carrier v2](https://www.avnet.com/wps/portal/silica/products/product-highlights/2016/xilinx-picozed-fmc-carrier-card-v2/)
* [ZC706](https://www.xilinx.com/zc706)
* [ZedBoard](https://digilent.com/reference/programmable-logic/zedboard/start)

#### Zynq UltraScale+ MPSoC boards

* [ZCU104](https://www.xilinx.com/zcu104)
* [ZCU102](https://www.xilinx.com/zcu102)
* [ZCU106](https://www.xilinx.com/zcu106)
* [PYNQ-ZU](https://www.tulembedded.com/FPGA/ProductsPYNQ-ZU.html)
* [UltraZed EG PCIe Carrier](https://www.xilinx.com/products/boards-and-kits/1-mb9rqb.html)
* [UltraZed EV carrier](https://www.xilinx.com/products/boards-and-kits/1-y3n9v1.html)

#### Zynq UltraScale+ RFSoC boards

* [ZCU111](https://www.xilinx.com/zcu111)
* [ZCU208](https://www.xilinx.com/zcu208)

## Build instructions

* [For Windows users](https://zynqgem.ethernetfmc.com/en/latest/build_instructions.html#windows-users)
* [For Linux users](https://zynqgem.ethernetfmc.com/en/latest/build_instructions.html#linux-users)

## Contribute

We strongly encourage community contribution to these projects. Please make a pull request if you
would like to share your work:
* if you've spotted and fixed any issues
* if you've added designs for other target platforms

Thank you to everyone who supports us!

## About us

This project was developed by [Opsero Inc.](https://opsero.com "Opsero Inc."),
a tight-knit team of FPGA experts delivering FPGA products and design services to start-ups and tech companies. 
Follow our blog, [FPGA Developer](https://www.fpgadeveloper.com "FPGA Developer"), for news, tutorials and
updates on the awesome projects we work on.

