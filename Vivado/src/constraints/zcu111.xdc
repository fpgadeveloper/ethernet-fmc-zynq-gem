# These constraints are suitable for ZCU111 FMC+
# ----------------------------------------------

# These constraints are for the ZCU111-QGIGE design which
# uses 4x GEMs (with GMII-to-RGMII)

# Notes on ZCU111 FMC+ connector
# ------------------------------
#
# Ethernet FMC Port 0:
# --------------------
# * Requires LA00, LA02, LA03, LA04, LA05, LA06, LA07, LA08
# * All are routed to Bank 65
# * LA00 is routed to a global clock capable pin
#
# Ethernet FMC Port 1:
# --------------------
# * Requires LA01, LA06, LA09, LA10, LA11, LA12, LA13, LA14, LA15, LA16
# * All are routed to Bank 65
# * LA01 is routed to a global clock capable pin
#
# Ethernet FMC Port 2:
# --------------------
# * Requires LA17, LA19, LA20, LA21, LA22, LA23, LA24, LA25
# * All are routed to Bank 66
# * LA17 is routed to a global clock capable pin
#
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * All are routed to Bank 66
# * LA18 is routed to a global clock capable pin
#


# Enable internal termination resistor on LVDS 125MHz ref_clk
set_property DIFF_TERM_ADV TERM_100 [get_ports ref_clk_clk_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports ref_clk_clk_n]

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
set_property IOSTANDARD LVDS [get_ports ref_clk_clk_p]
set_property IOSTANDARD LVDS [get_ports ref_clk_clk_n]
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

set_property PACKAGE_PIN AL8 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN AL7 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN AN12 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN AL14 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN AM14 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN AM20 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN AN20 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN AR21 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN AT21 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN AP8 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN AR8 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN AM8 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN AM7 [get_ports reset_port_0]
set_property PACKAGE_PIN AN8 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN AN7 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN AM13 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN AN13 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN AN21 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN AM18 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN AN18 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN AR22 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN AT22 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN AP9 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN AR9 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN AJ12 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN AK12 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN AL9 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN AM9 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN AM10 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN AR12 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN AR11 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN AR17 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN AT17 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN AR19 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN AT19 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN AL21 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN AL20 [get_ports mdio_io_port_2_mdio_io]
set_property PACKAGE_PIN AK21 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN AJ20 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN AJ19 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN AN10 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN AP10 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN AH13 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN AJ13 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN AG12 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN AH12 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN AK13 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN AL12 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN AT10 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN AU10 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN AJ14 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN AK14 [get_ports reset_port_1]
set_property PACKAGE_PIN AU20 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN AU19 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN AL19 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN AM19 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN AL22 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN AM22 [get_ports reset_port_2]
set_property PACKAGE_PIN AJ18 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN AK18 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN AG20 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN AH20 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN AF20 [get_ports mdio_io_port_3_mdio_io]
set_property PACKAGE_PIN AF19 [get_ports reset_port_3]

# [DRC PDRC-203] BITSLICE0 not available during BISC: The port rgmii_port_0_td[3] is assigned to a PACKAGE_PIN that uses BITSLICE_0 of a Byte 
# that will be using calibration. The signal connected to rgmii_port_0_td[3] will not be available during calibration and will only be available 
# after RDY asserts. If this condition is not acceptable for your design and board layout, rgmii_port_0_td[3] will have to be moved to another 
# PACKAGE_PIN that is not undergoing calibration or be moved to a PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. 
# If this condition is acceptable for your design and board layout, this DRC can be bypassed by acknowledging the condition and setting the 
# following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_0_td[3]]
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_1_tx_ctl]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 1,2 and 3
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set gmii_to_rgmii_0_bufg [get_cells -hierarchical -filter { PRIMITIVE_TYPE == CLOCK.BUFFER.BUFGCE && NAME =~  "*gmii_to_rgmii_0/*gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk*" } ]
set gmii_to_rgmii_0_bufio [get_cells -hierarchical -filter { PRIMITIVE_TYPE == CLOCK.BUFFER.BUFGCE && NAME =~  "*gmii_to_rgmii_0/*gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk*" } ]
set_property BEL BUFCE $gmii_to_rgmii_0_bufg
set_property LOC BUFGCE_X0Y47 $gmii_to_rgmii_0_bufg
set_property BEL BUFCE $gmii_to_rgmii_0_bufio
set_property LOC BUFGCE_X0Y46 $gmii_to_rgmii_0_bufio

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio2_mdc_clock]
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio3_mdc_clock]

# Create the clocks for the RGMII RX CLK inputs
create_clock -period 8.000 -name rgmii_port_0_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_2_rxc]
create_clock -period 8.000 -name rgmii_port_3_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_3_rxc]
