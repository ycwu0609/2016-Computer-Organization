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
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
wire        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
assign ALUCtrl_o = (ALUOp_i==3'b001)? (
						 (funct_i==6'd32)? 4'd2:  //ADD
						 (funct_i==6'd34)? 4'd3:  //SUB
						 (funct_i==6'd36)? 4'd0:  //AND
						 (funct_i==6'd37)? 4'd1:  //OR
					     	(funct_i==6'd42)? 4'd4:  //SLT
					 	 (funct_i==6'd0)? 4'd5:  //SLL
						  4'd6):  //SLLV
		   (ALUOp_i==3'b010)? 4'd2:		//ADDI
		   (ALUOp_i==3'b011)?4'd4:		//SLTI
		   (ALUOp_i==3'b100)?4'd7:		//BEQ
		   (ALUOp_i==3'b101)?4'd8:		//LUI
		   (ALUOp_i==3'b110)?4'd9:		//ORI
		   (ALUOp_i==3'b111)?4'd10:		//BNE
		   4'd11;	



endmodule     





                    
                    