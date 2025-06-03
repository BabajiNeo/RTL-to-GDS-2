###############################################################################
#                          MASTER SDC CONSTRAINTS FILE                        #
# Description: Comprehensive timing, power, and design rule constraints       #
# Usage: Source this file in your synthesis/PnR tool (e.g., Design Compiler)  #
###############################################################################

# --------------------------- Operating Conditions --------------------------- #
set_operating_conditions -library "your_library_name" -analysis_type on_chip_variation

# Wire-load Models
set_wire_load_mode top
set_wire_load_model -name "10x10" -library "your_library_name"
set_wire_load_selection_group "WireAreaLow"

# Environmental Constraints
set_drive 1.0 [all_inputs]          # Drive strength for input ports
set_driving_cell -lib_cell "INVX1" [all_inputs]  # Cell driving inputs
set_load 0.15 [all_outputs]         # Capacitive load on outputs (pF)
set_fanout_load 8 [all_inputs]      # Fanout load on inputs
set_input_transition 0.8 [all_inputs] # Slew rate for inputs (ns)

# Design Rules
set_max_capacitance 0.5 [current_design]  # Max pin capacitance (pF)
set_max_fanout 20.0 [current_design]      # Max fanout per gate
set_max_transition 1.0 [current_design]   # Max slew rate (ns)

# -------------------------------- Clock Tree -------------------------------- #
# Primary Clock
create_clock -name i_clock -period 40 -waveform {0 20} [get_ports "i_clock"]
set_clock_transition -rise 0.4 -fall 0.4 [get_clocks "i_clock"]
set_clock_uncertainty -setup 0.05 -hold 0.03 [get_clocks "i_clock"]
set_clock_latency -source 2.0 [get_clocks "i_clock"]

# Generated Clock (example)
create_generated_clock -name clk_div2 -source [get_ports "i_clock"] \
  -divide_by 2 [get_pins "divider/CLK_OUT"]

# ------------------------------ Timing Exceptions --------------------------- #
# False Paths
set_false_path -from [get_clocks "clkA"] -to [get_clocks "clkB"]

# Multicycle Paths
set_multicycle_path 2 -setup -from [get_pins "regA/Q"] -to [get_pins "regB/D"]
set_multicycle_path 1 -hold -from [get_pins "regA/Q"] -to [get_pins "regB/D"]

# Max Delay (for asynchronous paths)
set_max_delay 5.0 -from [get_ports "async_in"] -to [get_ports "async_out"]

# ------------------------------ I/O Constraints ---------------------------- #
# Input Delays
set_input_delay -max 4 -clock i_clock [remove_from_collection [all_inputs] [get_ports "i_clock"]]
set_input_delay -min 1 -clock i_clock [all_inputs]

# Output Delays
set_output_delay -max 4 -clock i_clock [all_outputs]
set_output_delay -min 2 -clock i_clock [all_outputs]

# ------------------------------- Power Constraints ------------------------- #
set_max_dynamic_power 100.0 [current_design]  # mW
set_max_leakage_power 10.0 [current_design]   # mW

# ------------------------------- Miscellaneous ----------------------------- #
# Disable Timing (e.g., for test logic)
set_disable_timing [get_cells "test_mode_buffer*"]

# Propagated Clock (for post-CTS)
set_propagated_clock [all_clocks]

###############################################################################
#                             END OF SDC FILE                                 #
###############################################################################