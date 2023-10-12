Modified BSP files
==================

### lwIP modifications

The lwIP sources need a few small modifications to make it work with the Ethernet FMC.

1. A function is added to `xaxiemacif_physpeed.c` for the initialization of the Marvell 88E1510 Ethernet PHY
2. Defined the PHY address of the GMII-to-RGMII converter in `xemacpsif_physpeed.c`

### ZynqMP FSBL modifications

This project uses a modified ZynqMP FSBL to fix these issues:

* The code used to read the FMC card's EEPROM on ZCU104 has a bug that you can read about here:
https://forums.xilinx.com/t5/Xilinx-Evaluation-Boards/Enabling-VADJ-on-ZCU104/td-p/861259
