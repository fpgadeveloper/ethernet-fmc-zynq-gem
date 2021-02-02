################################################################
# Block diagram build script for Zynq MP designs
################################################################

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
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]

# Disable all of the GP ports
set_property -dict [list CONFIG.PSU__USE__M_AXI_GP0 {0} \
CONFIG.PSU__USE__M_AXI_GP1 {0} \
CONFIG.PSU__USE__M_AXI_GP2 {0}] [get_bd_cells zynq_ultra_ps_e_0]

# Number of GEMs in this design (2, 3 or 4) for Ethernet FMC usage
# Note: When $num_gems < 4 and the board definition sets up GEM3 for
#       on-board Ethernet (via MDIO), we don't change GEM3 settings.
set gem2_enable 0
set gem3_enable 0
if {$num_gems >= 3} {
  set gem2_enable 1
}
if {$num_gems >= 4} {
  set gem3_enable 1
}

# Configure the PS: Enable GEM0, GEM1 and GEM2 for EMIO
set_property -dict [list CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__ENET0__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__ENET1__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__ENET2__PERIPHERAL__ENABLE $gem2_enable \
CONFIG.PSU__ENET2__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__ENET0__GRP_MDIO__ENABLE {1} \
CONFIG.PSU__ENET0__GRP_MDIO__IO {EMIO} \
CONFIG.PSU__ENET1__GRP_MDIO__ENABLE {1} \
CONFIG.PSU__ENET1__GRP_MDIO__IO {EMIO} \
CONFIG.PSU__ENET2__GRP_MDIO__ENABLE $gem2_enable \
CONFIG.PSU__ENET2__GRP_MDIO__IO {EMIO} \
CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__TTC0__PERIPHERAL__IO {EMIO}] [get_bd_cells zynq_ultra_ps_e_0]

# Configure the PS: Enable GEM3 for EMIO
# If the Ethernet FMC doesn't need GEM3, then we don't change it's settings because
# some board definitions will use GEM3 for an on-board Ethernet port (eg. ZCU102).
if {$gem3_enable} {
  set_property -dict [list CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__ENET3__PERIPHERAL__IO {EMIO} \
  CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
  CONFIG.PSU__ENET3__GRP_MDIO__IO {EMIO}] [get_bd_cells zynq_ultra_ps_e_0]
}

# Add a processor system reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_zynq_ultra_ps_e_0_100M
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins rst_zynq_ultra_ps_e_0_100M/slowest_sync_clk]
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins rst_zynq_ultra_ps_e_0_100M/ext_reset_in]

# Add the GMII-to-RGMIIs
for {set i 0} {$i < $num_gems} {incr i} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:gmii_to_rgmii gmii_to_rgmii_$i
}

# In 2 GEM designs, the 1st GMII-to-RGMII will have the IDELAY CTRL
# In 3+ GEM designs, the 3rd GMII-to-RGMII will have the IDELAY CTRL
if {$num_gems > 2} {
  set with_idelay_ctrl 2
} else {
  set with_idelay_ctrl 0
}

# Configure one GMII-to-RGMII with the IDELAY CTRL and the others without
for {set i 0} {$i < $num_gems} {incr i} {
  if {$i eq $with_idelay_ctrl} {
    set_property -dict [list CONFIG.C_USE_IDELAY_CTRL {true} CONFIG.SupportLevel {Include_Shared_Logic_in_Core}] [get_bd_cells gmii_to_rgmii_$i]
  } else {
    set_property -dict [list CONFIG.C_USE_IDELAY_CTRL {false}] [get_bd_cells gmii_to_rgmii_$i]
  }
}

# Connect GMII-to-RGMIIs to the GEMs
for {set i 0} {$i < $num_gems} {incr i} {
  connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/GMII_ENET$i] [get_bd_intf_pins gmii_to_rgmii_$i/GMII]
  connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/MDIO_ENET$i] [get_bd_intf_pins gmii_to_rgmii_$i/MDIO_GEM]
}

