`timescale 1ns / 1ns
module ALU(
	input [15:0] data_i , data_j ,
	input [6:0] aluOp ,
	output reg [15:0] result ,
	output reg eq
);
	always @(*) begin
		case( aluOp )
			7'b0000001 : result = data_j ;
			7'b0000010 : result = data_i + data_j ;
			7'b0000100 : result = data_i - data_j ;
			7'b0001000 : result = data_i & data_j ;
			7'b0010000 : result = data_i | data_j ;
			7'b0100000 : result = !data_j ;
			7'b1000111 : eq = (data_i == data_j)  ;
			default : begin
				result = 0 ;
				eq = 0 ;
			end
		endcase
	end
endmodule
