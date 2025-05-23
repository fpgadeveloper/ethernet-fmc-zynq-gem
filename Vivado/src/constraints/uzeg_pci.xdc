# These constraints are suitable for UltraZed-EG PCIe Carrier
# ---------------------------------------------------------------------------------

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

set_property PACKAGE_PIN M6 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN L5 [get_ports mdio_io_port_0_mdio_io]
set_property PACKAGE_PIN K7 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN P3 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN P2 [get_ports mdio_io_port_1_mdio_io]
set_property PACKAGE_PIN AB3 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN AC3 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN Y2 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN AA2 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN N4 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN N3 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN N5 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN M5 [get_ports reset_port_0]
set_property PACKAGE_PIN J7 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN J6 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN N1 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN P1 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN AB5 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN AD1 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN AE1 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN W3 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN W2 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN M3 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN L3 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN R2 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN R1 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN K4 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN J4 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN V3 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN R7 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN T7 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN AD4 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN AD3 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN AB6 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN AC6 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN W1 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN Y1 [get_ports mdio_io_port_2_mdio_io]
set_property PACKAGE_PIN Y4 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN AE7 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN AE6 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN P4 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN R4 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN L2 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN K2 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN K6 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN K5 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN U1 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN V1 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN T3 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN U2 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN W8 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN W7 [get_ports reset_port_1]
set_property PACKAGE_PIN AE4 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN AE3 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN AB2 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN AB1 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN AD8 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN AD7 [get_ports reset_port_2]
set_property PACKAGE_PIN AA4 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN AA3 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN AD6 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN AD5 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN AB8 [get_ports mdio_io_port_3_mdio_io]
set_property PACKAGE_PIN AB7 [get_ports reset_port_3]

# The following constraints force placement of the BUFGs needed by the RGMII RX clock for Ethernet FMC ports 2 and 3
# Without these constraints, timing will not close because the BUFGCE selected by Vivado is too far.
# It is actually not recommended to use LOC constraints on BUFGCEs but instead to constrain placement to a clock 
# region, but in Vivado 2017.2, even this does not result a good placement of BUFGCE and timing closure.

set gmii_to_rgmii_2_bufg [get_cells -hierarchical -filter { PRIMITIVE_TYPE == CLOCK.BUFFER.BUFGCE && NAME =~  "*gmii_to_rgmii_2/*gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk*" } ]
set gmii_to_rgmii_2_bufio [get_cells -hierarchical -filter { PRIMITIVE_TYPE == CLOCK.BUFFER.BUFGCE && NAME =~  "*gmii_to_rgmii_2/*gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk*" } ]
set_property BEL BUFCE $gmii_to_rgmii_2_bufg
set_property LOC BUFGCE_X0Y15 $gmii_to_rgmii_2_bufg
set_property BEL BUFCE $gmii_to_rgmii_2_bufio
set_property LOC BUFGCE_X0Y14 $gmii_to_rgmii_2_bufio

set gmii_to_rgmii_3_bufg [get_cells -hierarchical -filter { PRIMITIVE_TYPE == CLOCK.BUFFER.BUFGCE && NAME =~  "*gmii_to_rgmii_3/*gen_rgmii_rx_clk_zq.bufg_rgmii_rx_clk*" } ]
set gmii_to_rgmii_3_bufio [get_cells -hierarchical -filter { PRIMITIVE_TYPE == CLOCK.BUFFER.BUFGCE && NAME =~  "*gmii_to_rgmii_3/*gen_rgmii_rx_clk_zq.bufio_rgmii_rx_clk*" } ]
set_property BEL BUFCE $gmii_to_rgmii_3_bufg
set_property LOC BUFGCE_X0Y19 $gmii_to_rgmii_3_bufg
set_property BEL BUFCE $gmii_to_rgmii_3_bufio
set_property LOC BUFGCE_X0Y18 $gmii_to_rgmii_3_bufio

# IDELAY CTRL groups
set_property IODELAY_GROUP iodelay_grp1 [get_cells *_i/util_idelay_ctrl_0/inst/dlyctrl]
set_property IODELAY_GROUP iodelay_grp2 [get_cells -hierarchical -filter { PRIMITIVE_TYPE == I/O.DELAY.IDELAYE3 && NAME =~ "*gmii_to_rgmii_0*" } ]
set_property IODELAY_GROUP iodelay_grp2 [get_cells -hierarchical -filter { PRIMITIVE_TYPE == I/O.DELAY.IDELAYE3 && NAME =~ "*gmii_to_rgmii_1*" } ]

set_property IODELAY_GROUP iodelay_grp2 [get_cells *_i/gmii_to_rgmii_2/U0/i_zynqgem_gmii_to_rgmii_2_0_idelayctrl]
set_property IODELAY_GROUP iodelay_grp2 [get_cells -hierarchical -filter { PRIMITIVE_TYPE == I/O.DELAY.IDELAYE3 && NAME =~ "*gmii_to_rgmii_2*" } ]
set_property IODELAY_GROUP iodelay_grp2 [get_cells -hierarchical -filter { PRIMITIVE_TYPE == I/O.DELAY.IDELAYE3 && NAME =~ "*gmii_to_rgmii_3*" } ]

# Since Vivado 2019.2, when we connect a GEM MDIO interface to EMIO, this sets parameter PSU__ENET0__GRP_MDIO_INTERNAL to 1
# (see file "<vivado-path>\2019.2\data\PS\8series\data\zynqconfig\enet\enet0_preset.xml")
# which in turn enables a new create_clock constraint for the MDIO clock output
# (see file "<vivad-path>\2019.2\data\PS\8series\data\zynqconfig\code\ucfgen.xml").
# The name of the clock is mdioX_mdc_clock and the frequency is specified by parameter PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ.
# The constraint is added to this automatically generated file:
# "<prj_name>\<prj_name>.srcs\sources_1\bd\<prj_name>\ip\<prj_name>_zynq_ultra_ps_e_0_0\<prj_name>_zynq_ultra_ps_e_0_0.xdc"
# The new clock causes Vivado to analyze some non-critical paths that it was not analyzing before, and it has difficulty achieving timing closure.
# To prevent this problem, we declare false path from Clock wizard's 375MHz clock to the Zynq PS GEM's MDIO clock output
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio0_mdc_clock]
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio1_mdc_clock]
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio2_mdc_clock]
set_false_path -from [get_clocks clk_out1_zynqgem_clk_wiz_0_0] -to [get_clocks mdio3_mdc_clock]

# Create the clocks for the RGMII RX CLK inputs
create_clock -period 8.000 -name rgmii_port_0_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_0_rxc]
create_clock -period 8.000 -name rgmii_port_1_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_1_rxc]
create_clock -period 8.000 -name rgmii_port_2_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_2_rxc]
create_clock -period 8.000 -name rgmii_port_3_rx_clk -waveform {0.000 4.000} [get_ports rgmii_port_3_rxc]
