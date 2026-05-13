
#
# constraint file template: https://fpgawizard.com/fpga-timing-constraints-guide-xdc-sdc/
#

create_clock -period 10.0 -name sys_clk [get_ports clock]

create_clock -period 10.0 -name virt_adc_clk

set_input_jitter [get_clocks sys_clk] 0.1

set_input_delay -clock [get_clocks sys_clk] -max 4.0 [get_ports io_value1]
set_input_delay -clock [get_clocks sys_clk] -min 1.3 [get_ports io_value1]
set_input_delay -clock [get_clocks sys_clk] -max 4.0 [get_ports io_value2]
set_input_delay -clock [get_clocks sys_clk] -min 1.3 [get_ports io_value2]
set_input_delay -clock [get_clocks sys_clk] -max 4.0 [get_ports io_loadingValues]
set_input_delay -clock [get_clocks sys_clk] -min 1.3 [get_ports io_loadingValues]

set_output_delay -clock [get_clocks sys_clk] -max  1.5 [get ports io_outputGCD]
set_output_delay -clock [get_clocks sys_clk] -min -0.5 [get ports io_outputGCD]
set_output_delay -clock [get_clocks sys_clk] -max  1.5 [get ports io_outputValid]
set_output_delay -clock [get_clocks sys_clk] -min -0.5 [get ports io_outputValid]

set_false_path -from [get_ports reset]

