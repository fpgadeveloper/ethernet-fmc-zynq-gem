# These constraints are suitable for ZCU102 Rev 1.0 (use earlier commits for Rev D)
# ---------------------------------------------------------------------------------
# Note that FMC pinout for ZCU102 Rev 1.0 (first released with the ES2 device) differs
# from the ZCU102 Rev D (released with the ES1 device). See answer record for
# more information: https://www.xilinx.com/support/answers/68050.html

# These constraints are for the ZCU102-HPC1-QGIGE design which
# uses 3x GEMs (with GMII-to-RGMII)

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
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_0_mdio_io]
set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_1_rd[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ref_clk_fsel[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_1_mdio_io]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_rxc]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_rx_ctl]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[3]}]
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
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_rd[2]}]
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
#set_property IOSTANDARD LVCMOS18 [get_ports {rgmii_port_3_td[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_txc]
#set_property IOSTANDARD LVCMOS18 [get_ports rgmii_port_3_tx_ctl]
#set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_3_mdc]
#set_property IOSTANDARD LVCMOS18 [get_ports mdio_io_port_3_mdio_io]
#set_property IOSTANDARD LVCMOS18 [get_ports reset_port_3]

set_property PACKAGE_PIN AH2 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN AJ2 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN AJ4 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN AH7 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN AH6 [get_ports mdio_io_port_1_mdio_io]
#set_property PACKAGE_PIN Y8 [get_ports rgmii_port_3_rxc]
#set_property PACKAGE_PIN Y7 [get_ports rgmii_port_3_rx_ctl]
#set_property PACKAGE_PIN U10 [get_ports {rgmii_port_3_rd[1]}]
#set_property PACKAGE_PIN T10 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN AJ6 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN AJ5 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN AG3 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN AH3 [get_ports reset_port_0]
set_property PACKAGE_PIN AE2 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN AE1 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN AG8 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN AH8 [get_ports mdio_io_port_1_mdc]
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
set_property PACKAGE_PIN AD6 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN AG10 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN AG9 [get_ports {rgmii_port_1_td[3]}]
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
set_property PACKAGE_PIN AE8 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN AF8 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN AD10 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN AE9 [get_ports reset_port_1]
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
create_clock -period 8.000 -name rgmii_port_1_rxc -add [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rxc -add [get_ports rgmii_port_2_rxc]

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

# Sub-optimal placement for a global clock-capable IO pin and BUFG pair.If this sub optimal condition
# is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to 
# demote this message to a WARNING. However, the use of this override is highly discouraged.
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets zcu102_hpc1_qgige_i/gmii_to_rgmii_1/U0/rgmii_rxc_ibuf_i/O]

# CRITICAL WARNING: [DRC 23-20] Rule violation (PDRC-203) BITSLICE0 not available during BISC - 
# The port rgmii_port_2_tx_ctl is assigned to a PACKAGE_PIN that uses BITSLICE_0 of a Byte that 
# will be using calibration. The signal connected to rgmii_port_2_tx_ctl will not be available 
# during calibration and will only be available after RDY asserts. If this condition is not 
# acceptable for your design and board layout, rgmii_port_2_tx_ctl will have to be moved to 
# another PACKAGE_PIN that is not undergoing calibration or be moved to a PACKAGE_PIN location 
# that is not BITSLICE_0 or BITSLICE_6 on that same Byte. If this condition is acceptable for 
# your design and board layout, this DRC can be bypassed by acknowledging the condition and 
# setting the following XDC constraint: 
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_1_rxc]
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_2_tx_ctl]
set_property UNAVAILABLE_DURING_CALIBRATION TRUE [get_ports rgmii_port_2_txc]

# The following constraints are needed in Vivado 2017.1 to correct the MMCM configuration made by the
# shared logic of the GMII-to-RGMII IP. If left uncorrected, the configuration made by the IP produces an error message
# which I have posted about on the Xilinx forums:
# https://forums.xilinx.com/t5/UltraScale-Architecture/GMII-to-RGMII-MMCM-config-issue-in-Vivado-2017-1-for-ZCU102/m-p/768183#M4411

set_property CLKFBOUT_MULT_F 25 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst]
set_property CLKOUT0_DIVIDE_F 10 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst]
set_property CLKOUT1_DIVIDE 50 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst]
set_property CLKOUT1_PHASE 225 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst]
set_property CLKOUT2_DIVIDE 125 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst]
set_property DIVCLK_DIVIDE 4 [get_cells *_i/gmii_to_rgmii_2/U0/*_gmii_to_rgmii_2_0_clocking/mmcm_adv_inst]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC port 1 and 2
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y36 [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y35 [get_cells *_i/gmii_to_rgmii_1/U0/*_gmii_to_rgmii_1_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]

set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y49 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufg_rgmii_rx_clk]
set_property BEL BUFCE [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]
set_property LOC BUFGCE_X0Y48 [get_cells *_i/gmii_to_rgmii_2/U0/i_gmii_to_rgmii_block/*_gmii_to_rgmii_2_0_core/i_gmii_to_rgmii/i_gmii_to_rgmii/bufio_rgmii_rx_clk]

