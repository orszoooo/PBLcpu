#!/bin/bash

rm -f cpu_sim
rm -f cpu_sim.vcd

iverilog -Wall -s flag_reg_tb -o flag_reg_sim flag_reg_tb.v ../../flag_reg.v

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp flag_reg_sim

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi


#gtkwave flag_reg_sim.vcd

#if [ $? -ne 0 ]; then
#    echo GTKWave failure
#    exit 1
#fi
