## Number A : slide switches
set_property -dict { PACKAGE_PIN M20 IOSTANDARD LVCMOS33 } [get_ports {a[0]}]
set_property -dict { PACKAGE_PIN M19 IOSTANDARD LVCMOS33 } [get_ports {a[1]}]

## Number B : push buttons
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports {b[0]}]
set_property -dict { PACKAGE_PIN D20 IOSTANDARD LVCMOS33 } [get_ports {b[1]}]

## Carry in : push button BTN2
set_property -dict { PACKAGE_PIN L20 IOSTANDARD LVCMOS33 } [get_ports cin]

## Result : green LEDs
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports {sum[0]}]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {sum[1]}]
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports cout]

## Play : LD3 lights when A equals B
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports equal]
## Speed target : every input-to-output path must be faster than 12 ns
set_max_delay 12.000 -from [all_inputs] -to [all_outputs]