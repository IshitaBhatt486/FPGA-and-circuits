## 125 MHz clock : 8 ns period
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -name sys_clk -period 8.000 [get_ports clk]

## Input bit x
set_property -dict { PACKAGE_PIN M20 IOSTANDARD LVCMOS33 } [get_ports sw0]

## Push buttons : BTN0 = step, BTN1 = reset
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports {btn[0]}]
set_property -dict { PACKAGE_PIN D20 IOSTANDARD LVCMOS33 } [get_ports {btn[1]}]

## Green LEDs
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports {led[3]}]

## RGB LED LD4 : Moore state colour
set_property -dict { PACKAGE_PIN N15 IOSTANDARD LVCMOS33 } [get_ports led4_r]
set_property -dict { PACKAGE_PIN G17 IOSTANDARD LVCMOS33 } [get_ports led4_g]
set_property -dict { PACKAGE_PIN L15 IOSTANDARD LVCMOS33 } [get_ports led4_b]

## RGB LED LD5 blue : shows x
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports led5_b]