# These constraints are suitable for ZCU104 Rev 1.0
# -------------------------------------------------

# These constraints are for the ZCU104-QGIGE design which
# uses 4x GEMs (with GMII-to-RGMII)

# Notes on ZCU104 LPC connector
# ------------------------------
#
# Ethernet FMC Port 0:
# --------------------
# * Requires LA00, LA02, LA03, LA04, LA05, LA06, LA07, LA08
# * All are routed to Bank 67
# * LA00 is routed to a global clock capable pin
#
# Ethernet FMC Port 1:
# --------------------
# * Requires LA01, LA06, LA09, LA10, LA11, LA12, LA13, LA14, LA15, LA16
# * All are routed to Bank 67
# * LA01 is NOT routed to a global clock capable pin
#
# Ethernet FMC Port 2:
# --------------------
# * Requires LA17, LA19, LA20, LA21, LA22, LA23, LA24, LA25
# * All are routed to Bank 68
# * LA17 is routed to a global clock capable pin
#
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * All are routed to Bank 68
# * LA18 is NOT routed to a global clock capable pin
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

set_property PACKAGE_PIN H19 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN G19 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN K15 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN C13 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN C12 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN D11 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN D10 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN A8 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN A7 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN H18 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN H17 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN K17 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN J17 [get_ports reset_port_0]
set_property PACKAGE_PIN H16 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN G16 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN G15 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN F15 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN F11 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN B11 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN A11 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN B9 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN B8 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN F17 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN F16 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN K19 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN K18 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN E18 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN E17 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN F18 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN D17 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN C17 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN F12 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN E12 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN H13 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN H12 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN C7 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN C6 [get_ports mdio_io_port_2_mdio_io]
set_property PACKAGE_PIN J10 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN F7 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN E7 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN E15 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN E14 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN L20 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN K20 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN L17 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN L16 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN J16 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN J15 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN A13 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN A12 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN D16 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN C16 [get_ports reset_port_1]
set_property PACKAGE_PIN D12 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN C11 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN B10 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN A10 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN B6 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN A6 [get_ports reset_port_2]
set_property PACKAGE_PIN M13 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN L13 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN E9 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN D9 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN F8 [get_ports mdio_io_port_3_mdio_io]
set_property PACKAGE_PIN E8 [get_ports reset_port_3]

# Sub-optimal placement for a global clock-capable IO pin and BUFG pair.If this sub optimal condition
# is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to 
# demote this message to a WARNING. However, the use of this override is highly discouraged.
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets *_i/gmii_to_rgmii_1/U0/rgmii_rxc_ibuf_i/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets *_i/gmii_to_rgmii_3/U0/rgmii_rxc_ibuf_i/O]

# BITSLICE0 not available during BISC: The port rgmii_port_2_tx_ctl is assigned to a PACKAGE_PIN that uses BITSLICE_0 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_2_tx_ctl will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_2_tx_ctl will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint:
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_2_tx_ctl]

# BITSLICE0 not available during BISC: The port rgmii_port_2_txc is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_2_txc will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_2_txc will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_2_txc]

# BITSLICE0 not available during BISC: The port rgmii_port_1_rxc is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_1_rxc will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_1_rxc will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_1_rxc]

# BITSLICE0 not available during BISC: The port rgmii_port_3_rxc is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_3_rxc will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_3_rxc will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_3_rxc]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 1,2 and 3
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y117 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y116 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y136 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y135 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y138 [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X1Y137 [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_zcu104_qgige_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu104_qgige_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu104_qgige_clk_wiz_0_0] -to [get_clocks mdio2_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu104_qgige_clk_wiz_0_0] -to [get_clocks mdio3_mdc_clock]

# Create the clocks for the RGMII RX CLK inputs
create_clock -period 8.000 -name rgmii_port_0_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_2_rxc]
create_clock -period 8.000 -name rgmii_port_3_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_3_rxc]
