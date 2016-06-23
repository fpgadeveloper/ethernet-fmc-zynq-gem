
# This constraints file is set for LATE processing order so that it can override the set_input_delay and set_output_delay
# contraints in the GMII-to-RGMII IP's in-built XDC files. These constraints come from the GMII to RGMII product guide 
# http://www.xilinx.com/support/documentation/ip_documentation/gmii_to_rgmii/v4_0/pg160-gmii-to-rgmii.pdf

# These set_input_delay constraints have been commented out because the design never passes timing when they are enabled.
# Instead, we get timing closure when we rely on the set_input_delay constraints built into the GMII-to-RGMII IP (..._clocks.xdc).
# The built in constraints seem to have illogical values for min and max which is why I was certain that they should be
# overriden by the following. We need to test the design on hardware to find out if the built-in constraints are actually good. 

# Use these constraints to modify input delay on RGMII signals
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_0_0_rgmii_rx_clk] -max -1.5 [get_ports {rgmii_port_0_rd[*] rgmii_port_0_rx_ctl}]
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_0_0_rgmii_rx_clk] -min -2.6 [get_ports {rgmii_port_0_rd[*] rgmii_port_0_rx_ctl}]
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_0_0_rgmii_rx_clk] -clock_fall -max -1.5 -add_delay [get_ports {rgmii_port_0_rd[*] rgmii_port_0_rx_ctl}]
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_0_0_rgmii_rx_clk] -clock_fall -min -2.6 -add_delay [get_ports {rgmii_port_0_rd[*] rgmii_port_0_rx_ctl}]

#set_input_delay -clock [get_clocks *_gmii_to_rgmii_2_0_rgmii_rx_clk] -max -1.5 [get_ports {rgmii_port_2_rd[*] rgmii_port_2_rx_ctl}]
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_2_0_rgmii_rx_clk] -min -2.6 [get_ports {rgmii_port_2_rd[*] rgmii_port_2_rx_ctl}]
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_2_0_rgmii_rx_clk] -clock_fall -max -1.5 -add_delay [get_ports {rgmii_port_2_rd[*] rgmii_port_2_rx_ctl}]
#set_input_delay -clock [get_clocks *_gmii_to_rgmii_2_0_rgmii_rx_clk] -clock_fall -min -2.6 -add_delay [get_ports {rgmii_port_2_rd[*] rgmii_port_2_rx_ctl}]

# The following set_output_delay constraints have been commented out because the same constraints can be found in the ..._clocks.xdc file
# that is built into the GMII-to-RGMII core.

# Use these constraints to modify output delay on RGMII signals if 2ns delay is added by external PHY
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -max -1.0 [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}]
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -min -2.5 [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}] -add_delay
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -clock_fall -max -1.0 [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}] 
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -clock_fall -min -2.5 [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}]

#set_output_delay -clock [get_clocks rgmii_port_2_txc] -max -1.0 [get_ports {rgmii_port_2_td[*] rgmii_port_2_tx_ctl}]
#set_output_delay -clock [get_clocks rgmii_port_2_txc] -min -2.5 [get_ports {rgmii_port_2_td[*] rgmii_port_2_tx_ctl}] -add_delay
#set_output_delay -clock [get_clocks rgmii_port_2_txc] -clock_fall -max -1.0 [get_ports {rgmii_port_2_td[*] rgmii_port_2_tx_ctl}] 
#set_output_delay -clock [get_clocks rgmii_port_2_txc] -clock_fall -min -2.5 [get_ports {rgmii_port_2_td[*] rgmii_port_2_tx_ctl}]

