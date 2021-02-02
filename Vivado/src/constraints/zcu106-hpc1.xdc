# These constraints are suitable for ZCU106 Rev 1.0 HPC1
# ------------------------------------------------------

# These constraints are for the ZCU106-QGIGE design which
# uses 2x GEMs (with GMII-to-RGMII)

# Notes on ZCU106 HPC1 connector
# ------------------------------
#
# Ethernet FMC Port 0:
# --------------------
# * Requires LA00, LA02, LA03, LA04, LA05, LA06, LA07, LA08
# * All are routed to Bank 28
# * LA00 is NOT routed to a global clock capable pin
#
# Ethernet FMC Port 1:
# --------------------
# * Requires LA01, LA06, LA09, LA10, LA11, LA12, LA13, LA14, LA15, LA16
# * All are routed to Bank 28
# * LA01 is NOT routed to a global clock capable pin
#
# Ethernet FMC Port 2:
# --------------------
# * Requires LA17, LA19, LA20, LA21, LA22, LA23, LA24, LA25
# * None are routed on ZCU106 HPC1 connector
#
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * None are routed on ZCU106 HPC1 connector
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
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_0_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_0]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ref_clk_oe[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_1_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[3]}]
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

set_property PACKAGE_PIN H21 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN H22 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN E22 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN D20 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN D21 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN E24 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN D24 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN G25 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN G26 [get_ports reset_port_0]
set_property PACKAGE_PIN G20 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN F20 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN C21 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN C22 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN B18 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN B19 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN J21 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN J22 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN J25 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN H26 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN D19 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN C18 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN C19 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN F23 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN E23 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN K22 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN K23 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN J24 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN H24 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN D22 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN C23 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN A20 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN A21 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN A18 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN A19 [get_ports reset_port_1]

# Sub-optimal placement for a global clock-capable IO pin and BUFG pair.If this sub optimal condition
# is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to 
# demote this message to a WARNING. However, the use of this override is highly discouraged.
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets *_i/gmii_to_rgmii_0/U0/i_gmii_to_rgmii_block/rgmii_rxc_ibuf_i/O]

# Sub-optimal placement for a global clock-capable IO pin and BUFG pair.If this sub optimal condition 
# is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to 
# demote this message to a WARNING. However, the use of this override is highly discouraged. 
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets zcu106_hpc1_qgige_i/gmii_to_rgmii_1/U0/rgmii_rxc_ibuf_i/O]

# BITSLICE0 not available during BISC: The port rgmii_port_0_rxc is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_0_rxc will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_0_rxc will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_0_rxc]

# BITSLICE0 not available during BISC: The port rgmii_port_1_rxc is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a 
# Byte that will be using calibration. The signal connected to rgmii_port_1_rxc will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_1_rxc will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_1_rxc]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 0 and 1
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_0/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y130 [get_cells *_i/gmii_to_rgmii_0/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_0/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y129 [get_cells *_i/gmii_to_rgmii_0/U0/i_gmii_to_rgmii_block/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y121 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y120 [get_cells *_i/gmii_to_rgmii_1/U0/*_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk]

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_zcu106_hpc1_qgige_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu106_hpc1_qgige_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]

# Create the clocks for the RGMII RX CLK inputs
create_clock -period 8.000 -name rgmii_port_0_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_1_rxc]
