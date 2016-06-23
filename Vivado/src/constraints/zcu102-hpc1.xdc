# These constraints are for the ZCU102-HPC1-QGIGE design which
# uses 3x GEMs (with GMII-to-RGMII) and 1x AXI Ethernet Subsystem IP

# Notes on ZCU102 HPC1 connector
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
# * LA22, LA23, LA24, LA25 are routed to Bank 65
# * LA17, LA19, LA20, LA21 are routed to Bank 66
# * LA17 is routed to a clock capable pin
# 
# Ethernet FMC Port 3:
# --------------------
# * Requires LA18, LA26, LA27, LA28, LA29, LA30, LA31, LA32
# * LA30, LA31 and LA32 are not connected on the ZCU102
# * Port 3 cannot be used due to the missing connections
# 


# Enable internal termination resistor on LVDS 125MHz ref_clk
set_property DIFF_TERM TRUE [get_ports {ref_clk_p[0]}]
set_property DIFF_TERM TRUE [get_ports {ref_clk_n[0]}]

# Define I/O standards
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_0_mdio_io]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ref_clk_fsel[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_1_mdio_io]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_rxc]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_rx_ctl]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[3]}]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_rxc]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_0_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_0]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ref_clk_oe[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_1_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[3]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_rxc]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[2]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[2]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_rx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_tx_ctl]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_2_mdio_io]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[2]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[3]}]
set_property IOSTANDARD LVDS [get_ports {ref_clk_p[0]}]
set_property IOSTANDARD LVDS [get_ports {ref_clk_n[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_txc]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_0_td[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_0_tx_ctl]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_td[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_txc]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_1_tx_ctl]
#set_property IOSTANDARD LVCMOS18 [get_ports reset_port_1]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_rd[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_2_txc]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_2_td[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_2_mdc]
set_property IOSTANDARD LVCMOS18 [get_ports reset_port_2]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_txc]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_tx_ctl]
#set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_3_mdc]
#set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_3_mdio_io]
#set_property IOSTANDARD LVCMOS18 [get_ports reset_port_3]

#set_property PACKAGE_PIN AH2 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN AJ2 [get_ports mdio_io_port_0_mdio_io]
#set_property PACKAGE_PIN AJ4 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN AH7 [get_ports {ref_clk_fsel[0]}]
#set_property PACKAGE_PIN AH6 [get_ports mdio_io_port_1_mdio_io]
#set_property PACKAGE_PIN AB9 [get_ports rgmii_port_3_rxc]
#set_property PACKAGE_PIN AC9 [get_ports rgmii_port_3_rx_ctl]
#set_property PACKAGE_PIN U10 [get_ports {rgmii_port_3_rd[1]}]
#set_property PACKAGE_PIN T10 [get_ports {rgmii_port_3_rd[3]}]
#set_property PACKAGE_PIN AE2 [get_ports rgmii_port_1_rxc]
#set_property PACKAGE_PIN AE1 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN AG3 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN AH3 [get_ports reset_port_0]
#set_property PACKAGE_PIN AJ6 [get_ports {rgmii_port_1_rd[1]}]
#set_property PACKAGE_PIN AJ5 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN AG8 [get_ports {ref_clk_oe[0]}]
#set_property PACKAGE_PIN AH8 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN Y5 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN AE12 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN AF12 [get_ports {rgmii_port_2_rd[3]}]
#set_property PACKAGE_PIN T12 [get_ports {rgmii_port_3_rd[0]}]
#set_property PACKAGE_PIN R12 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN AE5 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN AF5 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN AH1 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN AJ1 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN AE3 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN AF3 [get_ports {rgmii_port_0_td[2]}]
#set_property PACKAGE_PIN AD6 [get_ports {rgmii_port_1_td[0]}]
#set_property PACKAGE_PIN AG10 [get_ports {rgmii_port_1_td[2]}]
#set_property PACKAGE_PIN AG9 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN AB11 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN AB10 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN AF11 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN AG11 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN AE10 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN AF10 [get_ports mdio_io_port_2_mdio_io]
#set_property PACKAGE_PIN W11 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN AE7 [get_ports {ref_clk_p[0]}]
set_property PACKAGE_PIN AF7 [get_ports {ref_clk_n[0]}]
set_property PACKAGE_PIN AD2 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN AD1 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN AF2 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN AF1 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN AD4 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN AE4 [get_ports rgmii_port_0_tx_ctl]
#set_property PACKAGE_PIN AE8 [get_ports {rgmii_port_1_td[1]}]
#set_property PACKAGE_PIN AF8 [get_ports rgmii_port_1_txc]
#set_property PACKAGE_PIN AD10 [get_ports rgmii_port_1_tx_ctl]
#set_property PACKAGE_PIN AE9 [get_ports reset_port_1]
set_property PACKAGE_PIN AA11 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN AA10 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN AC12 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN AC11 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN AH12 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN AH11 [get_ports reset_port_2]
#set_property PACKAGE_PIN T13 [get_ports {rgmii_port_3_td[1]}]
#set_property PACKAGE_PIN R13 [get_ports rgmii_port_3_txc]

