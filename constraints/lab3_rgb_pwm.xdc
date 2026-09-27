# Combo II-DLD S75 / MAIN CLOCK F = 50 MHz.

set_property PACKAGE_PIN B6 [get_ports clk_50mhz]

set_property PACKAGE_PIN K4 [get_ports rst_p]

set_property PACKAGE_PIN N8 [get_ports button_r]
set_property PACKAGE_PIN N4 [get_ports button_g]
set_property PACKAGE_PIN N1 [get_ports button_b]

set_property PACKAGE_PIN T2 [get_ports {led_r[3]}]
set_property PACKAGE_PIN U1 [get_ports {led_r[2]}]
set_property PACKAGE_PIN P2 [get_ports {led_r[1]}]
set_property PACKAGE_PIN R3 [get_ports {led_r[0]}]

set_property PACKAGE_PIN U5 [get_ports {led_g[3]}]
set_property PACKAGE_PIN V1 [get_ports {led_g[2]}]
set_property PACKAGE_PIN R7 [get_ports {led_g[1]}]
set_property PACKAGE_PIN T6 [get_ports {led_g[0]}]

set_property PACKAGE_PIN U3 [get_ports {led_b[3]}]
set_property PACKAGE_PIN W2 [get_ports {led_b[2]}]
set_property PACKAGE_PIN R5 [get_ports {led_b[1]}]
set_property PACKAGE_PIN T3 [get_ports {led_b[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports *]

create_clock -name clk_50mhz -period 20.000 [get_ports clk_50mhz]

set_false_path -from [get_ports {rst_p button_r button_g button_b}]
