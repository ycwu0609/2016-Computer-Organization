//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
wire        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
assign ALUCtrl_o = (ALUOp_i==4'b0001)? (
						 (funct_i==6'd32)? 4'd2:  //ADD
						 (funct_i==6'd34)? 4'd3:  //SUB
						 (funct_i==6'd36)? 4'd0:  //AND
						 (funct_i==6'd37)? 4'd1:  //OR
					     	(funct_i==6'd42)? 4'd4:  //SLT
					 	 (funct_i==6'd0)? 4'd5:  //SLL
						(funct_i==6'd6)?4'd6:	//SRLV
						  (funct_i==6'b011000)?4'd11:4'd12):  
		   (ALUOp_i==4'b0010)? 4'd2:		//ADDI
		   (ALUOp_i==4'b0011)?4'd4:		//SLTI
		   (ALUOp_i==4'b0100)?4'd7:		//BEQ
		   (ALUOp_i==4'b0101)?4'd8:		//LUI
		   (ALUOp_i==4'b0110)?4'b1001:		//ORI
		   (ALUOp_i==4'b0111)?4'd10:		//BNE
		(ALUOp_i==4'b1000)?4'd2:
		(ALUOp_i==4'b1001)?4'd2:
		(ALUOp_i==4'b1010)?4'b1100 :
		(ALUOp_i==4'b1011)?4'b1101 :
		   4'd12;	



endmodule     





                    
                    