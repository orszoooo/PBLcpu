`timescale 1ns/100ps

module alu_tb;
parameter WIDTH = 8;
parameter IWIDTH = 8;
parameter SOURCES = 4;

reg CLK;
reg [IWIDTH-1:0] OP_CODE; 

reg [$clog2(SOURCES)-1:0] SOURCE1_CHOICE;
reg BIT_MEM_A;
reg [WIDTH-1:0] WORD_MEM_A;
reg [WIDTH-1:0] RF_A;
reg [WIDTH-1:0] IMM_A;

reg [$clog2(SOURCES)-1:0] SOURCE2_CHOICE;
reg BIT_MEM_B;
reg [WIDTH-1:0] WORD_MEM_B;
reg [WIDTH-1:0] RF_B;
reg [WIDTH-1:0] IMM_B;

reg ALU_C_IN;
reg ALU_B_IN;

wire [WIDTH-1:0] ALU_OUT;
wire ALU_C_OUT;
wire ALU_B_OUT;

alu # (
    .WIDTH(WIDTH),
    .IWIDTH(IWIDTH),
    .SOURCES(SOURCES)) 
UUT(
    .op_code(OP_CODE),
    .source1_choice(SOURCE1_CHOICE),
    .bit_mem_a(BIT_MEM_A),
    .word_mem_a(WORD_MEM_A),
    .rf_a(RF_A),
    .imm_a(IMM_A),
    .source2_choice(SOURCE2_CHOICE),
    .bit_mem_b(BIT_MEM_B),
    .word_mem_b(WORD_MEM_B),
    .rf_b(RF_B),
    .imm_b(IMM_B),
    .alu_c_in(ALU_C_IN),
    .alu_b_in(ALU_B_IN),
    .alu_c_out(ALU_C_OUT),
    .alu_b_out(ALU_B_OUT),
    .alu_out(ALU_OUT)   
);

initial begin
    $display("Simulation of %m started.");
    OP_CODE = 8'h00; 

    SOURCE1_CHOICE = 2'h0;
    BIT_MEM_A = 1'b0;
    WORD_MEM_A = 8'h00;
    RF_A = 8'h00;
    IMM_A = 8'h00;

    SOURCE2_CHOICE = 2'h0;
    BIT_MEM_B = 1'b0;
    WORD_MEM_B = 8'h00;
    RF_B = 8'h00;
    IMM_B = 8'h00;
    
    ALU_C_IN = 1'b0;
    ALU_B_IN = 1'b0;
    WAIT(5);

    //AND - source1 register, source2 - imm
    OP_CODE = 8'h00; 
    RF_A = 8'h99;

    SOURCE2_CHOICE = 2'h3;
    IMM_B = 8'hAA;
    WAIT(2);

    WAIT(10);
    $finish;
end

// Clock generator
initial begin
	CLK = 1'b0;
	forever #5 CLK = ~CLK;
end

// Writing VCD waveform
initial begin
	$dumpfile("alu_sim.vcd");
	$dumpvars(0, UUT);
	$dumpon;
end


task WAIT;
input [31:0] DY;
begin
	repeat(DY) @(posedge CLK);
end
endtask

endmodule