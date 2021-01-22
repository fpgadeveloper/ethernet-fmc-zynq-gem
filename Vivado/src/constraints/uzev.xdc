# These constraints are suitable for UltraZed EV Carrier
# ------------------------------------------------------

# These constraints are for the UZEV-QGIGE design which
# uses 4x GEMs

# Notes on UltraZed EV Carrier HPC connector
# ------------------------------------------
#
# Ethernet FMC Port 0:
# --------------------
# * Requires LA00, LA02, LA03, LA04, LA05, LA06, LA07, LA08
# * All are routed to Bank 64
# * LA00 is routed to a clock capable pin
#
# Ethernet FMC Port 1:
# --------------------
# * Requires LA01, LA06, LA09, LA10, LA11, LA12, LA13, LA14, LA15, LA16
# * All are routed to Bank 64
# * LA01 is routed to a clock capable pin
#
# Ethernet FMC Port 2:
# --------------------
# * Requires LA17, LA19, LA20, LA21, LA22, LA23, LA24, LA25
# * All are routed to Bank 65
# * LA17 is routed to a clock capable pin
#
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * All are routed to Bank 65
# * LA18 is routed to a clock capable pin
#

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

set_property PACKAGE_PIN AC17 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN AC18 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN AH16 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN AF15 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN AG15 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN AH6 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN AJ6 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN AG8 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN AH8 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN AD17 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN AE17 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN AD19 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN AE19 [get_ports reset_port_0]
set_property PACKAGE_PIN AK17 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN AK18 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN AJ15 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN AK15 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN AG6 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN AJ5 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN AK5 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN AK9 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN AK8 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN AF16 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN AF17 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN AE18 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN AF18 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN AJ16 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN AK16 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN AK14 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN AG13 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN AH13 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN AJ10 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN AK10 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN AF12 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN AF11 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN AF6 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN AF5 [get_ports mdio_io_port_2_mdio_io]
set_property PACKAGE_PIN AK4 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN AF3 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN AF2 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN AG14 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN AH14 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN AG18 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN AH18 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN AH17 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN AJ17 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN AA16 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN AB16 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN AC16 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN AD16 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN AK13 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN AK12 [get_ports reset_port_1]
set_property PACKAGE_PIN AF10 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN AG10 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN AF8 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN AF7 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN AK7 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN AK6 [get_ports reset_port_2]
set_property PACKAGE_PIN AJ11 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN AK11 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN AJ2 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN AJ1 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN AH9 [get_ports mdio_io_port_3_mdio_io]
set_property PACKAGE_PIN AJ9 [get_ports reset_port_3]

# [DRC PDRC-203] BITSLICE0 not available during BISC: The port rgmii_port_0_td[3] is 
# assigned to a PACKAGE_PIN that uses BITSLICE_1 of a Byte that will be using calibration. 
# The signal connected to rgmii_port_0_td[3] will not be available during calibration and 
# will only be available after RDY asserts. If this condition is not acceptable for your 
# design and board layout, rgmii_port_0_td[3] will have to be moved to another PACKAGE_PIN 
# that is not undergoing calibration or be moved to a PACKAGE_PIN location that is not 
# BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and 
# setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_0_td[3]]

# [DRC PDRC-203] BITSLICE0 not available during BISC: The port rgmii_port_3_td[1] is 
# assigned to a PACKAGE_PIN that uses BITSLICE_1 of a Byte that will be using calibration. 
# The signal connected to rgmii_port_3_td[1] will not be available during calibration and 
# will only be available after RDY asserts. If this condition is not acceptable for your 
# design and board layout, rgmii_port_3_td[1] will have to be moved to another PACKAGE_PIN 
# that is not undergoing calibration or be moved to a PACKAGE_PIN location that is not 
# BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and 
# setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_3_td[1]]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 0 and 1
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2019.2, even this does not result a good placement of BUFGCE and timing closure.

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y42 [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y43 [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y44 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y45 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_uzev_qgige_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_uzev_qgige_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]
set_false_path -from [get_clocks clk_out1_uzev_qgige_clk_wiz_0_0] -to [get_clocks mdio2_mdc_clock]
set_false_path -from [get_clocks clk_out1_uzev_qgige_clk_wiz_0_0] -to [get_clocks mdio3_mdc_clock]

# Create the clocks for the RGMII RX CLK inputs
create_clock -period 8.000 -name rgmii_port_0_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_2_rxc]
create_clock -period 8.000 -name rgmii_port_3_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_3_rxc]
