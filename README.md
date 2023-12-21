## Repo guide
"Docs" folder contains the instruction set(created together with Łukasz Fuss) and CPU schematic(done by Łukasz Fuss).

"Modules" folder contains all the Verilog files for use only in simulation. It has models of RAM and stack written in Verilog. 

"Quartus" folder contains all files required for project synthesis on the Intel Altera FPGA platform. It uses IP cores for RAM and stack.

"Simulation" folder contains all scripts to run testbenches for all modules from "Modules" folder.
