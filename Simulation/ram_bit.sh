#!/bin/bash
cd Output

rm -f ram_bit_sim.vcd

iverilog -Wall -s ram_bit_tb -o ram_bit_sim ../../Modules/tb/ram_bit_tb.v ../../Modules/ram_bit.v

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp ram_bit_sim

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi


#gtkwave flag_reg_sim.vcd

#if [ $? -ne 0 ]; then
#    echo GTKWave failure
#    exit 1
#fi

rm -f ram_bit_sim