`timescale 1ns/100ps

module stack_8bit_tb;
parameter WIDTH = 8;
parameter SIZE = 32;

reg                          CLK;
reg     [$clog2(SIZE)-1:0]   ADDRESS;
reg     [WIDTH-1:0]          DATA;
reg                          WREN;
wire    [WIDTH-1:0]          Q;

stack_8bit # (
    .WIDTH(WIDTH),
    .SIZE(SIZE)) 
UUT(
	.address(ADDRESS),
	.clock(CLK),
	.data(DATA),
	.wren(WREN),
	.q(Q)
);

integer i = 0;

initial begin
    $display("Simulation of %m started.");
    ADDRESS = 5'h00;
    WREN = 1'b1;
    
    //Initialize the stack with 8'h00
    for(i = 0; i < SIZE; i++) begin
        ADDRESS  = ADDRESS  + 8'h01;
        DATA = 8'h00;
        WAIT(1);
    end

    WREN = 1'b0;

    WAIT(10);
    ADDRESS = 5'h00;
    
    //Fill the stack
    for(i = 0; i < SIZE; i++) begin
        WREN = 1'b1;
        ADDRESS  = ADDRESS  + 8'h01;
        DATA = DATA + 8'h02;
        WAIT(1);
        WREN = 1'b0;
        WAIT(2);
    end

    //Present the content
    ADDRESS = 5'h00;
    WREN = 1'b0;
    
    for(i = 0; i < SIZE; i++) begin
        ADDRESS  = ADDRESS  + 8'h01;
        WAIT(2);
    end
    
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
	$dumpfile("stack_8bit_sim.vcd");
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