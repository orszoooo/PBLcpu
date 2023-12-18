#!/bin/bash
cd Output

rm -f ram_word_sim.vcd

iverilog -Wall -s ram_word_tb -o ram_word_sim ../../Modules/tb/ram_word_tb.v ../../Modules/ram_word.v

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp ram_word_sim

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi


#gtkwave flag_reg_sim.vcd

#if [ $? -ne 0 ]; then
#    echo GTKWave failure
#    exit 1
#fi

rm -f ram_word_sim