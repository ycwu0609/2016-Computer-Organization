//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	funct_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,

	BranchType_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input      [6-1:0] funct_i;

output         RegWrite_o;
output [4-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output	[1:0]	BranchType_o;
output	Jump_o;
output	MemRead_o;
output	MemWrite_o;
output	[1:0] MemtoReg;
 
//Internal Signals
wire    [4-1:0] ALU_op_o;
wire            ALUSrc_o;
wire            RegWrite_o;
wire            RegDst_o;
wire            Branch_o;
wire [1:0] BranchType_o;
wire	Jump_o;
wire	MemRead_o;
wire	MemWrite_o;
wire [1:0]	MemtoReg;
wire shamt_imme;
//Parameter


//Main function
assign ALUSrc_o = (instr_op_i==6'd0)?1'b0:
			(instr_op_i==6'd4)?1'b0:
			(instr_op_i==6'd5)?1'b0:1'b1;
assign RegWrite_o = (instr_op_i==6'b101011)?1'b0:
			(instr_op_i==6'b000010)?1'b0:
			(instr_op_i==6'd4)?1'b0:
			(instr_op_i==6'd5)?1'b0:
			(instr_op_i==6'b000010)?1'b0:
			(instr_op_i==6'b000111)?1'b0:
			(instr_op_i==6'b000101)?1'b0:
			(instr_op_i==6'b000001)?1'b0:1'b1;
assign ALU_op_o = (instr_op_i==6'd0)?4'b001:		//ADD, SUB, AND, OR, SLT, SLL, SRLV, MUL
			(instr_op_i==6'd8)?4'b0010:	//ADDI
			(instr_op_i==6'd10)?'b0011:	//SLTI
			(instr_op_i==6'd4)?4'b0100:	//BEQ
			(instr_op_i==6'd15)?4'b0101:	//LUI
			(instr_op_i==6'd13)?4'b0110:	//ORI
			(instr_op_i==6'd5)?4'b0111:	//BNE
			(instr_op_i==6'b100011)?4'b1000:
			(instr_op_i==6'b101011)?4'b1001:
			(instr_op_i==6'b000111)?4'b0110:	//BGT
			(instr_op_i==6'b000101)?4'b1010:	//BNEZ
			(instr_op_i==6'b000001)?4'b1011:0;	//BGEZ

assign RegDst_o = (instr_op_i==6'd0)?(funct_i==6'd0)?1'b0:1'b1:1'b0;
assign Branch_o = (instr_op_i==6'd4)?1'b1:
			(instr_op_i==6'd5)?1'b1:1'b0;
// lab3_add
assign BranchType_o = (instr_op_i==6'd4)?0:
			(instr_op_i==6'd5)?3:1;
assign Jump_o = (instr_op_i == 6'b000010)?1:0;
assign MemRead_o = (instr_op_i == 6'b100011)?1:0;
assign MemWrite_o = (instr_op_i == 6'b101011)?1:0;
assign MemtoReg = (instr_op_i == 6'b100011)?1:0;	

endmodule





                    
                    