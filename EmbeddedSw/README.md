Modified BSP files
==================

### lwIP modifications

The lwIP sources need a few small modifications to make it work with the Ethernet FMC.

1. A function is added to `xaxiemacif_physpeed.c` for the initialization of the Marvell 88E1510 Ethernet PHY
2. A fix is applied to `xaxiemacif_dma.c` to allow it to work with multiple ports
3. Defined the PHY address of the GMII-to-RGMII converter in `xemacpsif_physpeed.c`

