module BCD_TO_7SEG (
	input[3:0] IN_BCD,
	output reg[6:0] OUT_7SEG
);
	
	always @ (*)
	case(IN_BCD) //a b c d e f g 
		4'b0000: OUT_7SEG = 7'b0000001;
		4'b0001: OUT_7SEG = 7'b1001111;
		4'b0010: OUT_7SEG = 7'b0010010;
		4'b0011: OUT_7SEG = 7'b0000110;
		4'b0100: OUT_7SEG = 7'b1001100;
		4'b0101: OUT_7SEG = 7'b0100100;
		4'b0110: OUT_7SEG = 7'b0100000;
		4'b0111: OUT_7SEG = 7'b0001101;
		4'b1000: OUT_7SEG = 7'b0000000;
		4'b1001: OUT_7SEG = 7'b0000100;
		default: OUT_7SEG = 7'b0000001;
	endcase
	
endmodule