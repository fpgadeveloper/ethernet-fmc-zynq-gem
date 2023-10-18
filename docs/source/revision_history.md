# Revision History

## 2022.1 Changes

* Added Makefiles to improve the build experience for Linux users
* Converted documentation to markdown (from reStructuredText)
* Removed the unnecessary postfix _qgige from all designs
* Removed design for MicroZed FMC carrier (Avnet has discontinued the product).
* Removed design for TEBF0808 due to errors when applying the board preset:
```
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
INFO: [PSU-1]  DP_AUDIO clock source: RPLL is also being used by other peripheral clocks. Their outputs may get impacted if any driver changes DP_AUDIO PLL source to support runtime audio change 
INFO: [PSU-0] Address Range of DDR (0x7ff00000 to 0x7fffffff) is reserved by PMU for internal purpose.
ERROR: [IP_Flow 19-3478] Validation failed for parameter 'SD0 IO(PSU__SD0__PERIPHERAL__IO)' with value 'EMIO' for BD Cell 'zynq_ultra_ps_e_0'. PARAM PSU__SD0__PERIPHERAL__IO :: MIO 13 .. 22 is out of range { EMIO,MIO 13 .. 16 21 22,MIO 38 .. 44,MIO 64 .. 70 }
ERROR: [IP_Flow 19-3478] Validation failed for parameter 'POW IO(PSU__SD0__GRP_POW__IO)' with value 'EMIO' for BD Cell 'zynq_ultra_ps_e_0'. PARAM PSU__SD0__GRP_POW__IO :: MIO 23 is out of range { EMIO }
INFO: [IP_Flow 19-3438] Customization errors found on 'zynq_ultra_ps_e_0'. Restoring to previous valid configuration.
ERROR: [Common 17-39] 'set_property' failed due to earlier errors.
ERROR: [BD 41-1273] Error running apply_rule TCL procedure: ERROR: [Common 17-39] 'set_property' failed due to earlier errors.
    ::xilinx.com_bd_rule_zynq_ultra_ps_e::apply_rule Line 29
INFO: [BD 5-145] Automation rule xilinx.com:bd_rule:zynq_ultra_ps_e was not applied to object zynq_ultra_ps_e_0
apply_bd_automation: Time (s): cpu = 00:00:08 ; elapsed = 00:00:06 . Memory (MB): peak = 9306.859 ; gain = 4.980 ; free physical = 506141 ; free virtual = 510967
INFO: [Common 17-17] undo 'apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]'
ERROR: [Common 17-39] 'apply_bd_automation' failed due to earlier errors.
```
* Removed design for ZCU106 HPC1 connector because it only supports two ports and those two ports have sub-optimal placement 
  for a global clock-capable IO pin and BUFG pair, which leads to poor timing performance.

