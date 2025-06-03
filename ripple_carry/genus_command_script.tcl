# Genus Script
# Shankar Naveen Pathak

read_libs /home/vlsi12/Music/sclpdk/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib
clear
read_hdl ripple_carry.v
elaborate
read_sdc constraint_top.sdc
read_sdc constraint_top.sdc
clear
syn_generic
syn_map
report_gates
syn_opt
report_gates
write_hdl > ripple_carry__netlist.v
write_sdc > constraint_tool.sdc
gui_show
