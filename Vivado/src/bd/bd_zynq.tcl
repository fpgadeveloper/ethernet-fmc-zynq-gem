################################################################
# Block diagram build script
################################################################

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

create_bd_design $block_name

current_bd_design $block_name

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

# Use AXI Ethernet IP in this design for ports 0,1,2
set use_axi_eth 1

# Add the Processor System and apply board preset
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

# Configure the PS: Enable ETH1, Enable HP0, Enable interrupts
set_property -dict [list CONFIG.PCW_USE_M_AXI_GP0 {1} CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET1_GRP_MDIO_ENABLE {1}] [get_bd_cells processing_system7_0]

# Connect the FCLK_CLK0 to the PS GP0 and HP0
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK]

# Processor system reset for 100MHz FCLK0 clock
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_ps7_0_100M
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins rst_ps7_0_100M/slowest_sync_clk]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_100M/ext_reset_in]

# Clock wizard to generate 125MHz and 200MHz from Ethernet FMC reference clock
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0
set_property -dict [list CONFIG.PRIM_IN_FREQ.VALUE_SRC USER] [get_bd_cells clk_wiz_0]
set_property -dict [list CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
CONFIG.PRIM_IN_FREQ {125} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {200} \
CONFIG.USE_RESET {false} \
CONFIG.CLKIN1_JITTER_PS {80.0} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.MMCM_CLKFBOUT_MULT_F {8.000} \
CONFIG.MMCM_CLKIN1_PERIOD {8.000} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {5} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.CLKOUT1_JITTER {119.348} \
CONFIG.CLKOUT1_PHASE_ERROR {96.948} \
CONFIG.CLKOUT2_JITTER {109.241} \
CONFIG.CLKOUT2_PHASE_ERROR {96.948}] [get_bd_cells clk_wiz_0]

# Processor system reset for 125MHz clock
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_clk_wiz_0_125M
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins rst_clk_wiz_0_125M/slowest_sync_clk]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_clk_wiz_0_125M/dcm_locked]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_clk_wiz_0_125M/ext_reset_in]

# Create port for Ethernet FMC reference clock and connect to clock wizard
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ref_clk
set_property -dict [list CONFIG.FREQ_HZ {125000000}] [get_bd_intf_ports ref_clk]
connect_bd_intf_net [get_bd_intf_ports ref_clk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]

