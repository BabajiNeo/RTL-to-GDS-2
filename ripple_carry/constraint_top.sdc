# Define clock
create_clock -name clk -period 40 -waveform {0 20} [get_ports clk]

# Clock transition — apply same value for both rise and fall
set_clock_transition 0.4 [get_clocks clk]

# Clock uncertainty — set setup and hold separately
set_clock_uncertainty 0.05 [get_clocks clk]  ;# setup
set_clock_uncertainty -hold 0.03 [get_clocks clk] ;# hold

# Clock source latency
set_clock_latency -source 2.0 [get_clocks clk]

# Input/output delays relative to clk
set_input_delay -max 0.8 -clock [get_clocks clk] [get_ports {X Y}]
set_output_delay -max 0.8 -clock [get_clocks clk] [get_ports {S Co}]

