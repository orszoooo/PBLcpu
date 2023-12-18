`timescale 1ns/100ps

module ram_bit_tb;
parameter AWIDTH = 8;

reg                    CLK;
reg     [AWIDTH-1:0]   ADDRESS_A;
reg     [AWIDTH-1:0]   ADDRESS_B;
reg     [AWIDTH-1:0]   ADDRESS_C;
reg                    DATA;
reg                    WE;
wire                   A_OUT;
wire                   B_OUT;

ram_bit # (
    .AWIDTH(AWIDTH)) 
UUT(
    .clk(CLK),
    .port_a_address(ADDRESS_A),
    .port_a_out(A_OUT),

    .port_b_address(ADDRESS_B),
    .port_b_out(B_OUT),

    .port_c_address(ADDRESS_C),
    .port_c_data(DATA),
    .port_c_we(WE)
);

integer i = 0;

initial begin
    $display("Simulation of %m started.");
    ADDRESS_A = 5'h00;
    ADDRESS_B = 5'h00;
    ADDRESS_C = 5'h00;
    DATA = 1'b0;
    WE = 1'b1;
    
    //Initialize the stack with 8'h00
    for(i = 0; i < 2**AWIDTH; i++) begin
        WE = 1'b1;
        ADDRESS_C  = ADDRESS_C  + 8'h01;
        DATA = ~DATA;
        WAIT(1);
        WE = 1'b0;
        WAIT(1);
    end

    WE = 1'b0;

    WAIT(10);

    //PORT A read
    for(i = 0; i < 2**AWIDTH; i++) begin
        ADDRESS_A  = ADDRESS_A + 8'h01;
        WAIT(1);
    end

    WAIT(10);

    //PORT B read
    for(i = 0; i < 2**AWIDTH; i++) begin
        ADDRESS_B  = ADDRESS_B  + 8'h01;
        WAIT(1);
    end
    
    WAIT(10);
    //Both ports read - different cells
    ADDRESS_A = 5'h01;

    for(i = 0; i < (2**AWIDTH-1); i++) begin
        ADDRESS_A  = ADDRESS_A + 8'h01;
        ADDRESS_B  = ADDRESS_B - 8'h01;
        WAIT(1);
    end

    WAIT(10);

    //Both ports read - same cells
    ADDRESS_A = 5'h00;
    ADDRESS_B = 5'h00;
    WAIT(1);

    for(i = 0; i < 2**AWIDTH; i++) begin
        ADDRESS_A  = ADDRESS_A + 8'h01;
        ADDRESS_B  = ADDRESS_B + 8'h01;
        WAIT(1);
    end

    //Both ports read - different cells
    //Simultanues write to same cell as port A
    ADDRESS_A = 5'h01;
    ADDRESS_C = 5'h01;

    for(i = 0; i < (2**AWIDTH-1); i++) begin
        WE = 1'b1;
        ADDRESS_A  = ADDRESS_A + 8'h01;
        ADDRESS_B  = ADDRESS_B - 8'h01;
        ADDRESS_C  = ADDRESS_C  + 8'h01;
        DATA = ~A_OUT;
        WAIT(1);
        WE = 1'b0;
        WAIT(1);
    end

    WAIT(10);

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
	$dumpfile("ram_bit_sim.vcd");
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