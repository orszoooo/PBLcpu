`timescale 1ns/100ps

module flag_reg (
    clk,
    flag_rst,
    flag_c_in,
    flag_z_in,
    flag_b_in,
    flag_c_out,
    flag_z_out,
    flag_b_out
);

input clk, flag_rst, flag_c_in, flag_z_in, flag_b_in;

output reg flag_c_out; //Carry
output reg flag_z_out; //Zero
output reg flag_b_out; //Borrow

//NOT READY YET!

reg C_LAST = 1'b0;
reg B_LAST = 1'b0;

//Reset
always @(flag_rst) begin
    flag_c_out <= 1'b0;
    flag_z_out <= 1'b0;
    flag_b_out <= 1'b0;
end

//Zero
always @(flag_z_in) begin
    flag_z_out <= flag_z_in;
end

//Set C
always @(flag_c_in) begin
    if(flag_c_in || C_LAST) begin
        flag_c_out = 1'b1; 
    end
    else begin
        flag_c_out = 1'b0;
    end
end

//Set B
always @(flag_b_in) begin
    if(flag_b_in || B_LAST) begin
        flag_b_out = 1'b1; 
    end
    else begin
        flag_b_out = 1'b0;
    end
end

//Reset C/B
always @(posedge clk) begin
    if(!flag_c_in && C_LAST) begin
        flag_c_out <= 1'b0; 
    end
    C_LAST <= flag_c_in;

    if(!flag_b_in && B_LAST) begin
        flag_b_out <= 1'b0; 
    end
    B_LAST <= flag_b_in;
end

endmodule