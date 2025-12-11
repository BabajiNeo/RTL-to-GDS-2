# 📘 Step‑by‑Step Genus Synthesis Flow

## 1. Setup Environment
- Ensure **Cadence Genus** is installed and licensed.
- Organize directories:
  ```
  libs/       → technology libraries (.lib)
  rtl/        → Verilog RTL sources
  sdc/        → constraint files
  scripts/    → TCL run scripts
  reports/    → synthesis reports
  out/        → generated netlist & constraints
  ```

## 2. Read Libraries
```tcl
read_libs /home/install/FOUNDRY/digital/90nm/dig/lib/slow.lib
```
- Loads Liberty timing library for the 90nm technology node.
- Choose the correct corner (slow.lib for worst‑case).

## 3. Read RTL Design
```tcl
read_hdl rtl/im2col_final.v
```
- Reads your Verilog source file(s).
- Include all dependent modules if needed.

---

## 4. Elaborate Design
```tcl
elaborate
```
- Builds the internal design graph.
- Resolves hierarchy and prepares for synthesis.

## 5. Apply Constraints
```tcl
read_sdc sdc/input_constraint.sdc
```
- Loads timing and I/O constraints.
- Example SDC:
  ```tcl
  create_clock -name clk -period 1.0 -waveform {0 0.5} [get_ports clk]
  set_clock_transition -rise 0.1 [get_clocks clk]
  set_clock_transition -fall 0.1 [get_clocks clk]
  set_clock_uncertainty 0.01 [get_clocks clk]
  set_input_delay -max 1.0 -clock clk [all_inputs]
  set_output_delay -max 1.0 -clock clk [all_outputs]
  ```

## 6. Generic Synthesis
```tcl
syn_generic
```
- Converts RTL into technology‑independent logic.


## 7. Technology Mapping
```tcl
syn_map
```
- Maps generic logic to 90nm standard cells.

## 8. Gate‑Level Reporting
```tcl
report_gates
```
- Shows utilized cells and area before optimization.


## 9. Optimization
```tcl
syn_opt
```
- Refines design for timing, area, and power.
- Run reports again:
  ```tcl
  report_gates
  ```

## 10. GUI Inspection (Optional)
```tcl
gui_show
```
- **File → Report → Summary:** Area, cell counts.  
- **Power → Report → Detailed Report:** Power breakdown.  
- **Timing → Debug Timing → Generate:** Worst path, slack.  
- Negative slack = setup violation; double‑click to trace path.


## 11. Write Outputs
```tcl
write_hdl > out/im2col_final_netlist.v
write_sdc > out/output_constraints.sdc
```
- Saves synthesized netlist and updated constraints.

## 12. Generate Reports
```tcl
report_timing > reports/timing_summary.rpt
report_area   > reports/area_summary.rpt
report_power  > reports/power_summary.rpt
report_design > reports/design_summary.rpt
```

## 13. Logic Equivalence Check (LEC)
- Verify RTL vs synthesized netlist.
- Example Conformal script:
  ```tcl
  read_library libs/slow.lib
  read_design -golden rtl/im2col_final.v -verilog -top im2col_final
  read_design -revised out/im2col_final_netlist.v -verilog -top im2col_final
  match
  verify
  report verification > reports/lec_verification.rpt
  ```