if {$use_axi_eth} {
   # Add the concat for the interrupts
   create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0
   connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]
   set_property -dict [list CONFIG.NUM_PORTS {12}] [get_bd_cells xlconcat_0]

   # Add the AXI Ethernet IPs
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet axi_ethernet_0
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet axi_ethernet_1
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet axi_ethernet_2

   # Configure all ports for full checksum hardware offload
   set_property -dict [list CONFIG.TXCSUM {Full} CONFIG.RXCSUM {Full}] [get_bd_cells axi_ethernet_0]
   set_property -dict [list CONFIG.TXCSUM {Full} CONFIG.RXCSUM {Full}] [get_bd_cells axi_ethernet_1]
   set_property -dict [list CONFIG.TXCSUM {Full} CONFIG.RXCSUM {Full}] [get_bd_cells axi_ethernet_2]

   # Configure ports 1,2 and 3 for "Don't include shared logic"
   set_property -dict [list CONFIG.SupportLevel {0}] [get_bd_cells axi_ethernet_2]
   set_property -dict [list CONFIG.SupportLevel {0}] [get_bd_cells axi_ethernet_1]
   set_property -dict [list CONFIG.SupportLevel {1}] [get_bd_cells axi_ethernet_0]

   # Configure all AXI Ethernet: RGMII with DMA
   set_property -dict [list CONFIG.PHY_TYPE {RGMII}] [get_bd_cells axi_ethernet_0]
   set_property -dict [list CONFIG.PHY_TYPE {RGMII}] [get_bd_cells axi_ethernet_1]
   set_property -dict [list CONFIG.PHY_TYPE {RGMII}] [get_bd_cells axi_ethernet_2]

   # MicroZed 7020: Configure all AXI Ethernet for no frame filter and no statistics counter (saves LUTs)
   if {$target == "mz_7020"} {
     set_property -dict [list CONFIG.Frame_Filter {false} CONFIG.Statistics_Counters {false}] [get_bd_cells axi_ethernet_0]
     set_property -dict [list CONFIG.Frame_Filter {false} CONFIG.Statistics_Counters {false}] [get_bd_cells axi_ethernet_1]
     set_property -dict [list CONFIG.Frame_Filter {false} CONFIG.Statistics_Counters {false}] [get_bd_cells axi_ethernet_2]
   }

   # Connect AXI Ethernet clocks
   connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_ethernet_0/gtx_clk]
   connect_bd_net [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins axi_ethernet_0/ref_clk]
   connect_bd_net [get_bd_pins axi_ethernet_0/gtx_clk_out] [get_bd_pins axi_ethernet_1/gtx_clk]
   connect_bd_net [get_bd_pins axi_ethernet_0/gtx_clk_out] [get_bd_pins axi_ethernet_2/gtx_clk]
   connect_bd_net [get_bd_pins axi_ethernet_0/gtx_clk90_out] [get_bd_pins axi_ethernet_1/gtx_clk90]
   connect_bd_net [get_bd_pins axi_ethernet_0/gtx_clk90_out] [get_bd_pins axi_ethernet_2/gtx_clk90]

   # Create DMAs
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma axi_ethernet_0_dma
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma axi_ethernet_1_dma
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma axi_ethernet_2_dma

   # Configure the DMAs
   set_property -dict [list CONFIG.c_sg_length_width {16} CONFIG.c_include_mm2s_dre {1} CONFIG.c_sg_use_stsapp_length {1} CONFIG.c_include_s2mm_dre {1}] [get_bd_cells axi_ethernet_0_dma]
   set_property -dict [list CONFIG.c_sg_length_width {16} CONFIG.c_include_mm2s_dre {1} CONFIG.c_sg_use_stsapp_length {1} CONFIG.c_include_s2mm_dre {1}] [get_bd_cells axi_ethernet_1_dma]
   set_property -dict [list CONFIG.c_sg_length_width {16} CONFIG.c_include_mm2s_dre {1} CONFIG.c_sg_use_stsapp_length {1} CONFIG.c_include_s2mm_dre {1}] [get_bd_cells axi_ethernet_2_dma]

   # Connect DMAs to AXI Ethernets
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0/m_axis_rxd] [get_bd_intf_pins axi_ethernet_0_dma/S_AXIS_S2MM]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1/m_axis_rxd] [get_bd_intf_pins axi_ethernet_1_dma/S_AXIS_S2MM]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2/m_axis_rxd] [get_bd_intf_pins axi_ethernet_2_dma/S_AXIS_S2MM]

   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0/m_axis_rxs] [get_bd_intf_pins axi_ethernet_0_dma/S_AXIS_STS]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1/m_axis_rxs] [get_bd_intf_pins axi_ethernet_1_dma/S_AXIS_STS]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2/m_axis_rxs] [get_bd_intf_pins axi_ethernet_2_dma/S_AXIS_STS]

   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0/s_axis_txc] [get_bd_intf_pins axi_ethernet_0_dma/M_AXIS_CNTRL]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1/s_axis_txc] [get_bd_intf_pins axi_ethernet_1_dma/M_AXIS_CNTRL]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2/s_axis_txc] [get_bd_intf_pins axi_ethernet_2_dma/M_AXIS_CNTRL]

   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0/s_axis_txd] [get_bd_intf_pins axi_ethernet_0_dma/M_AXIS_MM2S]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1/s_axis_txd] [get_bd_intf_pins axi_ethernet_1_dma/M_AXIS_MM2S]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2/s_axis_txd] [get_bd_intf_pins axi_ethernet_2_dma/M_AXIS_MM2S]

   # Connect AXI clocks
   connect_bd_net [get_bd_pins axi_ethernet_0/s_axi_lite_clk] [get_bd_pins processing_system7_0/fclk_clk0]
   connect_bd_net [get_bd_pins axi_ethernet_1/s_axi_lite_clk] [get_bd_pins processing_system7_0/fclk_clk0]
   connect_bd_net [get_bd_pins axi_ethernet_2/s_axi_lite_clk] [get_bd_pins processing_system7_0/fclk_clk0]

   connect_bd_net [get_bd_pins axi_ethernet_0/axis_clk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_1/axis_clk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_2/axis_clk] [get_bd_pins clk_wiz_0/clk_out1]

   connect_bd_net [get_bd_pins axi_ethernet_0_dma/s_axi_lite_aclk] [get_bd_pins processing_system7_0/fclk_clk0]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/s_axi_lite_aclk] [get_bd_pins processing_system7_0/fclk_clk0]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/s_axi_lite_aclk] [get_bd_pins processing_system7_0/fclk_clk0]

   connect_bd_net [get_bd_pins axi_ethernet_0_dma/m_axi_sg_aclk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/m_axi_sg_aclk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/m_axi_sg_aclk] [get_bd_pins clk_wiz_0/clk_out1]

   connect_bd_net [get_bd_pins axi_ethernet_0_dma/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out1]

   connect_bd_net [get_bd_pins axi_ethernet_0_dma/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out1]

   # Resets
   connect_bd_net [get_bd_pins axi_ethernet_0/axi_txd_arstn] [get_bd_pins axi_ethernet_0_dma/mm2s_prmry_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_0/axi_txc_arstn] [get_bd_pins axi_ethernet_0_dma/mm2s_cntrl_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_0/axi_rxd_arstn] [get_bd_pins axi_ethernet_0_dma/s2mm_prmry_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_0/axi_rxs_arstn] [get_bd_pins axi_ethernet_0_dma/s2mm_sts_reset_out_n]

   connect_bd_net [get_bd_pins axi_ethernet_1/axi_txd_arstn] [get_bd_pins axi_ethernet_1_dma/mm2s_prmry_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_1/axi_txc_arstn] [get_bd_pins axi_ethernet_1_dma/mm2s_cntrl_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_1/axi_rxd_arstn] [get_bd_pins axi_ethernet_1_dma/s2mm_prmry_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_1/axi_rxs_arstn] [get_bd_pins axi_ethernet_1_dma/s2mm_sts_reset_out_n]

   connect_bd_net [get_bd_pins axi_ethernet_2/axi_txd_arstn] [get_bd_pins axi_ethernet_2_dma/mm2s_prmry_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_2/axi_txc_arstn] [get_bd_pins axi_ethernet_2_dma/mm2s_cntrl_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_2/axi_rxd_arstn] [get_bd_pins axi_ethernet_2_dma/s2mm_prmry_reset_out_n]
   connect_bd_net [get_bd_pins axi_ethernet_2/axi_rxs_arstn] [get_bd_pins axi_ethernet_2_dma/s2mm_sts_reset_out_n]

   connect_bd_net [get_bd_pins axi_ethernet_0/s_axi_lite_resetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_ethernet_1/s_axi_lite_resetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_ethernet_2/s_axi_lite_resetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_ethernet_0_dma/axi_resetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/axi_resetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/axi_resetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]

   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_ethernet_0/s_axi]
   set_property range 256K [get_bd_addr_segs {processing_system7_0/Data/SEG_axi_ethernet_0_Reg0}]
   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_ethernet_1/s_axi]
   set_property range 256K [get_bd_addr_segs {processing_system7_0/Data/SEG_axi_ethernet_1_Reg0}]
   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_ethernet_2/s_axi]
   set_property range 256K [get_bd_addr_segs {processing_system7_0/Data/SEG_axi_ethernet_2_Reg0}]

   # Clock connections to AXI mem interconnect
   create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_mem_intercon
   set_property -dict [list CONFIG.NUM_SI {9} CONFIG.NUM_MI {1}] [get_bd_cells axi_mem_intercon]
   connect_bd_net [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0]
   connect_bd_net [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_ps7_0_100M/interconnect_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0]
   connect_bd_net [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
   connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
   connect_bd_net [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S04_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S05_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S06_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S07_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S08_ARESETN] [get_bd_pins rst_clk_wiz_0_125M/peripheral_aresetn]
   connect_bd_net [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S04_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S05_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S06_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S07_ACLK] [get_bd_pins clk_wiz_0/clk_out1]
   connect_bd_net [get_bd_pins axi_mem_intercon/S08_ACLK] [get_bd_pins clk_wiz_0/clk_out1]

   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0_dma/M_AXI_SG] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S00_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0_dma/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S01_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0_dma/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S02_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1_dma/M_AXI_SG] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S03_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1_dma/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S04_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1_dma/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S05_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2_dma/M_AXI_SG] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S06_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2_dma/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S07_AXI]
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2_dma/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins axi_mem_intercon/S08_AXI]

   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_ethernet_0_dma/S_AXI_LITE]
   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_ethernet_1_dma/S_AXI_LITE]
   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_ethernet_2_dma/S_AXI_LITE]

   assign_bd_address

   # Connect interrupts

   connect_bd_net [get_bd_pins axi_ethernet_0_dma/mm2s_introut] [get_bd_pins xlconcat_0/In0]
   connect_bd_net [get_bd_pins axi_ethernet_0_dma/s2mm_introut] [get_bd_pins xlconcat_0/In1]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/mm2s_introut] [get_bd_pins xlconcat_0/In2]
   connect_bd_net [get_bd_pins axi_ethernet_1_dma/s2mm_introut] [get_bd_pins xlconcat_0/In3]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/mm2s_introut] [get_bd_pins xlconcat_0/In4]
   connect_bd_net [get_bd_pins axi_ethernet_2_dma/s2mm_introut] [get_bd_pins xlconcat_0/In5]

   connect_bd_net [get_bd_pins axi_ethernet_0/mac_irq] [get_bd_pins xlconcat_0/In6]
   connect_bd_net [get_bd_pins axi_ethernet_0/interrupt] [get_bd_pins xlconcat_0/In7]
   connect_bd_net [get_bd_pins axi_ethernet_1/mac_irq] [get_bd_pins xlconcat_0/In8]
   connect_bd_net [get_bd_pins axi_ethernet_1/interrupt] [get_bd_pins xlconcat_0/In9]
   connect_bd_net [get_bd_pins axi_ethernet_2/mac_irq] [get_bd_pins xlconcat_0/In10]
   connect_bd_net [get_bd_pins axi_ethernet_2/interrupt] [get_bd_pins xlconcat_0/In11]

   # Make AXI Ethernet/GMII-to-RGMII ports external: MDIO, RGMII and RESET
   # MDIO
   create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_0
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0/mdio] [get_bd_intf_ports mdio_io_port_0]
   create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_1
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1/mdio] [get_bd_intf_ports mdio_io_port_1]
   create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_2
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2/mdio] [get_bd_intf_ports mdio_io_port_2]
   # RGMII
   create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_0
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_0/rgmii] [get_bd_intf_ports rgmii_port_0]
   create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_1
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_1/rgmii] [get_bd_intf_ports rgmii_port_1]
   create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_2
   connect_bd_intf_net [get_bd_intf_pins axi_ethernet_2/rgmii] [get_bd_intf_ports rgmii_port_2]
   # RESET
   create_bd_port -dir O -type rst reset_port_0
   connect_bd_net [get_bd_pins /axi_ethernet_0/phy_rst_n] [get_bd_ports reset_port_0]
   create_bd_port -dir O -type rst reset_port_1
   connect_bd_net [get_bd_pins /axi_ethernet_1/phy_rst_n] [get_bd_ports reset_port_1]
   create_bd_port -dir O -type rst reset_port_2
   connect_bd_net [get_bd_pins /axi_ethernet_2/phy_rst_n] [get_bd_ports reset_port_2]
}

