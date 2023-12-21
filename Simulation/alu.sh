#!/bin/bash
cd Output

rm -f alu_sim.vcd

iverilog -Wall -s alu_tb -o alu_sim ../../Modules/tb/alu_tb.v ../../Modules/alu.v 

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp alu_sim

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi


#gtkwave flag_reg_sim.vcd

#if [ $? -ne 0 ]; then
#    echo GTKWave failure
#    exit 1
#fi

rm -f alu_sim