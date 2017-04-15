module Forwarding_unit(
	MEM_rd,
	WB_rd,
	EX_rs,
	EX_rt,
	MEM_RegWrite,
	WB_RegWrite,
	A_o,
	B_o
    );
//I/O ports  
input [5-1:0] MEM_rd;
input [5-1:0] WB_rd;
input [5-1:0] EX_rs;
input [5-1:0] EX_rt;
input MEM_RegWrite;
input WB_RegWrite;
output [2-1:0] A_o;
output [2-1:0] B_o;

//Internal Signals
wire [2-1:0] A_o; 
wire [2-1:0] B_o;
//Main function


assign A_o = (MEM_RegWrite & (MEM_rd != 0) & (MEM_rd == EX_rs))?2'b01:
		(WB_RegWrite & (WB_rd != 0) & (WB_rd == EX_rs))?2'b10:
		2'b00;

assign B_o = (MEM_RegWrite & (MEM_rd != 0) & (MEM_rd == EX_rt))?2'b01:
		(WB_RegWrite & (WB_rd != 0) & (WB_rd == EX_rt))?2'b10:
		2'b00;



endmodule
