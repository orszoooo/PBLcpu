`timescale 1ns/100ps

module flag_reg (
    clk,
    flag_rst,
    flag_c_in,
    flag_z_in,
    flag_b_in,
    flag_c_out,
    flag_z_out,
    flab_b_out
);

input clk, flag_rst, flag_c_in, flag_z_in, flag_b_in;

output reg flag_c_out; //Carry
output reg flag_z_out; //Zero
output reg flag_b_out; //Borrow

//NOT READY YET!

reg C_LAST = 1'b0;
reg B_LAST = 1'b0;

//Reset
always @(RST) begin
    C <= 1'b0;
    Z <= 1'b0;
    B <= 1'b0;
end

//Zero
always @(Zin) begin
    Z <= Zin;
end

//Set C
always @(Cin) begin
    if(Cin || C_LAST) begin
        C = 1'b1; 
    end
    else begin
        C = 1'b0;
    end
end

//Set B
always @(Bin) begin
    if(Bin || B_LAST) begin
        B = 1'b1; 
    end
    else begin
        B = 1'b0;
    end
end

//Reset C/B
always @(posedge CLK) begin
    if(!Cin && C_LAST) begin
        C <= 1'b0; 
    end
    C_LAST <= Cin;

    if(!Bin && B_LAST) begin
        B <= 1'b0; 
    end
    B_LAST <= Bin;
end

endmodule