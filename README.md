# RTL-to-GDS-2

# Command Window:- (Cadence Simulation/Functional Verification) <br>
nclaunch :- Compilation, Elaboration and Simulation <br>
ncverilog :- For Compilation and Elaboration of RTL code <br>
ncsim :- For simulation of RTL code <br>
ncvlog :- For compilation of RTL code in verilog <br>
ncvhdl :- For compilation of RTL code in VHDL <br>
ncelab :- For elaboration of RTL code <br>
<br>
nclaunch -new& :- Launching Simulation tool <br>
-new switch is used for invoking NCVERILOG for the first time for any design <br>
nclaunch& :- On subsequent calls to NCVERILOG <br>

# Synthesis
![image](https://github.com/user-attachments/assets/117da807-8bcf-4185-a9d4-367707181dd1)
<br>

# Liberty File (.lib)
For each cell of a library, this file describes
- The ports (input and output, power).
- The type of cells: buffer inverter, and gate, IO pads, ..
- The operating condition
- The power consuption (optional)
- The timing modelling <br>
Given by the foundry or could be generated from custom IP with LIBERATE tool <br>

# Constraint File - SDC (.sdc)
- SDC:- Synopsis Design Constraint
- The Chip/Top level sdc is one of the primary input for synthesis
- All timing information between design and outside:
  - Clock Signals and relation between clocks
  - Delay between signals and clock
  - Input or Output capacitance load
  - The Timing exceptions
- Primarily defining regulations that are to be forced onto the design for better efficiancy and lower deviation of area, power, timing from the specifications of the block/chip
- By default the time is ns.


# Common SDC Constraints  

## Operating conditions  
- **set_operating_conditions**  
  **Wire-load models**  
  - set_wire_load_mode  
  - set_wire_load_model  
  - set_wire_load_selection_group  
  **Environmental**  
  - set_drive  
  - set_driving_cell  
  - set_load  
  - set_fanout_load  
  - set_input_transition  
  - set_port_fanout_number  
  **Design rules**  
  - set_max_capacitance  
  - set_max_fanout  
  - set_max_transition  

## Timing  
- **create_clock**  
  - create_generated_clock  
  - set_clock_latency  
  - set_clock_transition  
  - set_disable_timing  
  - set_propagated_clock  
  - set_clock_uncertainty  
  - set_input_delay  
  - set_output_delay  
  **Exceptions**  
    - set_false_path  
    - set_max_delay  
    - set_multicycle_path  
  **Power**  
    - set_max_dynamic_power  
    - set_max_leakage_power  

# Synthesis Flow (Genus)
![image](https://github.com/user-attachments/assets/8ef36d09-2372-4def-a588-45cb13c336fb)

## Command Window:- (Cadence Genus tool) <br>
genus :- To launch genus <br>
genus -f genus_script.tcl :- Genus could be launced with batch mode with .tcl script <br>
gui_show :- To show gui <br>
gui_hide :- hide the gui window <br>

## Summary <br>
![image](https://github.com/user-attachments/assets/1625703a-9dea-4494-8fc1-301eae10fc22)