# -----------------------------------------
# IODELAY_GROUP constraints - COMMENTED OUT
# -----------------------------------------
# The below constraints are intended for grouping the IDELAY/ODELAY/IDELAY_CTRLs of different I/O banks.
# They are commented out because they produce errors due to the fact that the FMC pins associated with port 2 of the
# Ethernet FMC are routed to two different I/O banks on the ZCU102 HPC1 connector. We cannot create an IODELAY_GROUP
# containing primitives from different I/O banks. With these constraints commented out, we are able to get a bitstream,
# which indicates that the tools are able to correctly group the IDELAY/ODELAY/IDELAY_CTRLs. However, it might
# be a better practice to eventually revise these constraints so that they create the IODELAY_GROUPs based on their 
# bank assignment and not on their port assignment.

# Port 0: gmii_to_rgmii_0 - IODELAY_GROUP 0
#current_instance *_i/gmii_to_rgmii_0/U0
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells -hier -filter {name =~ *_gmii_to_rgmii_0_0_core/*delay_rgmii_rxd*}]
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells -hier -filter {name =~ *_gmii_to_rgmii_0_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
#current_instance -quiet
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp0 [get_cells *_i/util_idelay_ctrl_0/inst/dlyctrl]

# Port 2: gmii_to_rgmii_2 - IODELAY_GROUP 1
#current_instance *_i/gmii_to_rgmii_2/U0
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_gmii_to_rgmii_2_0_core/*delay_rgmii_rxd*}]
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *_gmii_to_rgmii_2_0_idelayctrl}]
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp1 [get_cells -hier -filter {name =~ *i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
#current_instance -quiet

# The following constraints come from the GMII to RGMII product guide
# http://www.xilinx.com/support/documentation/ip_documentation/gmii_to_rgmii/v4_0/pg160-gmii-to-rgmii.pdf

# Clock Period Constraints
create_clock -period 8.000 -name rgmii_port_0_rxc -add [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_2_rxc -add [get_ports rgmii_port_2_rxc]

# Clock constraint if parameter C_EXTERNAL_CLOCK = 1
#create_clock -add -name gmii_clk  -period 8.000 [get_ports gmii_clk]

# Clock constraint if parameter C_EXTERNAL_CLOCK = 1 and clock skew on TXC is through MMCM
#create_clock -add -name gmii_clk_90  -period 8.000 -waveform {2 6} [get_ports gmii_clk_90]

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

# constraint valid if parameter C_EXTERNAL_CLOCK = 0 and clock skew on TXC is through MMCM
#set_case_analysis 0 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_90_clk/CE0}]
#set_case_analysis 0 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_90_clk/S0}]
#set_case_analysis 1 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_90_clk/CE1}]
#set_case_analysis 1 [get_pins -hier -filter {name =~ *i_bufgmux_gmii_90_clk/S1}]

#To Adjust GMII Tx Input Setup/Hold Timing
set_property DELAY_VALUE 1250 [get_cells -hier -filter {name =~ *gen_rgmii_rx_zqup.delay_rgmii_rx_ctl}]
set_property DELAY_VALUE 1250 [get_cells -hier -filter {name =~ *delay_rgmii_rxd*}]
#set_property IODELAY_GROUP gpr1 [get_cells *delay_rgmii_rx_ctl]
#set_property IODELAY_GROUP gpr1 [get_cells -hier -filter {name =~ *delay_rgmii_rxd*}]
#set_property IODELAY_GROUP gpr1 [get_cells *idelayctrl]

#Use the following constraint to modify the slew in the IOB
set_property SLEW FAST [get_ports {rgmii_port_0_td[3]}]
set_property SLEW FAST [get_ports {rgmii_port_0_td[2]}]
set_property SLEW FAST [get_ports {rgmii_port_0_td[1]}]
set_property SLEW FAST [get_ports {rgmii_port_0_td[0]}]
set_property SLEW FAST [get_ports rgmii_port_0_txc]
set_property SLEW FAST [get_ports rgmii_port_0_tx_ctl]
set_property SLEW FAST [get_ports {rgmii_port_2_td[3]}]
set_property SLEW FAST [get_ports {rgmii_port_2_td[2]}]
set_property SLEW FAST [get_ports {rgmii_port_2_td[1]}]
set_property SLEW FAST [get_ports {rgmii_port_2_td[0]}]
set_property SLEW FAST [get_ports rgmii_port_2_txc]
set_property SLEW FAST [get_ports rgmii_port_2_tx_ctl]

# Rename the gmii_to_rgmii_0_gmii_clk_125m_out clock to gmii_clk_125m_out so that the in-built constraints will find it
# Based on AR57197: http://www.xilinx.com/support/answers/57197.html
create_generated_clock -name gmii_clk_125m_out [get_pins *_i/gmii_to_rgmii_2/U0/i_*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst/CLKOUT0]

# From AR65947 : http://www.xilinx.com/support/answers/65947.html

# BUFG on 200 MHz input clock
#set_property CLOCK_REGION X3Y0      [get_cells {example_clocks/bufg_clkin1}]
# BUFG on GTX Clock
#set_property CLOCK_REGION X3Y2      [get_cells *_i/clk_wiz_0/inst/clkout1_buf]
# BUFG on RX Clock input
#set_property CLOCK_REGION X3Y3      [get_cells *_i/gmii_to_rgmii_2/U0/i_*_gmii_to_rgmii_2_0_clocking/clk10_div_buf]

