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
		rst_n
		);
		
//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [31:0] c_pc,n_pc, n_pc1, n_pc2, n_pc3, instr,Rdata1,Rdata2,
			Sign_Extend, Sign_Extend_c, Rdata2_c,
			ALU_result, jump_c, shamt_extend;
wire		RegDst,RegWrite,ALUSrc,zero, Branch, Branch_c;
wire [1:0]	BranchType_o, MemtoReg_o;
wire		Jump_o, MemRead_o, MemWrite_o;
wire [27:0]jump_tmp;
wire [4-1:0] ALUOp;
wire [4:0] Dst;
wire [4-1:0] ALU_op;
wire [31:0] ReadData, WriteData;
wire [5:0] shamt;

assign shamt = instr[10:6];
assign Branch_c = Branch & zero;	
assign jump_tmp =instr[25:0]<<2;
assign jump_c={n_pc1[31:28],jump_tmp[27:0]};
//Greate componentes
ProgramCounter PC(			//PC
        .clk_i(clk_i),      
	    .rst_i (rst_n),     
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
	    .rst_i(rst_n) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(Dst) ,  
        .RDdata_i(WriteData)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(Rdata1) ,  
        .RTdata_o(Rdata2)   
        );
	
Decoder Decoder(			//Control decoder
        .instr_op_i(instr[31:26]), 
	.funct_i(instr[5:0]),
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch),
	.BranchType_o(BranchType_o),
	.Jump_o(Jump_o),
	.MemRead_o(MemRead_o),
	.MemWrite_o(MemWrite_o),
	.MemtoReg(MemtoReg_o)
	    );

ALU_Ctrl AC(				
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALU_op) 
        );

Shamt_Extend ShamtE(
	.data_i(shamt),
	.data_o(shamt_extend)
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
	    .shamt_i(shamt_extend),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(n_pc1),     
	    .src2_i(Sign_Extend_c),     
	    .sum_o(n_pc2)      
	    );


Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(ALU_result),
	.data_i(Rdata2),
	.MemRead_i(MemRead_o),
	.MemWrite_i(MemWrite_o),
	.data_o(ReadData)
);

Mux3to1 Mux_Writedata(
	.data0_i(ALU_result),
	.data1_i(ReadData),
	.data2_i(Sign_Extend),
	.select_i(MemtoReg_o),
	.data_o(WriteData)
);
		
Shift_Left_Two_32 Shifter2(
        .data_i(Sign_Extend),
        .data_o(Sign_Extend_c)
        ); 		
	
MUX_2to1 #(.size(32)) Mux_PC_Source1(	//Choose PC_in_calculation
        .data0_i(n_pc1),
        .data1_i(n_pc2),
        .select_i(Branch_c),
        .data_o(n_pc3)
        );	

MUX_2to1 #(.size(32)) Mux_PC_Source2(	//Choose final_PC
        .data0_i(n_pc3),
	.data1_i(jump_c),
        .select_i(Jump_o),
        .data_o(n_pc)
        );	

endmodule
		  