# Connect the clocks
for {set i 0} {$i < $num_gems} {incr i} {
  if {$i eq $with_idelay_ctrl} {
    continue
  }
  connect_bd_net [get_bd_pins gmii_to_rgmii_$with_idelay_ctrl/mmcm_locked_out] [get_bd_pins gmii_to_rgmii_$i/mmcm_locked_in]
  connect_bd_net [get_bd_pins gmii_to_rgmii_$with_idelay_ctrl/ref_clk_out] [get_bd_pins gmii_to_rgmii_$i/ref_clk_in]
  connect_bd_net [get_bd_pins gmii_to_rgmii_$with_idelay_ctrl/gmii_clk_125m_out] [get_bd_pins gmii_to_rgmii_$i/gmii_clk_125m_in]
  connect_bd_net [get_bd_pins gmii_to_rgmii_$with_idelay_ctrl/gmii_clk_25m_out] [get_bd_pins gmii_to_rgmii_$i/gmii_clk_25m_in]
  connect_bd_net [get_bd_pins gmii_to_rgmii_$with_idelay_ctrl/gmii_clk_2_5m_out] [get_bd_pins gmii_to_rgmii_$i/gmii_clk_2_5m_in]
}

# Make AXI Ethernet/GMII-to-RGMII ports external: MDIO, RGMII and RESET
for {set i 0} {$i < $num_gems} {incr i} {
  # MDIO
  create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_$i
  connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_$i/MDIO_PHY] [get_bd_intf_ports mdio_io_port_$i]
  # RGMII
  create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_$i
  connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_$i/RGMII] [get_bd_intf_ports rgmii_port_$i]
  # PHY RESET
  create_bd_port -dir O reset_port_$i
  connect_bd_net [get_bd_pins /rst_zynq_ultra_ps_e_0_100M/peripheral_aresetn] [get_bd_ports reset_port_$i]
  # Connect GMII-to-RGMII resets
  connect_bd_net [get_bd_pins rst_zynq_ultra_ps_e_0_100M/peripheral_reset] [get_bd_pins gmii_to_rgmii_$i/tx_reset]
  connect_bd_net [get_bd_pins rst_zynq_ultra_ps_e_0_100M/peripheral_reset] [get_bd_pins gmii_to_rgmii_$i/rx_reset]
}

# Create clock wizard for the 375MHz clock

create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0
set_property -dict [list CONFIG.PRIM_IN_FREQ.VALUE_SRC USER] [get_bd_cells clk_wiz_0]
set_property -dict [list CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
CONFIG.PRIM_IN_FREQ {125} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {375} \
CONFIG.USE_LOCKED {false} \
CONFIG.USE_RESET {false} \
CONFIG.CLKIN1_JITTER_PS {80.0} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.MMCM_CLKFBOUT_MULT_F {9.750} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {3.250} \
CONFIG.CLKOUT1_JITTER {86.562} \
CONFIG.CLKOUT1_PHASE_ERROR {84.521}] [get_bd_cells clk_wiz_0]

connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins gmii_to_rgmii_$with_idelay_ctrl/clkin]

# Connect ports for the Ethernet FMC 125MHz clock
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ref_clk
set_property -dict [list CONFIG.FREQ_HZ {125000000}] [get_bd_intf_ports ref_clk]
connect_bd_intf_net [get_bd_intf_ports ref_clk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]

# Create IDELAYCTRL for the GMII-to-RGMII without shared logic
if {$num_gems > 2} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:util_idelay_ctrl util_idelay_ctrl_0
  connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins util_idelay_ctrl_0/ref_clk]
  # Processor System Reset for the IDELAYCTRL reset
  create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_0
  connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins util_idelay_ctrl_0/rst]
  connect_bd_net [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]
}

# Create Ethernet FMC reference clock output enable and frequency select
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant ref_clk_oe
create_bd_port -dir O -from 0 -to 0 ref_clk_oe
connect_bd_net [get_bd_pins /ref_clk_oe/dout] [get_bd_ports ref_clk_oe]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant ref_clk_fsel
create_bd_port -dir O -from 0 -to 0 ref_clk_fsel
connect_bd_net [get_bd_pins /ref_clk_fsel/dout] [get_bd_ports ref_clk_fsel]

# Audio clock for TEBF0808 board
set audio_pin [get_bd_pins zynq_ultra_ps_e_0/dp_audio_ref_clk]
if {$audio_pin != ""} {
  connect_bd_net $audio_pin [get_bd_pins zynq_ultra_ps_e_0/dp_s_axis_audio_clk]
}

# Restore current instance
current_bd_instance $oldCurInst

save_bd_design
