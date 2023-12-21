`timescale 1ns/100ps

module reg_f_stack_tb;
parameter WIDTH = 8;

reg CLK;
reg [5:0] ADDR;
reg WREN;

reg [WIDTH-1:0] REG1_DATA;
reg [WIDTH-1:0] REG2_DATA;
reg [WIDTH-1:0] REG3_DATA;
reg [WIDTH-1:0] REG4_DATA;
reg [WIDTH-1:0] REG5_DATA;
reg [WIDTH-1:0] REG6_DATA;
reg [WIDTH-1:0] REG7_DATA;
reg [WIDTH-1:0] REG8_DATA;
reg [WIDTH-1:0] REG9_DATA;

wire [WIDTH-1:0] STACK1_OUT;
wire [WIDTH-1:0] STACK2_OUT;
wire [WIDTH-1:0] STACK3_OUT;
wire [WIDTH-1:0] STACK4_OUT;
wire [WIDTH-1:0] STACK5_OUT;
wire [WIDTH-1:0] STACK6_OUT;
wire [WIDTH-1:0] STACK7_OUT;
wire [WIDTH-1:0] STACK8_OUT;
wire [WIDTH-1:0] STACK9_OUT;

reg_f_stack # (
    .WIDTH(WIDTH)) 
UUT(
    .clk(CLK),
    .addr(ADDR),
    .wren(WREN),
    .reg1_data(REG1_DATA),
    .reg2_data(REG2_DATA),
    .reg3_data(REG3_DATA),
    .reg4_data(REG4_DATA),
    .reg5_data(REG5_DATA),
    .reg6_data(REG6_DATA),
    .reg7_data(REG7_DATA),
    .reg8_data(REG8_DATA),
    .reg9_data(REG9_DATA),
    .stack1_out(STACK1_OUT),
    .stack2_out(STACK2_OUT),
    .stack3_out(STACK3_OUT),
    .stack4_out(STACK4_OUT),
    .stack5_out(STACK5_OUT),
    .stack6_out(STACK6_OUT),
    .stack7_out(STACK7_OUT),
    .stack8_out(STACK8_OUT),
    .stack9_out(STACK9_OUT)
);

initial begin
    $display("Simulation of %m started.");
    ADDR = 6'h00;
    WREN = 1'b0; 
    REG1_DATA = 8'h00;
    REG2_DATA = 8'h00;
    REG3_DATA = 8'h00;
    REG4_DATA = 8'h00;
    REG5_DATA = 8'h00;
    REG6_DATA = 8'h00;
    REG7_DATA = 8'h00;
    REG8_DATA = 8'h00;
    REG9_DATA = 8'h00;
    WAIT(1);

    WREN = 1'b0;
    REG1_DATA = 8'h11;
    REG2_DATA = 8'h22;
    REG3_DATA = 8'h33;
    REG4_DATA = 8'h44;
    REG5_DATA = 8'h55;
    REG6_DATA = 8'h66;
    REG7_DATA = 8'h77;
    REG8_DATA = 8'h88;
    REG9_DATA = 8'h99;
    WAIT(1);
    ADDR = 6'h01;
    WREN = 1'b1; //stack push
    WAIT(1);
    WREN = 1'b0;
    WAIT(5);

    REG1_DATA = 8'h12;
    REG2_DATA = 8'h34;
    REG3_DATA = 8'h56;
    REG4_DATA = 8'h78;
    REG5_DATA = 8'h90;
    REG6_DATA = 8'h21;
    REG7_DATA = 8'h43;
    REG8_DATA = 8'h65;
    REG9_DATA = 8'h87;
    WAIT(1);
    ADDR = 6'h02; //stack push
    WREN = 1'b1;
    WAIT(1);
    WREN = 1'b0;
    WAIT(5);

    ADDR = 6'h01; //stack pop
    WAIT(1);

    REG1_DATA = 8'h77;
    REG2_DATA = 8'h77;
    REG3_DATA = 8'h77;
    REG4_DATA = 8'h77;
    REG5_DATA = 8'h77;
    REG6_DATA = 8'h77;
    REG7_DATA = 8'h77;
    REG8_DATA = 8'h77;
    REG9_DATA = 8'h77;
    WAIT(1);
    ADDR = 6'h02; //stack push
    WAIT(1);
    WREN = 1'b1;
    WAIT(1);
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
	$dumpfile("reg_f_stack_sim.vcd");
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