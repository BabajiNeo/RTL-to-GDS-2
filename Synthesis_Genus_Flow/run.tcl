# ============================================================
# Cadence Genus Automated Synthesis Flow
# ============================================================

# 1. Setup Environment & Inputs
setenv GENUS_HOME /home/install/genus

# Read technology libraries
read_libs /home/install/FOUNDRY/digital/90nm/dig/lib/slow.lib

# Read RTL sources
read_hdl rtl/im2col_final.v

# Read constraints
read_sdc sdc/input_constraint.sdc

# Elaborate design
elaborate

# ============================================================
# 2. Synthesis & Optimization
# ============================================================
syn_generic
syn_map
syn_opt

# ============================================================
# 3. Outputs & Reports
# ============================================================
# Write synthesized netlist and constraints
write_hdl > out/im2col_final_netlist.v
write_sdc > out/output_constraints.sdc

# Generate reports
report_timing > reports/timing_summary.rpt
report_area   > reports/area_summary.rpt
report_power  > reports/power_summary.rpt
report_design > reports/design_summary.rpt

# ============================================================
# 4. Optional: Logic Equivalence Check (LEC)
# ============================================================
# Uncomment if using Conformal
# read_library libs/slow.lib
# read_design -golden rtl/im2col_final.v -verilog -top im2col_final
# read_design -revised out/im2col_final_netlist.v -verilog -top im2col_final
# match
# verify
# report verification > reports/lec_verification.rpt
```
