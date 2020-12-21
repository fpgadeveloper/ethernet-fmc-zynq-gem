# These constraints are suitable for ZCU102 Rev 1.0 (use earlier commits for Rev D)
# ---------------------------------------------------------------------------------
# Note that FMC pinout for ZCU102 Rev 1.0 (first released with the ES2 device) differs
# from the ZCU102 Rev D (released with the ES1 device). See answer record for
# more information: https://www.xilinx.com/support/answers/68050.html

# These constraints are for the ZCU102-HPC0-QGIGE design which
# uses 4x GEMs (with GMII-to-RGMII)

# Notes on ZCU102 HPC0 connector
# ------------------------------
#
# Ethernet FMC Port 0:
# --------------------
# * Requires LA00, LA02, LA03, LA04, LA05, LA06, LA07, LA08
# * All are routed to Bank 66
# * LA00 is routed to a clock capable pin
#
# Ethernet FMC Port 1:
# --------------------
# * Requires LA01, LA06, LA09, LA10, LA11, LA12, LA13, LA14, LA15, LA16
# * All are routed to Bank 66
# * LA01 is NOT routed to a clock capable pin
#
# Ethernet FMC Port 2:
# --------------------
# * Requires LA17, LA19, LA20, LA21, LA22, LA23, LA24, LA25
# * All are routed to Bank 67
# * LA17 is routed to a clock capable pin
#
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * All are routed to Bank 67
# * LA18 is NOT routed to a clock capable pin
#


# Enable internal termination resistor on LVDS 125MHz ref_clk
set_property DIFF_TERM TRUE [get_ports ref_clk_clk_p]
set_property DIFF_TERM TRUE [get_ports ref_clk_clk_n]

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

set_property PACKAGE_PIN AC2 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN AC1 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN W4 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN AC7 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN AC6 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN N9 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN N8 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN M10 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN L10 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN AB4 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN AC4 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN AB3 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN AC3 [get_ports reset_port_0]
set_property PACKAGE_PIN W2 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN W1 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN AB8 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN AC8 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN P11 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN L16 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN K16 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN L15 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN K15 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN Y4 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN Y3 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN Y2 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN Y1 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN V4 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN V3 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN W6 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN Y12 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN AA12 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN N13 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN M13 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN M15 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN M14 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN M11 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN L11 [get_ports mdio_io_port_2_mdio_io]
set_property PACKAGE_PIN U8 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN V8 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN V7 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN AA7 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN AA6 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN V2 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN V1 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN AA2 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN AA1 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN U5 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN U4 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN AB6 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN AB5 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN Y10 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN Y9 [get_ports reset_port_1]
set_property PACKAGE_PIN L13 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN K13 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN P12 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN N12 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN L12 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN K12 [get_ports reset_port_2]
set_property PACKAGE_PIN T7 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN T6 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN V6 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN U6 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN U11 [get_ports mdio_io_port_3_mdio_io]
set_property PACKAGE_PIN T11 [get_ports reset_port_3]

# Port 0 and 1: gmii_to_rgmii_0/1 - IODELAY_GROUP 0
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_0/U0/*_gmii_to_rgmii_0_0_core/*delay_rgmii_rxd*}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_0/U0/*_gmii_to_rgmii_0_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/*delay_rgmii_rxd*}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells *_i/util_idelay_ctrl_0/inst/dlyctrl]

# Port 2 and 3: gmii_to_rgmii_2/3 - IODELAY_GROUP 1
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_core/*delay_rgmii_rxd*}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_idelayctrl}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/*delay_rgmii_rxd*}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells *_i/util_idelay_ctrl_1/inst/dlyctrl]

# The following constraints come from the GMII to RGMII product guide
# http://www.xilinx.com/support/documentation/ip_documentation/gmii_to_rgmii/v4_0/pg160-gmii-to-rgmii.pdf

# Clock Period Constraints
create_clock -period 8.000 -name rgmii_port_0_rxc -add [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rxc -add [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rxc -add [get_ports rgmii_port_2_rxc]
create_clock -period 8.000 -name rgmii_port_3_rxc -add [get_ports rgmii_port_3_rxc]

#False path constraints to async inputs coming directly to synchronizer
set_false_path -to [get_pins -hier -filter {name =~ *idelayctrl_reset_gen/*reset_sync*/PRE }]
set_false_path -to [get_pins -of [get_cells -hier -filter { name =~ *i_MANAGEMENT/SYNC_*/data_sync* }] -filter { name =~ *D }]
set_false_path -to [get_pins -hier -filter {name =~ *reset_sync*/PRE }]
set_false_path -to [get_pins -hier -filter {name =~ *reset_sync*/PRE }]

