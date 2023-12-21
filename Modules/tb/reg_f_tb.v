`timescale 1ns/100ps

module reg_f_tb;
parameter WIDTH = 8;
parameter SIZE = 11;

reg CLK;

reg [$clog2(SIZE)-1:0] RF_ADDR_R1;
reg [$clog2(SIZE)-1:0] RF_ADDR_R2;
reg [$clog2(SIZE)-1:0] RF_ADDR_WR;
reg RF_DATA_WE;
reg [WIDTH-1:0] RF_DATA_IN;

//Stack interface
reg RF_STACK_POP;
reg RF_STACK_PUSH;
reg [5:0] RF_STACK_POINTER;

wire [WIDTH-1:0] RF_DATA_OUT1;
wire [WIDTH-1:0] RF_DATA_OUT2;
wire RF_ACC_ZERO;

reg_f # (
    .WIDTH(WIDTH),
    .SIZE(SIZE)) 
UUT(
    .clk(CLK),
    .rf_addr_r1(RF_ADDR_R1),
    .rf_data_out1(RF_DATA_OUT1),
    .rf_addr_r2(RF_ADDR_R2),
    .rf_data_out2(RF_DATA_OUT2),
    .rf_addr_wr(RF_ADDR_WR),
    .rf_data_we(RF_DATA_WE),
    .rf_data_in(RF_DATA_IN),

    //Stack interface
    .rf_stack_push(RF_STACK_PUSH),
    .rf_stack_pop(RF_STACK_POP),
	.rf_stack_pointer(RF_STACK_POINTER),
    .rf_acc_zero(RF_ACC_ZERO)
);

initial begin
    $display("Simulation of %m started.");
    RF_ADDR_R1 = 4'h0;
    RF_ADDR_R2 = 4'h0;
    RF_ADDR_WR = 4'h0;
    RF_DATA_WE = 1'b0;
    RF_DATA_IN = 8'h00;
    RF_STACK_POP = 1'b0;
    RF_STACK_PUSH = 1'b0;
    RF_STACK_POINTER = 6'h00;
    WAIT(2);

    //Write to registers 
    RF_ADDR_WR = 4'h3;
    RF_ADDR_R1 = 4'h3;
    RF_DATA_IN = 8'hB5;
    WAIT(1);
    RF_DATA_WE = 1'b1;
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(5);

    RF_ADDR_WR = 4'h7;
    RF_ADDR_R1 = 4'h7;
    RF_DATA_IN = 8'h8A;
    WAIT(1);
    RF_DATA_WE = 1'b1;
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(5);
    
    RF_ADDR_WR = 4'h0; 
    RF_ADDR_R1 = 4'h0;
    RF_DATA_IN = 8'h8A;
    WAIT(1);
    RF_DATA_WE = 1'b1; //cannot write to REG0 
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(5);

    RF_ADDR_WR = 4'h1;
    RF_ADDR_R1 = 4'h1; 
    RF_DATA_IN = 8'h1F;
    WAIT(1);
    RF_DATA_WE = 1'b1; //cannot write to REG1 
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(5);

    RF_ADDR_WR = 4'h2;
    RF_ADDR_R1 = 4'h2; 
    RF_DATA_IN = 8'h1F;
    WAIT(1);
    RF_DATA_WE = 1'b1; //can write to REG2 ACC CR 
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(5);

    //Read and write ath the same time
    RF_ADDR_WR = 4'h4;
    RF_ADDR_R1 = 4'h7; 
    RF_ADDR_R2 = 4'h4; 
    RF_DATA_IN = 8'hAC;
    WAIT(1);
    RF_DATA_WE = 1'b1; 
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(5);

    //Stack test
    RF_STACK_POINTER = 6'h01;
    RF_STACK_PUSH = 1'b1;
    WAIT(1);
    RF_STACK_PUSH = 1'b0;
    WAIT(5);


    RF_STACK_POP = 1'b1;
    WAIT(1);
    RF_STACK_POP = 1'b0;
    RF_STACK_POINTER = 6'h00;
    WAIT(5);

    RF_STACK_POINTER = 6'h01;
    RF_STACK_PUSH = 1'b1;
    WAIT(1);
    RF_STACK_PUSH = 1'b0;
    WAIT(1);
    
    RF_ADDR_WR = 4'h3;
    RF_ADDR_R1 = 4'h3; 
    RF_ADDR_R2 = 4'h4; 
    RF_DATA_IN = 8'hDC;
    WAIT(1);
    RF_DATA_WE = 1'b1; 
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(2);
        
    RF_ADDR_WR = 4'hA;
    RF_ADDR_R1 = 4'hA; 
    RF_ADDR_R2 = 4'h3; 
    RF_DATA_IN = 8'h6A;
    WAIT(1);
    RF_DATA_WE = 1'b1; 
    WAIT(1);
    RF_DATA_WE = 1'b0;
    WAIT(2);

    RF_STACK_POINTER = 6'h02;
    RF_STACK_PUSH = 1'b1;
    WAIT(1);
    RF_STACK_PUSH = 1'b0;
    WAIT(5);

    RF_STACK_POP = 1'b1;
    WAIT(1);
    RF_STACK_POP = 1'b0;
    RF_STACK_POINTER = 6'h01;
    WAIT(5);

    RF_STACK_POP = 1'b1;
    WAIT(1);
    RF_STACK_POP = 1'b0;
    RF_STACK_POINTER = 6'h00;
    WAIT(5);

    RF_STACK_POP = 1'b1;
    WAIT(1);
    RF_STACK_POP = 1'b0;
    RF_STACK_POINTER = 6'h00;
    WAIT(5);

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
	$dumpfile("reg_f_sim.vcd");
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