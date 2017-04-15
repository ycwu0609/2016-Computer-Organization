//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] c_pc,n_pc, n_pc1, n_pc2, instr,Rdata1,Rdata2,
			Sign_Extend, Sign_Extend_c, Rdata2_c,
			ALU_result;
wire		RegDst,RegWrite,ALUSrc,zero, Branch, Branch_c;
wire [2:0] ALUOp;
wire [4:0] Dst;
wire [4-1:0] ALU_op;

assign Branch_c = Branch & zero;	

//Greate componentes
ProgramCounter PC(			//PC
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(n_pc) ,   
	    .pc_out_o(c_pc) 
	    );
	
Adder Adder1(				//PC+4
        .src1_i(c_pc),     
	    .src2_i(32'd4),     
	    .sum_o(n_pc1)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(c_pc),  
	    .instr_o(instr)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(	//Choose write reg
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(RegDst),
        .data_o(Dst)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(Dst) ,  
        .RDdata_i(ALU_result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(Rdata1) ,  
        .RTdata_o(Rdata2)   
        );
	
Decoder Decoder(			//Control decoder
        .instr_op_i(instr[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(				
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALU_op) 
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(Sign_Extend)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(	//Choose ALU src
        .data0_i(Rdata2),
        .data1_i(Sign_Extend),
        .select_i(ALUSrc),
        .data_o(Rdata2_c)
        );	
		
ALU ALU(
        .src1_i(Rdata1),
	    .src2_i(Rdata2_c),
	    .ctrl_i(ALU_op),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(n_pc1),     
	    .src2_i(Sign_Extend_c),     
	    .sum_o(n_pc2)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(Sign_Extend),
        .data_o(Sign_Extend_c)
        ); 		
	
MUX_2to1 #(.size(32)) Mux_PC_Source(	//Choose PC
        .data0_i(n_pc1),
        .data1_i(n_pc2),
        .select_i(Branch_c),
        .data_o(n_pc)
        );	

endmodule
		  


