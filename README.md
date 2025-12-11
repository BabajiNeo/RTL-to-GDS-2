Got it Naveen — let’s make this a **complete NCLaunch / irun command flow reference**, from the very basics all the way to advanced verification. Think of it as a cheat sheet you can keep handy.

---

## 🟢 NCLaunch Basics
```bash
nclaunch &             # Start NCLaunch GUI
nclaunch -new &        # Start a fresh project/session
```

---

## 🔵 Legacy Flow (separate steps)
```bash
ncvlog design.v              # Compile Verilog
ncvhdl design.vhd            # Compile VHDL
ncelab testbench_top         # Elaborate design hierarchy
ncsim testbench_top          # Run simulation
```

---

## 🟡 Unified Flow (`irun`)
```bash
irun design.v design_tb.v -access +rwc -gui
```
- Compiles, elaborates, simulates in one shot  
- `-access +rwc` → full signal access  
- `-gui` → launches GUI

---

## 🟣 Common Options
```bash
-access +rwc        # Read/Write/Change access to signals
-gui                # Launch GUI
-coverage all       # Enable coverage collection
-f filelist.f       # Compile files listed in filelist
-top <module>       # Specify top-level testbench
-timescale 1ns/1ps  # Set simulation timescale
-sv                 # Enable SystemVerilog
-uvmhome <path>     # Point to UVM library
-input waves.tcl    # Run TCL script
-snapshot <name>    # Save elaboration snapshot
```

---

## 🔴 Intermediate Examples
```bash
irun -f filelist.f -top testbench_top -access +rwc -gui
irun design.v design_tb.v -timescale 1ns/1ps -access +rwc -gui
irun design.v design_tb.v -sv -access +rwc -gui
```

---

## 🟣 Advanced Verification Examples
```bash
irun design.v design_tb.v -coverage all -access +rwc -gui
irun design.v design_tb.v -uvmhome $UVM_HOME -access +rwc -gui
irun design.v design_tb.v -input waves.tcl -access +rwc -gui
irun -snapshot snap1 -top testbench_top -access +rwc
ncsim snap1
```

---

## 🟤 Flow Summary
1. **Start NCLaunch** (`nclaunch`, `nclaunch -new`)  
2. **Compile** (`ncvlog`, `ncvhdl`)  
3. **Elaborate** (`ncelab`)  
4. **Simulate** (`ncsim`)  
5. **Shortcut** → `irun` does all three  
6. Add **options** for GUI, access, timescale, coverage, UVM, automation  
7. Use **snapshots** for faster reruns  
8. Analyze **coverage** with IMC  

---
