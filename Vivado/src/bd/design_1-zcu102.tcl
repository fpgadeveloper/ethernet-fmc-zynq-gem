################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

set design_name design_1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

create_bd_design $design_name

current_bd_design $design_name

set parentCell [get_bd_cells /]

# Get object for parentCell
set parentObj [get_bd_cells $parentCell]
if { $parentObj == "" } {
   puts "ERROR: Unable to find parent cell <$parentCell>!"
   return
}

# Make sure parentObj is hier blk
set parentType [get_property TYPE $parentObj]
if { $parentType ne "hier" } {
   puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
   return
}

# Save current instance; Restore later
set oldCurInst [current_bd_instance .]

# Set parent object as current
current_bd_instance $parentObj

# Add the Processor System and apply board preset
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:1.1 zynq_ultra_ps_e_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]

# Configure the PS: Enable GEM0, GEM1
startgroup
set_property -dict [list CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {1} CONFIG.PSU__ENET0__PERIPHERAL__IO {EMIO} CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {1} CONFIG.PSU__ENET1__PERIPHERAL__IO {EMIO} CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} CONFIG.PSU__TTC0__PERIPHERAL__IO {EMIO}] [get_bd_cells zynq_ultra_ps_e_0]
endgroup

# Connect the PL_CLK0 to the HPM0
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk]

# Add the GMII-to-RGMIIs
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:gmii_to_rgmii:4.0 gmii_to_rgmii_0
create_bd_cell -type ip -vlnv xilinx.com:ip:gmii_to_rgmii:4.0 gmii_to_rgmii_2
endgroup
set_property -dict [list CONFIG.C_USE_IDELAY_CTRL {false}] [get_bd_cells gmii_to_rgmii_0]
set_property -dict [list CONFIG.C_USE_IDELAY_CTRL {true} CONFIG.SupportLevel {Include_Shared_Logic_in_Core}] [get_bd_cells gmii_to_rgmii_2]

# Connect GMII-to-RGMIIs to the GEMs
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/GMII_ENET0] [get_bd_intf_pins gmii_to_rgmii_0/GMII]
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/MDIO_ENET0] [get_bd_intf_pins gmii_to_rgmii_0/MDIO_GEM]
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/GMII_ENET1] [get_bd_intf_pins gmii_to_rgmii_2/GMII]
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/MDIO_ENET1] [get_bd_intf_pins gmii_to_rgmii_2/MDIO_GEM]

# Connect the clocks
connect_bd_net [get_bd_pins gmii_to_rgmii_2/mmcm_locked_out] [get_bd_pins gmii_to_rgmii_0/mmcm_locked_in]
connect_bd_net [get_bd_pins gmii_to_rgmii_2/ref_clk_out] [get_bd_pins gmii_to_rgmii_0/ref_clk_in]
connect_bd_net [get_bd_pins gmii_to_rgmii_2/gmii_clk_125m_out] [get_bd_pins gmii_to_rgmii_0/gmii_clk_125m_in]
connect_bd_net [get_bd_pins gmii_to_rgmii_2/gmii_clk_25m_out] [get_bd_pins gmii_to_rgmii_0/gmii_clk_25m_in]
connect_bd_net [get_bd_pins gmii_to_rgmii_2/gmii_clk_2_5m_out] [get_bd_pins gmii_to_rgmii_0/gmii_clk_2_5m_in]

# Make AXI Ethernet/GMII-to-RGMII ports external: MDIO, RGMII and RESET
# MDIO
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_0
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_0/MDIO_PHY] [get_bd_intf_ports mdio_io_port_0]
endgroup
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_2
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_2/MDIO_PHY] [get_bd_intf_ports mdio_io_port_2]
endgroup
# RGMII
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_0
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_0/RGMII] [get_bd_intf_ports rgmii_port_0]
endgroup
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_2
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_2/RGMII] [get_bd_intf_ports rgmii_port_2]
endgroup

# PHY RESET for GMII-to-RGMII ports 0 and 2

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 util_reduced_logic_0
endgroup
startgroup
set_property -dict [list CONFIG.C_SIZE {1}] [get_bd_cells util_reduced_logic_0]
endgroup
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins util_reduced_logic_0/Op1]
startgroup
create_bd_port -dir O reset_port_0
connect_bd_net [get_bd_pins /util_reduced_logic_0/Res] [get_bd_ports reset_port_0]
create_bd_port -dir O reset_port_2
connect_bd_net [get_bd_pins /util_reduced_logic_0/Res] [get_bd_ports reset_port_2]
endgroup

# Invert reset signal to get active HIGH reset
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0
endgroup
startgroup
set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_0]
endgroup
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins util_vector_logic_0/Op1]

# Connect GMII-to-RGMII resets
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins gmii_to_rgmii_0/tx_reset]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins gmii_to_rgmii_0/rx_reset]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins gmii_to_rgmii_2/tx_reset]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins gmii_to_rgmii_2/rx_reset]

# Create clock wizard for the Ethernet FMC 125MHz clock and the 200MHz clock

create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_0
set_property -dict [list CONFIG.PRIM_IN_FREQ.VALUE_SRC USER] [get_bd_cells clk_wiz_0]
set_property -dict [list CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} CONFIG.PRIM_IN_FREQ {125} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.USE_LOCKED {false} CONFIG.USE_RESET {false} CONFIG.CLKIN1_JITTER_PS {80.0} CONFIG.MMCM_DIVCLK_DIVIDE {5} CONFIG.MMCM_CLKFBOUT_MULT_F {48.000} CONFIG.MMCM_CLKIN1_PERIOD {8.0} CONFIG.MMCM_CLKOUT0_DIVIDE_F {6.000} CONFIG.CLKOUT1_JITTER {161.295} CONFIG.CLKOUT1_PHASE_ERROR {222.305}] [get_bd_cells clk_wiz_0]

connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins gmii_to_rgmii_2/clkin]

# Connect ports for the Ethernet FMC 125MHz clock
create_bd_port -dir I -from 0 -to 0 ref_clk_p
connect_bd_net [get_bd_pins /clk_wiz_0/clk_in1_p] [get_bd_ports ref_clk_p]
create_bd_port -dir I -from 0 -to 0 ref_clk_n
connect_bd_net [get_bd_pins /clk_wiz_0/clk_in1_n] [get_bd_ports ref_clk_n]

# Create IDELAYCTRL for the GMII-to-RGMII without shared logic
create_bd_cell -type ip -vlnv xilinx.com:ip:util_idelay_ctrl:1.0 util_idelay_ctrl_0
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins util_idelay_ctrl_0/ref_clk]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins util_idelay_ctrl_0/rst]

# Create Ethernet FMC reference clock output enable and frequency select

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 ref_clk_oe
endgroup
startgroup
create_bd_port -dir O -from 0 -to 0 ref_clk_oe
connect_bd_net [get_bd_pins /ref_clk_oe/dout] [get_bd_ports ref_clk_oe]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 ref_clk_fsel
endgroup
startgroup
create_bd_port -dir O -from 0 -to 0 ref_clk_fsel
connect_bd_net [get_bd_pins /ref_clk_fsel/dout] [get_bd_ports ref_clk_fsel]
endgroup

# Restore current instance
current_bd_instance $oldCurInst

save_bd_design
