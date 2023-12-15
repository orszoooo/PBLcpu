module reg_f #(
    parameter WIDTH = 8,
    parameter SIZE = 11
)(
    clk,
    rf_addr_r1,
    rf_data_out1,
    rf_addr_r2,
    rf_data_out2,
    rf_addr_wr,
    rf_data_we,
    rf_data_in,

    //Stack interface
    //Push
    rf_stack_push1,
    rf_stack_push2,
    rf_stack_push3,
    rf_stack_push4,
    rf_stack_push5,
    rf_stack_push6,
    rf_stack_push7,
    rf_stack_push8,
    rf_stack_push9,

    //Pop
    rf_stack_pop_we,
    rf_stack_pop1,
    rf_stack_pop2,
    rf_stack_pop3,
    rf_stack_pop4,
    rf_stack_pop5,
    rf_stack_pop6,
    rf_stack_pop7,
    rf_stack_pop8,
    rf_stack_pop9,
);

input clk;
input [$clog2(SIZE)-1:0] rf_addr_r1;
input [$clog2(SIZE)-1:0] rf_addr_r2;
input [$clog2(SIZE)-1:0] rf_addr_wr;
input rf_data_we;
input [WIDTH-1:0] rf_data_in;

//Stack pop
input rf_stack_pop_we;
input [WIDHT-1:0] rf_stack_pop1;
input [WIDHT-1:0] rf_stack_pop2;
input [WIDHT-1:0] rf_stack_pop3;
input [WIDHT-1:0] rf_stack_pop4;
input [WIDHT-1:0] rf_stack_pop5;
input [WIDHT-1:0] rf_stack_pop6;
input [WIDHT-1:0] rf_stack_pop7;
input [WIDHT-1:0] rf_stack_pop8;
input [WIDHT-1:0] rf_stack_pop9;

output [WIDTH-1:0] rf_data_out1;
output [WIDTH-1:0] rf_data_out2;

//Stack push
output [WIDTH-1:0] rf_stack_push1;
output [WIDTH-1:0] rf_stack_push2;
output [WIDTH-1:0] rf_stack_push3;
output [WIDTH-1:0] rf_stack_push4;
output [WIDTH-1:0] rf_stack_push5;
output [WIDTH-1:0] rf_stack_push6;
output [WIDTH-1:0] rf_stack_push7;
output [WIDTH-1:0] rf_stack_push8;
output [WIDTH-1:0] rf_stack_push9;

reg [WIDTH-1:0] REG_FILE [SIZE:0];

initial begin
	REG_FILE[0] = {WIDTH{1'b0}};
	REG_FILE[1] = {WIDTH{1'b1}}; 
	//REG_FILE[2] - ACC
    //REG_FILE[3..10] - R0-R8 work registers
end

//Stack interface
//Pop
always @(posedge rf_stack_pop_we) begin
    REG_FILE[2] = rf_stack_pop1;
    REG_FILE[3] = rf_stack_pop2;
    REG_FILE[4] = rf_stack_pop3;
    REG_FILE[5] = rf_stack_pop4;
    REG_FILE[6] = rf_stack_pop5;
    REG_FILE[7] = rf_stack_pop6;
    REG_FILE[8] = rf_stack_pop7;
    REG_FILE[9] = rf_stack_pop8;
    REG_FILE[10] = rf_stack_pop9;
end


//Push
assign rf_stack_push1 = REG_FILE[2];
assign rf_stack_push2 = REG_FILE[3];
assign rf_stack_push3 = REG_FILE[4];
assign rf_stack_push4 = REG_FILE[5];
assign rf_stack_push5 = REG_FILE[6];
assign rf_stack_push6 = REG_FILE[7];
assign rf_stack_push7 = REG_FILE[8];
assign rf_stack_push8 = REG_FILE[9];
assign rf_stack_push9 = REG_FILE[10];

endmodule 