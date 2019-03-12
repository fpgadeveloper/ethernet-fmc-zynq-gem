# These constraints are intended for the TEBF0808 UltraITX and TE0808 module
# -------------------------------------------------

# These constraints are for the TEBF0808-QGIGE design which
# uses 4x GEMs (with GMII-to-RGMII)

# Enable internal termination resistor on LVDS 125MHz ref_clk
set_property DIFF_TERM TRUE [get_ports {ref_clk_p[0]}]
set_property DIFF_TERM TRUE [get_ports {ref_clk_n[0]}]

# Define I/O standards
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_0_mdio_io]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ref_clk_fsel[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_1_mdio_io]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_0_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_0]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ref_clk_oe[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_1_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_tx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_2_mdio_io]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[3]}]
set_property IOSTANDARD LVDS [get_ports {ref_clk_p[0]}]
set_property IOSTANDARD LVDS [get_ports {ref_clk_n[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_txc]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_tx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_txc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_tx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_1]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_txc]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_2_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_2]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_txc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_tx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_3_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_3_mdio_io]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_3]

set_property PACKAGE_PIN AF11 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN AG11 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN AJ11 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN AK5 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN AJ5 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN AB8 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN AC8 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN AA8 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN AA7 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN AH7 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN AJ7 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN AH12 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN AJ12 [get_ports reset_port_0]
set_property PACKAGE_PIN AJ10 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN AK10 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN AJ4 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN AH4 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN AB6 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN AB9 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN AC9 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN AB11 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN AB10 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN AG8 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN AH8 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN AF10 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN AG10 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN AK12 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN AK13 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN AF5 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN AK4 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN AK3 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN AD9 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN AE9 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN AA6 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN AA5 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN AD11 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN AC11 [get_ports mdio_io_port_2_mdio_io]
set_property PACKAGE_PIN AE10 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN AD5 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN AE5 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN AH6 [get_ports {ref_clk_p[0]}]
set_property PACKAGE_PIN AJ6 [get_ports {ref_clk_n[0]}]
set_property PACKAGE_PIN AF7 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN AF8 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN AG13 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN AH13 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN AH9 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN AJ9 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN AK9 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN AK8 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN AK6 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN AK7 [get_ports reset_port_1]
set_property PACKAGE_PIN AE13 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN AF13 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN AC4 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN AB4 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN AD4 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN AE4 [get_ports reset_port_2]
set_property PACKAGE_PIN AC3 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN AB3 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN AE12 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN AD12 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN AA12 [get_ports mdio_io_port_3_mdio_io]
set_property PACKAGE_PIN AA11 [get_ports reset_port_3]

# BITSLICE0 not available during BISC: The port mdio_io_port_2_mdio_io is assigned to a 
# PACKAGE_PIN that uses BITSLICE_1 of a Byte that will be using calibration. The signal connected to 
# mdio_io_port_2_mdio_io will not be available during calibration and will only be available after RDY 
# asserts. If this condition is not acceptable for your design and board layout, mdio_io_port_2_mdio_io 
# will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is 
# acceptable for your design and board layout, this DRC can be bypassed by acknowledging the condition 
# and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports mdio_io_port_2_mdio_io]

# BITSLICE0 not available during BISC: The port rgmii_port_0_td[2] is assigned to a 
# PACKAGE_PIN that uses BITSLICE_1 of a Byte that will be using calibration. The signal connected to 
# rgmii_port_0_td[2] will not be available during calibration and will only be available after RDY 
# asserts. If this condition is not acceptable for your design and board layout, rgmii_port_0_td[2] 
# will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is 
# acceptable for your design and board layout, this DRC can be bypassed by acknowledging the condition 
# and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_0_td[2]]

# BITSLICE0 not available during BISC: The port rgmii_port_1_td[1] is assigned to a 
# PACKAGE_PIN that uses BITSLICE_1 of a Byte that will be using calibration. The signal connected to 
# rgmii_port_1_td[1] will not be available during calibration and will only be available after RDY 
# asserts. If this condition is not acceptable for your design and board layout, rgmii_port_1_td[1] 
# will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is 
# acceptable for your design and board layout, this DRC can be bypassed by acknowledging the condition 
# and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_1_td[1]]


