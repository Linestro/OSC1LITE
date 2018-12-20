############################################################################
# XEM7001 - Xilinx constraints file
#
# Pin mappings for the XEM7001.  Use this as a template and comment out 
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2015 Opal Kelly Incorporated
############################################################################
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

set_property PACKAGE_PIN K12 [get_ports {hi_muxsel}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_muxsel}]

############################################################################
## FrontPanel Host Interface
############################################################################
set_property PACKAGE_PIN N11 [get_ports {hi_in[0]}]
set_property PACKAGE_PIN R13 [get_ports {hi_in[1]}]
set_property PACKAGE_PIN R12 [get_ports {hi_in[2]}]
set_property PACKAGE_PIN P13 [get_ports {hi_in[3]}]
set_property PACKAGE_PIN T13 [get_ports {hi_in[4]}]
set_property PACKAGE_PIN T12 [get_ports {hi_in[5]}]
set_property PACKAGE_PIN P11 [get_ports {hi_in[6]}]
set_property PACKAGE_PIN R10 [get_ports {hi_in[7]}]

set_property SLEW FAST [get_ports {hi_in[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_in[*]}]

set_property PACKAGE_PIN R15 [get_ports {hi_out[0]}]
set_property PACKAGE_PIN N13 [get_ports {hi_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_out[*]}]

set_property PACKAGE_PIN T15 [get_ports {hi_inout[0]}]
set_property PACKAGE_PIN T14 [get_ports {hi_inout[1]}]
set_property PACKAGE_PIN R16 [get_ports {hi_inout[2]}]
set_property PACKAGE_PIN P16 [get_ports {hi_inout[3]}]
set_property PACKAGE_PIN P15 [get_ports {hi_inout[4]}]
set_property PACKAGE_PIN N16 [get_ports {hi_inout[5]}]
set_property PACKAGE_PIN M16 [get_ports {hi_inout[6]}]
set_property PACKAGE_PIN M12 [get_ports {hi_inout[7]}]
set_property PACKAGE_PIN L13 [get_ports {hi_inout[8]}]
set_property PACKAGE_PIN K13 [get_ports {hi_inout[9]}]
set_property PACKAGE_PIN M14 [get_ports {hi_inout[10]}]
set_property PACKAGE_PIN L14 [get_ports {hi_inout[11]}]
set_property PACKAGE_PIN K16 [get_ports {hi_inout[12]}]
set_property PACKAGE_PIN K15 [get_ports {hi_inout[13]}]
set_property PACKAGE_PIN J14 [get_ports {hi_inout[14]}]
set_property PACKAGE_PIN J13 [get_ports {hi_inout[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_inout[*]}]

set_property PACKAGE_PIN M15 [get_ports {hi_aa}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_aa}]


create_clock -name okHostClk -period 20.83 [get_ports {hi_in[0]}]

set_input_delay -add_delay -max -clock [get_clocks {okHostClk}]  11.000 [get_ports {hi_inout[*]}]
set_input_delay -add_delay -min -clock [get_clocks {okHostClk}]  0.000  [get_ports {hi_inout[*]}]
set_multicycle_path -setup -from [get_ports {hi_inout[*]}] 2

set_input_delay -add_delay -max -clock [get_clocks {okHostClk}]  6.700 [get_ports {hi_in[*]}]
set_input_delay -add_delay -min -clock [get_clocks {okHostClk}]  0.000 [get_ports {hi_in[*]}]
set_multicycle_path -setup -from [get_ports {hi_in[*]}] 2

set_output_delay -add_delay -clock [get_clocks {okHostClk}]  8.900 [get_ports {hi_out[*]}]

set_output_delay -add_delay -clock [get_clocks {okHostClk}]  9.200 [get_ports {hi_inout[*]}]


set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
set_property PACKAGE_PIN N14 [get_ports {clk}]

#set_property IOSTANDARD LVCMOS33 [get_ports {clk2}]
#set_property PACKAGE_PIN F4 [get_ports {clk2}]

#set_property IOSTANDARD LVCMOS33 [get_ports {clk3}]
#set_property PACKAGE_PIN F5 [get_ports {clk3}]



# JP1-1 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# JP1-2 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# JP1-3 
#set_property PACKAGE_PIN H1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

# JP1-4 
#set_property PACKAGE_PIN H2 [get_ports {in_scan_in}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_scan_in}]

# JP1-5 
#set_property PACKAGE_PIN G1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

# JP1-6 
#set_property PACKAGE_PIN G2 [get_ports {in_rst}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_rst}]

# JP1-7 
#set_property PACKAGE_PIN F2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

# JP1-8 
#set_property PACKAGE_PIN E1 [get_ports {in_latch}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_latch}]

# JP1-9 
#set_property PACKAGE_PIN E2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

# JP1-10 
#set_property PACKAGE_PIN D1 [get_ports {in_clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_clk}]

# JP1-11 
#set_property PACKAGE_PIN C1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-12 
#set_property PACKAGE_PIN C2 [get_ports {dis}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dis}]

## JP1-13 
#set_property PACKAGE_PIN B1 [get_ports {in_latch1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_latch1}]

## JP1-14 
#set_property PACKAGE_PIN B2 [get_ports {in_clk1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_clk1}]

## JP1-15 
#set_property PACKAGE_PIN A2 [get_ports {in_rst1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_rst1}]

## JP1-16 
#set_property PACKAGE_PIN A3 [get_ports {in_scan_in1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {in_scan_in1}]

## JP1-17 
##set_property PACKAGE_PIN D4 [get_ports {}]
##set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-18 
##set_property PACKAGE_PIN C4 [get_ports {}]
##set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-19 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP1-20 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-1 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-2 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-3 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-4 
##set_property PACKAGE_PIN P10 [get_ports {}]
##set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-5 
#set_property PACKAGE_PIN J1 [get_ports {extrigin[24]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[24]}]

## JP2-6 
#set_property PACKAGE_PIN J3 [get_ports {extrigin[25]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[25]}]

## JP2-7 
#set_property PACKAGE_PIN K2 [get_ports {extrigin[26]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[26]}]

## JP2-8 
#set_property PACKAGE_PIN K1 [get_ports {extrigin[27]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[27]}]

## JP2-9 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-10 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-11 
#set_property PACKAGE_PIN L2 [get_ports {extrigin[28]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[28]}]

## JP2-12 
#set_property PACKAGE_PIN K3 [get_ports {extrigin[29]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[29]}]

## JP2-13 
#set_property PACKAGE_PIN L3 [get_ports {extrigin[30]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[30]}]

## JP2-14 
#set_property PACKAGE_PIN M1 [get_ports {extrigin[31]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[31]}]

## JP2-15 
#set_property PACKAGE_PIN M2 [get_ports {extrigin[32]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[32]}]

## JP2-16 
#set_property PACKAGE_PIN L4 [get_ports {extrigin[33]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[33]}]

## JP2-17 
#set_property PACKAGE_PIN M4 [get_ports {extrigin[34]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[34]}]

## JP2-18 
#set_property PACKAGE_PIN N1 [get_ports {extrigin[35]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[35]}]

## JP2-19 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-20 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-21 
#set_property PACKAGE_PIN N2 [get_ports {extrigin[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[12]}]

## JP2-22 
#set_property PACKAGE_PIN N3 [get_ports {extrigin[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[13]}]

## JP2-23 
#set_property PACKAGE_PIN P1 [get_ports {extrigin[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[14]}]

## JP2-24 
#set_property PACKAGE_PIN R1 [get_ports {extrigin[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[15]}]

## JP2-25 
#set_property PACKAGE_PIN R2 [get_ports {extrigin[16]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[16]}]

## JP2-26 
#set_property PACKAGE_PIN P3 [get_ports {extrigin[17]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[17]}]

## JP2-27 
#set_property PACKAGE_PIN T2 [get_ports {extrigin[18]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[18]}]

## JP2-28 
#set_property PACKAGE_PIN R3 [get_ports {extrigin[19]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[19]}]

## JP2-29 
#set_property PACKAGE_PIN T3 [get_ports {extrigin[20]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[20]}]

## JP2-30 
#set_property PACKAGE_PIN N4 [get_ports {extrigin[21]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[21]}]

## JP2-31 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-32 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-33 
#set_property PACKAGE_PIN P4 [get_ports {extrigin[22]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[22]}]

## JP2-34 
#set_property PACKAGE_PIN T4 [get_ports {extrigin[23]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[23]}]

## JP2-35 
#set_property PACKAGE_PIN P5 [get_ports {extrigin[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[0]}]

## JP2-36 
#set_property PACKAGE_PIN N6 [get_ports {extrigin[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[1]}]

## JP2-37 
#set_property PACKAGE_PIN R5 [get_ports {extrigin[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[2]}]

## JP2-38 
#set_property PACKAGE_PIN P8 [get_ports {extrigin[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[3]}]

## JP2-39 
#set_property PACKAGE_PIN T5 [get_ports {extrigin[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[4]}]

## JP2-40 
#set_property PACKAGE_PIN R6 [get_ports {extrigin[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[5]}]

## JP2-41 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-42 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-43 
#set_property PACKAGE_PIN T9 [get_ports {extrigin[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[6]}]

## JP2-44 
#set_property PACKAGE_PIN R7 [get_ports {extrigin[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[7]}]

## JP2-45 
#set_property PACKAGE_PIN T7 [get_ports {extrigin[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[8]}]

## JP2-46 
#set_property PACKAGE_PIN R8 [get_ports {extrigin[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[9]}]

## JP2-47 
#set_property PACKAGE_PIN T8 [get_ports {extrigin[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[10]}]

## JP2-48 
#set_property PACKAGE_PIN T10 [get_ports {extrigin[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {extrigin[11]}]

## JP2-49 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP2-50 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-1 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-2 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-3 
#set_property PACKAGE_PIN A8 [get_ports {trigout[24]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[24]}]

## JP3-4 
set_property PACKAGE_PIN D9 [get_ports {clear}]
set_property IOSTANDARD LVCMOS33 [get_ports {clear}]

## JP3-5 
#set_property PACKAGE_PIN C8 [get_ports {trigout[26]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[26]}]

## JP3-6 
set_property PACKAGE_PIN D10 [get_ports {latch}]
set_property IOSTANDARD LVCMOS33 [get_ports {latch}]

## JP3-7 
#set_property PACKAGE_PIN A9 [get_ports {trigout[28]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[28]}]

## JP3-8 
set_property PACKAGE_PIN C9 [get_ports {sclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sclk}]

## JP3-9 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-10 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-11 
#set_property PACKAGE_PIN B9 [get_ports {trigout[30]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[30]}]

## JP3-12 
set_property PACKAGE_PIN A10 [get_ports {din}]
set_property IOSTANDARD LVCMOS33 [get_ports {din}]

## JP3-13 
#set_property PACKAGE_PIN B10 [get_ports {trigout[32]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[32]}]

## JP3-14 
#set_property PACKAGE_PIN C11 [get_ports {sdo}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdo}]

## JP3-15 
#set_property PACKAGE_PIN B12 [get_ports {trigout[34]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[34]}]

## JP3-16 
#set_property PACKAGE_PIN A12 [get_ports {trigout[35]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[35]}]

## JP3-17 
#set_property PACKAGE_PIN C12 [get_ports {trigout[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[12]}]

## JP3-18 
#set_property PACKAGE_PIN F13 [get_ports {trigout[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[13]}]

## JP3-19 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-20 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-21 
#set_property PACKAGE_PIN A13 [get_ports {trigout[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[14]}]

## JP3-22 
#set_property PACKAGE_PIN A14 [get_ports {trigout[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[15]}]

## JP3-23 
#set_property PACKAGE_PIN E13 [get_ports {trigout[16]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[16]}]

## JP3-24 
#set_property PACKAGE_PIN B14 [get_ports {trigout[17]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[17]}]

## JP3-25 
#set_property PACKAGE_PIN C14 [get_ports {trigout[18]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[18]}]

## JP3-26 
#set_property PACKAGE_PIN A15 [get_ports {trigout[19]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[19]}]

## JP3-27 
#set_property PACKAGE_PIN B15 [get_ports {trigout[20]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[20]}]

## JP3-28 
#set_property PACKAGE_PIN B16 [get_ports {trigout[21]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[21]}]

## JP3-29 
#set_property PACKAGE_PIN C16 [get_ports {trigout[22]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[22]}]

## JP3-30 
#set_property PACKAGE_PIN D15 [get_ports {trigout[23]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[23]}]

## JP3-31 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-32 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-33 
#set_property PACKAGE_PIN D16 [get_ports {trigout[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[0]}]

## JP3-34 
#set_property PACKAGE_PIN D14 [get_ports {trigout[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[1]}]

## JP3-35 
#set_property PACKAGE_PIN E16 [get_ports {trigout[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[2]}]

## JP3-36 
#set_property PACKAGE_PIN E15 [get_ports {trigout[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[3]}]

## JP3-37 
#set_property PACKAGE_PIN G15 [get_ports {trigout[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[4]}]

## JP3-38 
#set_property PACKAGE_PIN F14 [get_ports {trigout[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[5]}]

## JP3-39 
#set_property PACKAGE_PIN H14 [get_ports {trigout[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[6]}]

## JP3-40 
#set_property PACKAGE_PIN G16 [get_ports {trigout[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[7]}]

## JP3-41 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-42 
##set_property PACKAGE_PIN  [get_ports {}]
##set_property IOSTANDARD  [get_ports {}]

## JP3-43 
#set_property PACKAGE_PIN H13 [get_ports {trigout[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[8]}]

## JP3-44 
#set_property PACKAGE_PIN H16 [get_ports {trigout[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[9]}]

## JP3-45 
#set_property PACKAGE_PIN F15 [get_ports {trigout[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[10]}]

## JP3-46 
#set_property PACKAGE_PIN G14 [get_ports {trigout[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {trigout[11]}]

# JP3-47 
#set_property PACKAGE_PIN E12 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

# JP3-48 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

# JP3-49 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# JP3-50 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# LEDs #####################################################################
set_property PACKAGE_PIN H5 [get_ports {led[0]}]
set_property PACKAGE_PIN F3 [get_ports {led[1]}]
set_property PACKAGE_PIN E3 [get_ports {led[2]}]
set_property PACKAGE_PIN H4 [get_ports {led[3]}]
set_property PACKAGE_PIN D3 [get_ports {led[4]}]
set_property PACKAGE_PIN C3 [get_ports {led[5]}]
set_property PACKAGE_PIN H3 [get_ports {led[6]}]
set_property PACKAGE_PIN A4 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]

# Buttons ##################################################################
#set_property PACKAGE_PIN A5 [get_ports {button[0]}]
#set_property PACKAGE_PIN B4 [get_ports {button[1]}]
#set_property PACKAGE_PIN B7 [get_ports {button[2]}]
#set_property PACKAGE_PIN A7 [get_ports {button[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {button[*]}]

# Flash ####################################################################
#set_property PACKAGE_PIN L12 [get_ports {spi_cs}]
#set_property PACKAGE_PIN M6 [get_ports {spi_clk}]
#set_property PACKAGE_PIN N9 [get_ports {spi_din}]
#set_property PACKAGE_PIN P9 [get_ports {spi_dout}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_cs}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_din}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_dout}]

