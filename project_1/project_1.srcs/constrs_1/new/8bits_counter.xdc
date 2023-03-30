
create_clock -period 5.000 -name CK -waveform {0.000 2.500} [get_ports CK]
# Cheat sheet :
# Switches:
# R2, T1, U1, W2, R3, T2, T3, V2, W13, W14, V15, W15, W17, W16, V16, V17
# Buttons:
# T18, W19, U18, T17, U17
# LEDs:
# L1, P1, N3, P3, U3, W3, V3, V13, V14, U14, U15, W18, V19, U19, E19, U16
#Horloge sur un bouton
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CK]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports CK]
#Horloge avec un oscillateur
#set_property -dist { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports {NOM_HORLOGE } ]
#create_clock -add -name sysclk_pin -period 10.00 -waveform { 0 5 } [get_ports {NOM_HORLOGE } ]
# Signal binaire
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports RST]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports EN]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports LOAD]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports SENS]
# Signal vectoriel
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {Din[0]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {Din[1]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {Din[2]}]
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {Din[3]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {Din[4]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {Din[5]}]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {Din[6]}]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {Din[7]}]

set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {Dout[0]}]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {Dout[1]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {Dout[2]}]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {Dout[3]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {Dout[4]}]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {Dout[5]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {Dout[6]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {Dout[7]}]