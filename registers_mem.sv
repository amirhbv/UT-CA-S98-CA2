module Reg_memory(
	input clk,
	input rst,
	input [1:0] R_i,
	input [1:0] R_j,
	input [1:0] wnd,
	input [15:0] write_data,
	input setWindow,
	input toWrite,
	output reg[15:0] data_i,
	output reg[15:0] data_j
);
	reg[1 :0] window ;
	reg[15:0] mem[0:7] ;
	always @(*) begin
		if ( setWindow )
			window <= wnd ;
		case(window)
			2'b00:{data_i,data_j} <= {mem[R_i + 0],mem[R_j + 0]} ;
			2'b01:{data_i,data_j} <= {mem[R_i + 2],mem[R_j + 2]} ;
			2'b10:{data_i,data_j} <= {mem[R_i + 4],mem[R_j + 4]} ;
			2'b11:{data_i,data_j} <= {mem[(R_i + 6)%8],mem[(R_i + 6)%8]} ;
		endcase
	end
	always @(negedge clk , posedge rst) begin
		if(rst) begin
			for (integer i = 0 ; i < 8 ; i = i + 1)
			mem[i] <= 16'd0;
		end
		else if (toWrite)
			case(window)
				2'b00:mem[    R_i + 0] <= write_data ;
				2'b01:mem[    R_i + 2] <= write_data ;
				2'b10:mem[    R_i + 4] <= write_data ;
				2'b11:mem[(R_i + 6)%8] <= write_data ;
			endcase
		end
	end
endmodule