# Add the GMII-to-RGMII
create_bd_cell -type ip -vlnv xilinx.com:ip:gmii_to_rgmii gmii_to_rgmii_0
set_property -dict [list CONFIG.SupportLevel {Include_Shared_Logic_in_Core}] [get_bd_cells gmii_to_rgmii_0]
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_0/MDIO_GEM] [get_bd_intf_pins processing_system7_0/MDIO_ETHERNET_1]
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_0/GMII] [get_bd_intf_pins processing_system7_0/GMII_ETHERNET_1]

# Make AXI Ethernet/GMII-to-RGMII ports external: MDIO, RGMII and RESET
# MDIO
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_io_port_3
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_0/MDIO_PHY] [get_bd_intf_ports mdio_io_port_3]
# RGMII
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_3
connect_bd_intf_net [get_bd_intf_pins gmii_to_rgmii_0/RGMII] [get_bd_intf_ports rgmii_port_3]
# PHY RESET for GMII-to-RGMII port 3
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic util_reduced_logic_0
set_property -dict [list CONFIG.C_SIZE {1}] [get_bd_cells util_reduced_logic_0]
connect_bd_net -net [get_bd_nets rst_ps7_0_100M_peripheral_aresetn] [get_bd_pins util_reduced_logic_0/Op1] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
create_bd_port -dir O reset_port_3
connect_bd_net [get_bd_pins /util_reduced_logic_0/Res] [get_bd_ports reset_port_3]

# Connect 200MHz GMII-to-RGMII clkin

connect_bd_net [get_bd_pins gmii_to_rgmii_0/clkin] [get_bd_pins clk_wiz_0/clk_out2]

# Connect GMII-to-RGMII resets

connect_bd_net [get_bd_pins rst_ps7_0_100M/peripheral_reset] [get_bd_pins gmii_to_rgmii_0/tx_reset]
connect_bd_net -net [get_bd_nets rst_ps7_0_100M_peripheral_reset] [get_bd_pins gmii_to_rgmii_0/rx_reset] [get_bd_pins rst_ps7_0_100M/peripheral_reset]

# Create Ethernet FMC reference clock output enable and frequency select

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant ref_clk_oe
create_bd_port -dir O -from 0 -to 0 ref_clk_oe
connect_bd_net [get_bd_pins /ref_clk_oe/dout] [get_bd_ports ref_clk_oe]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant ref_clk_fsel
create_bd_port -dir O -from 0 -to 0 ref_clk_fsel
connect_bd_net [get_bd_pins /ref_clk_fsel/dout] [get_bd_ports ref_clk_fsel]

# Restore current instance
current_bd_instance $oldCurInst

save_bd_design

