# These constraints are suitable for PYNQ-ZU 1.0 Rev B
# ---------------------------------------------------------------------------------
# These constraints are for the  PYNQ-ZU-QGIGE design which
# uses 4x GEMs (with GMII-to-RGMII)

# Notes on PYNQ-ZU FMC connector
# ------------------------------
#
# Ethernet FMC Port 0:
# --------------------
# * Requires LA00, LA02, LA03, LA04, LA05, LA06, LA07, LA08
# * All are routed to Bank 65
# * LA00 is routed to a clock capable pin
#
# Ethernet FMC Port 1:
# --------------------
# * Requires LA01, LA06, LA09, LA10, LA11, LA12, LA13, LA14, LA15, LA16
# * All are routed to Bank 65
# * LA01 is NOT routed to a clock capable pin
#
# Ethernet FMC Port 2:
# --------------------
# * Requires LA17, LA19, LA20, LA21, LA22, LA23, LA24, LA25
# * All are routed to Bank 64
# * LA17 is routed to a clock capable pin
#
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * All are routed to Bank 64
# * LA18 is NOT routed to a clock capable pin
#


# Differential 125MHz LVDS clock
set_property -dict {IOSTANDARD LVDS PACKAGE_PIN L3} [get_ports {ref_clk_clk_p}]
set_property -dict {IOSTANDARD LVDS PACKAGE_PIN L2} [get_ports {ref_clk_clk_n}]

# Define I/O standards and port location
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J7} [get_ports {rgmii_port_1_rd[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  H7} [get_ports mdio_io_port_0_mdio_io]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  N6} [get_ports {rgmii_port_1_rd[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  R7} [get_ports {ref_clk_fsel[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  T7} [get_ports mdio_io_port_1_mdio_io]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AD2} [get_ports rgmii_port_3_rxc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AD1} [get_ports rgmii_port_3_rx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AE3} [get_ports {rgmii_port_3_rd[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AF3} [get_ports {rgmii_port_3_rd[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  P7} [get_ports rgmii_port_1_rxc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  P6} [get_ports rgmii_port_1_rx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J1} [get_ports mdio_io_port_0_mdc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  H1} [get_ports reset_port_0]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  L1} [get_ports {rgmii_port_1_rd[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  K1} [get_ports {rgmii_port_1_rd[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  R6} [get_ports {ref_clk_oe[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  T6} [get_ports mdio_io_port_1_mdc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AC4} [get_ports rgmii_port_2_rxc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AC9} [get_ports {rgmii_port_2_rd[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AD9} [get_ports {rgmii_port_2_rd[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AF1} [get_ports {rgmii_port_3_rd[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AG1} [get_ports {rgmii_port_3_rd[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  L7} [get_ports rgmii_port_0_rxc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  L6} [get_ports rgmii_port_0_rx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  K9} [get_ports {rgmii_port_0_rd[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J9} [get_ports {rgmii_port_0_rd[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J5} [get_ports {rgmii_port_0_td[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J4} [get_ports {rgmii_port_0_td[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  L5} [get_ports {rgmii_port_1_td[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  M8} [get_ports {rgmii_port_1_td[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  L8} [get_ports {rgmii_port_1_td[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AB4} [get_ports rgmii_port_2_rx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AB3} [get_ports {rgmii_port_2_rd[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AB1} [get_ports {rgmii_port_2_td[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AC1} [get_ports {rgmii_port_2_td[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AH2} [get_ports rgmii_port_2_tx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AH1} [get_ports mdio_io_port_2_mdio_io]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AH4} [get_ports {rgmii_port_3_td[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AG9} [get_ports {rgmii_port_3_td[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AH9} [get_ports {rgmii_port_3_td[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  K8} [get_ports {rgmii_port_0_rd[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  K7} [get_ports {rgmii_port_0_rd[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  H9} [get_ports {rgmii_port_0_td[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  H8} [get_ports rgmii_port_0_txc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J6} [get_ports {rgmii_port_0_td[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  H6} [get_ports rgmii_port_0_tx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  K2} [get_ports {rgmii_port_1_td[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  J2} [get_ports rgmii_port_1_txc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  N9} [get_ports rgmii_port_1_tx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN  N8} [get_ports reset_port_1]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AB2} [get_ports {rgmii_port_2_rd[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AC2} [get_ports {rgmii_port_2_td[0]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AE2} [get_ports rgmii_port_2_txc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AF2} [get_ports {rgmii_port_2_td[3]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AG3} [get_ports mdio_io_port_2_mdc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AH3} [get_ports reset_port_2]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AG6} [get_ports {rgmii_port_3_td[1]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AG5} [get_ports rgmii_port_3_txc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AE9} [get_ports rgmii_port_3_tx_ctl]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AE8} [get_ports mdio_io_port_3_mdc]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AF8} [get_ports mdio_io_port_3_mdio_io]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN AG8} [get_ports reset_port_3]

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

# BITSLICE0 not available during BISC: The port rgmii_port_0_td[1] is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_0_td[1] will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_0_td[1] will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_0_td[1]]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 1,2 and 3
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y54 [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y53 [get_cells *_i/gmii_to_rgmii_0/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y69 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y68 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y36 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y35 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y39 [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y38 [get_cells *_i/gmii_to_rgmii_3/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_pynqzu_qgige_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_pynqzu_qgige_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]
set_false_path -from [get_clocks clk_out1_pynqzu_qgige_clk_wiz_0_0] -to [get_clocks mdio2_mdc_clock]
set_false_path -from [get_clocks clk_out1_pynqzu_qgige_clk_wiz_0_0] -to [get_clocks mdio3_mdc_clock]

# Create the clocks for the RGMII RX CLK inputs
create_clock -period 8.000 -name rgmii_port_0_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_2_rxc]
create_clock -period 8.000 -name rgmii_port_3_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_3_rxc]