#False path constraints from Control Register outputs
set_false_path -from [get_pins -hier -filter {name =~ *i_MANAGEMENT/DUPLEX_MODE_REG*/C }]
set_false_path -from [get_pins -hier -filter {name =~ *i_MANAGEMENT/SPEED_SELECTION_REG*/C }]

# constraint valid if parameter C_EXTERNAL_CLOCK = 0
set_case_analysis 0 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_clk/CE0}]
set_case_analysis 0 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_clk/S0}]
set_case_analysis 1 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_clk/CE1}]
set_case_analysis 1 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_clk/S1}]

#To Adjust GMII Tx Input Setup/Hold Timing
set_property DELAY_VALUE 1100 [get_cells -hier -filter {name =~ *gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
set_property DELAY_VALUE 1100 [get_cells -hier -filter {name =~ *delay_rgmii_rxd*}]

#Use the following constraint to modify the slew in the IOB
set_property SLEW FAST [get_ports {rgmii_port_0_td[3]}]
set_property SLEW FAST [get_ports {rgmii_port_0_td[2]}]
set_property SLEW FAST [get_ports {rgmii_port_0_td[1]}]
set_property SLEW FAST [get_ports {rgmii_port_0_td[0]}]
set_property SLEW FAST [get_ports rgmii_port_0_txc]
set_property SLEW FAST [get_ports rgmii_port_0_tx_ctl]
set_property SLEW FAST [get_ports {rgmii_port_1_td[3]}]
set_property SLEW FAST [get_ports {rgmii_port_1_td[2]}]
set_property SLEW FAST [get_ports {rgmii_port_1_td[1]}]
set_property SLEW FAST [get_ports {rgmii_port_1_td[0]}]
set_property SLEW FAST [get_ports rgmii_port_1_txc]
set_property SLEW FAST [get_ports rgmii_port_1_tx_ctl]
set_property SLEW FAST [get_ports {rgmii_port_2_td[3]}]
set_property SLEW FAST [get_ports {rgmii_port_2_td[2]}]
set_property SLEW FAST [get_ports {rgmii_port_2_td[1]}]
set_property SLEW FAST [get_ports {rgmii_port_2_td[0]}]
set_property SLEW FAST [get_ports rgmii_port_2_txc]
set_property SLEW FAST [get_ports rgmii_port_2_tx_ctl]
set_property SLEW FAST [get_ports {rgmii_port_3_td[3]}]
set_property SLEW FAST [get_ports {rgmii_port_3_td[2]}]
set_property SLEW FAST [get_ports {rgmii_port_3_td[1]}]
set_property SLEW FAST [get_ports {rgmii_port_3_td[0]}]
set_property SLEW FAST [get_ports rgmii_port_3_txc]
set_property SLEW FAST [get_ports rgmii_port_3_tx_ctl]

# Sub-optimal placement for a global clock-capable IO pin and BUFG pair.If this sub optimal condition
# is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to 
# demote this message to a WARNING. However, the use of this override is highly discouraged.
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets *_i/gmii_to_rgmii_1/U0/rgmii_rxc_ibuf_i/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets *_i/gmii_to_rgmii_3/U0/rgmii_rxc_ibuf_i/O]

# BITSLICE0 not available during BISC - The port rgmii_port_1_rxc is assigned to a PACKAGE_PIN that uses BITSLICE_1 of a
# Byte that will be using calibration. The signal connected to rgmii_port_1_rxc will not be available during calibration 
# and will only be available after RDY asserts. If this condition is not acceptable for your design and board layout, 
# rgmii_port_1_rxc will have to be moved to another PACKAGE_PIN that is not undergoing calibration or be moved to a 
# PACKAGE_PIN location that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for your 
# design and board layout, this DRC can be bypassed by acknowledging the condition and setting the following XDC constraint:

set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_1_rxc]
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_3_rxc]

# The below constraints place the BUFGCEs into the clock regions of their respective IO pins, which is needed 
# for timing closure of the RGMII RX interfaces.

set_property CLOCK_REGION X3Y2 [get_cells *_i/gmii_to_rgmii_0/U0/*_gmii_to_rgmii_0_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
#set_property CLOCK_REGION X3Y2 [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
#set_property CLOCK_REGION X3Y3 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
#set_property CLOCK_REGION X3Y3 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
#set_property CLOCK_REGION X3Y3 [get_cells *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 1,2 and 3
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y64 [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y63 [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y89 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y88 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y85 [get_cells *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y84 [get_cells *_i/gmii_to_rgmii_3/U0/*_gmii_to_rgmii_3_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_zcu102_hpc0_qgige_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu102_hpc0_qgige_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu102_hpc0_qgige_clk_wiz_0_0] -to [get_clocks mdio2_mdc_clock]
set_false_path -from [get_clocks clk_out1_zcu102_hpc0_qgige_clk_wiz_0_0] -to [get_clocks mdio3_mdc_clock]
