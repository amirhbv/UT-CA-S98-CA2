`timescale 1ns / 1ns
module Controller(
	input clk,
	input rst,
	input[3:0] opcode,
	input[7:0] func,

	output reg setWindow,
	output reg jump,
	output reg mem_write,
	output reg immdSel,
	output reg memOrALU,
	output reg toWrite,
	output reg [6:0] ALUop
);
	always @(posedge clk , rst) begin
		setWindow <= 1'b0 ;
		jump <= 1'b0 ;
		mem_write <= 1'b0 ;
		immdSel <= 1'b0 ;
		memOrALU <= 1'b0 ;
		toWrite <= 1'b0 ;
		ALUop <= 7'd0 ;
		case(opcode)
			4'b0000: begin
				toWrite <= 1'b1 ;
				memOrALU <= 1'b0 ;
			end

			4'b0001: begin
				mem_write <= 1'b1 ;
			end

			4'b0010: begin
				jump <= 1'b1 ;
			end

			4'b0100: begin
				ALUop <= 7'b1000111 ;
			end

			4'b1000: begin
				ALUop <= func ;
				setWindow <= func[7] ;
				if ( func[7:6] == 2'b00 )
				toWrite <= 1'b1 ;
			end

			4'b1100: begin
				ALUop <= 7'b0000010 ;
				toWrite <= 1'b1 ;
				immdSel <= 1'b1 ;
			end

			4'b1101: begin
				ALUop <= 7'b0000100 ;
				toWrite <= 1'b1 ;
				immdSel <= 1'b1 ;
			end

			4'b1110: begin
				ALUop <= 7'b0001000 ;
				toWrite <= 1'b1 ;
				immdSel <= 1'b1 ;
			end

			4'b1111: begin
				ALUop <= 7'b0010000 ;
				toWrite <= 1'b1 ;
				immdSel <= 1'b1 ;
			end
		endcase
	end
endmodule

