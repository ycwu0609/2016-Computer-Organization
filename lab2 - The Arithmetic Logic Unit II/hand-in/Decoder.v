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
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
wire    [3-1:0] ALU_op_o;
wire            ALUSrc_o;
wire            RegWrite_o;
wire            RegDst_o;
wire            Branch_o;

//Parameter


//Main function
assign ALUSrc_o = (instr_op_i==6'd0)?1'b0:
			(instr_op_i==6'd4)?1'b0:
			(instr_op_i==6'd5)?1'b0:1'b1;
assign RegWrite_o = 1'b1;
assign ALU_op_o = (instr_op_i==6'd0)?3'b001:		//ADD, SUB, AND, OR, SLT, SLL, SRLV
			(instr_op_i==6'd8)?3'b010:	//ADDI
			(instr_op_i==6'd10)?3'b011:	//SLTI
			(instr_op_i==6'd4)?3'b100:	//BEQ
			(instr_op_i==6'd15)?3'b101:	//LUI
			(instr_op_i==6'd13)?3'b110:	//ORI
			(instr_op_i==6'd5)?3'b111:0;	//BNE

assign RegDst_o = (instr_op_i==6'd0)?1'b1:1'b0;
assign Branch_o = (instr_op_i==6'd4)?1'b1:(instr_op_i==6'd5)?1'b1:1'b0;

endmodule





                    
                    