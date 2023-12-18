`timescale 1 ns / 100 ps
//Models the IP Core RAM 1-Port used in Quartus

module stack_8bit #(
	parameter WIDTH = 8,
	parameter SIZE = 32
)(
	address,
	clock,
	data,
	wren,
	q
);

input	[$clog2(SIZE)-1:0]  address;
input						clock;
input	[WIDTH-1:0]  		data;
input	  					wren;
output	[WIDTH-1:0]  		q;

reg 	[WIDTH-1:0] 		STACK 	[SIZE-1:0]; 

always @(posedge clock) begin
	if(wren) STACK[address] <= data;
end

assign q = STACK[address];

endmodule