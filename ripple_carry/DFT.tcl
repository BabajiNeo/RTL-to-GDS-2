# RTL Script to run Basic Synthesis Flow

# -----------------------------
# Library setup
# -----------------------------
set_db init_lib_search_path /home/vlsi12/Music/sclpdk/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss/
set_db library tsl18fs120_scl_ss.lib

# -----------------------------
# Read RTL and constraints
# -----------------------------
read_hdl ripple_carry.v
elaborate
current_design ripple_carry
read_sdc constraint_top.sdc

# -----------------------------
# DFT Configuration
# -----------------------------
set_db dft_scan_style muxed_scan
set_db dft_prefix dft_

# Create shift enable port for scan (if not in RTL)
define_dft shift_enable -name SE -active high -create_port SE

# Initial DFT rule check
check_dft_rules

# -----------------------------
# Synthesis Flow
# -----------------------------
set_db syn_generic_effort medium
syn_generic

set_db syn_map_effort medium
syn_map

set_db syn_opt_effort medium
syn_opt

# Re-check DFT rules after synthesis
check_dft_rules

# -----------------------------
# DFT Scan Chain Setup
# -----------------------------
set_db design:ripple_carry .dft_min_number_of_scan_chains 1


# Define scan chain using existing scan ports
define_dft scan_chain -name top_chain -sdi scan_in -sdo scan_out -shared_input -shared_output

# Optional: Preview scan chain connection
connect_scan_chains -auto_create_chains -preview

# Finalize scan chain connection
connect_scan_chains -auto_create_chains

# Incremental optimization after DFT
syn_opt -incr

# -----------------------------
# Reports and Outputs
# -----------------------------
report_scan_chains
write_dft_atpg -library ../lib/slow_vddlv@_basiccells.v
write_hdl > ripple_carry_netlist_dft.v
write_sdc > ripple_carry_dft.sdc
write_sdf -edges check_edge -timescale ns -recrem split > delays_dft.sdf
write_scandef > ripple_carry_scanDEF.scandef

# Summary reports
report_timing > ripple_carry_timing.rep
report_area > ripple_carry_area.rep
report_gates > ripple_carry_gatecount.rep
report_power > ripple_carry_power.rep
report_timing_summary > ripple_carry_timing_summary.rep

# Optional GUI or viewer
show

