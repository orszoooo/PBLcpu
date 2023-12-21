#!/bin/bash
cd Output

rm -f reg_f_sim.vcd

iverilog -Wall -s reg_f_tb -o reg_f_sim ../../Modules/tb/reg_f_tb.v ../../Modules/reg_f.v ../../Modules/reg_f_stack.v ../../Modules/stack_8bit.v

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp reg_f_sim

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi


#gtkwave flag_reg_sim.vcd

#if [ $? -ne 0 ]; then
#    echo GTKWave failure
#    exit 1
#fi

rm -f reg_f_sim