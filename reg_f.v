module reg_f #(
    parameter WIDTH = 8,
    parameter SIZE = 11,
    parameter STACK_SIZE = 5
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
    rf_stack_push,
    rf_stack_pop,
    rf_acc_zero
);

input clk;
input [$clog2(SIZE)-1:0] rf_addr_r1;
input [$clog2(SIZE)-1:0] rf_addr_r2;
input [$clog2(SIZE)-1:0] rf_addr_wr;
input rf_data_we;
input [WIDTH-1:0] rf_data_in;

//Stack interface
input rf_stack_pop;
input rf_stack_push;

output [WIDTH-1:0] rf_data_out1;
output [WIDTH-1:0] rf_data_out2;
output rf_acc_zero;//!!

//TODO: Use IP core
reg [WIDTH-1:0] Reg_File [SIZE-1:0];

reg [WIDTH-1:0] Reg_Stack [STACK_SIZE-1:0];

initial begin
	REG_FILE[0] = {WIDTH{1'b0}};
	REG_FILE[1] = {WIDTH{1'b1}}; 
	//REG_FILE[2] - ACC
    //REG_FILE[3..10] - R0-R8 work registers
end

always @(posedge clk) begin
    if(rf_data_we) begin
        Reg_File[rf_addr_wr] = rf_data_in;
    end
end

assign rf_data_out1 = Reg_File[rf_addr_r1];
assign rf_data_out2 = Reg_File[rf_addr_r2];

always @(posedge rf_stack_push) begin
    Reg_Stack[0] = Reg_File[2];
    Reg_Stack[1] = Reg_File[3];
    Reg_Stack[2] = Reg_File[4];
    Reg_Stack[3] = Reg_File[5];
    Reg_Stack[4] = Reg_File[6];
    Reg_Stack[5] = Reg_File[7];
    Reg_Stack[6] = Reg_File[8];
    Reg_Stack[7] = Reg_File[9];
    Reg_Stack[8] = Reg_File[10];
end

always @(posedge rf_stack_pop) begin
    Reg_File[2] = Reg_Stack[0];
    Reg_File[3] = Reg_Stack[1];
    Reg_File[4] = Reg_Stack[2];
    Reg_File[5] = Reg_Stack[3];
    Reg_File[6] = Reg_Stack[4];
    Reg_File[7] = Reg_Stack[5];
    Reg_File[8] = Reg_Stack[6];
    Reg_File[9] = Reg_Stack[7];
    Reg_File[10] = Reg_Stack[8];
end

endmodule 