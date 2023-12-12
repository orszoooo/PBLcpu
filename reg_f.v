module reg_f #(
    parameter WIDTH = 3,
    parameter SIZE = 11
)(
    CLK,
    IN,
    EN,
    SEL,
    OUT
);

input [WIDTH-1:0] IN;
input EN, CLK;
input [$clog2(SIZE)-1:0] SEL;
output [WIDTH-1:0] OUT;

reg [WIDTH-1:0] REG_FILE [SIZE:0];

initial begin
	REG_FILE[0] = {WIDTH{1'b0}};
	REG_FILE[1] = {WIDTH{1'b1}}; 
	//REG_FILE[2] - ACC
end

always@(posedge CLK) begin
    if(EN & (SEL != {WIDTH{1'b0}}) & (SEL != {{WIDTH-1{1'b0}},1'b1})) begin
        REG_FILE[SEL] <= IN;
    end 
end

assign OUT = REG_FILE[SEL];

endmodule 