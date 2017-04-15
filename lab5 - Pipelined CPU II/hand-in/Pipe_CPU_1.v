//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
        clk_i,
		rst_n
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_n;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
wire [31:0] next_pc;
wire [31:0] pc_to_im_adder;
wire [31:0] im_to_IF;
wire [31:0] pc_4;
wire [63:0] IF_ID_i;
wire [63:0] IF_ID_o;

/**** ID stage ****/
wire [31:0]  Rdata1;
wire [31:0]  Rdata2;
wire [31:0]  Sign_Ex;
wire [154-1:0] ID_EX_i;
wire [154-1:0] ID_EX_o;
wire IF_ID_write, PC_keep, IF_flush, ID_flush, EX_flush;

//control signal
wire 	   RegWrite;
wire [3:0] ALUOp;
wire 	   ALUSrc;
wire 	   RegDst;
wire 	   Branch;
wire [1:0] BranchType;
wire 	   Jump;
wire 	   MemRead;
wire 	   MemWrite;
wire 	   MemtoReg;

/**** EX stage ****/
wire [31:0]  add_result;
wire [31:0]  ALU_src2;
wire [3:0]   ALU_ctrl;
wire [31:0]  ALU_result;
wire [31:0]  shift;
wire		 zero;
wire [4:0]   Dst;
wire [106:0] EX_MEM_i;
wire [106:0] EX_MEM_o;

//control signal


/**** MEM stage ****/
wire [31:0] ReadData;
wire [70:0] MEM_WB_i;
wire [70:0] MEM_WB_o;

//control signal
wire PCSrc;

/**** WB stage ****/
wire [31:0] WriteData;

//control signal


/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
ProgramCounter PC( .clk_i(clk_i),
				   .rst_i(rst_n),
				   .pc_in_i(next_pc),
				   .keep_i(PC_keep),
				   .pc_out_o(pc_to_im_adder) );

Instruction_Memory IM( .addr_i(pc_to_im_adder),
				 .instr_o(im_to_IF) );
			
Adder Add_pc( .src1_i(pc_to_im_adder),
			  .src2_i(32'd4),
			  .sum_o(pc_4) );

MUX_2to1 #(.size(32)) Mux_pc( .data0_i(pc_4),
							  .data1_i(EX_MEM_o[101:70]),
							  .select_i(PCSrc),
							  .data_o(next_pc) );

assign IF_ID_i = { pc_4, im_to_IF };
wire IF_ID_flush;
IF_pipe_reg #(.size(65)) IF_ID( .rst_i(rst_n),
							 .clk_i(clk_i),
							 .data_i({IF_ID_i, IF_flush}),
							 .keep_i(IF_ID_write),
							 .data_o({IF_ID_o, IF_ID_flush}) );     // N is the total length of input/output

							 
		
//Instantiate the components in ID stage

//add
Hazard_detection_unit HDU(
	.ID_rs(IF_ID_o[25:21]),
	.ID_rt(IF_ID_o[20:16]),
	.EX_rt(ID_EX_o[9:5]),
	.EX_MemRead(ID_EX_o[150]),
	.branch(PCSrc),
	.IF_ID_o(IF_ID_write),
	.Pc_Write_o(PC_keep),
	.IF_flush(IF_flush),
	.ID_flush(ID_flush),
	.EX_flush(EX_flush));

//add



Reg_File RF( .clk_i(clk_i),
			 .rst_n(rst_n),
			 .RegWrite_i(MEM_WB_o[70]),
			 .RSaddr_i(IF_ID_o[25:21]),
			 .RTaddr_i(IF_ID_o[20:16]),
			 .RDaddr_i(MEM_WB_o[4:0]),
			 .RDdata_i(WriteData),
			 .RSdata_o(Rdata1),
			 .RTdata_o(Rdata2) );    

Decoder Control( .rst_n(rst_n), 
			.instr_op_i(IF_ID_o[31:26]),
				 .funct_i(IF_ID_o[5:0]),
				 .flush1_i(IF_ID_flush),
				 .flush2_i(ID_flush),
				 .RegWrite_o(RegWrite),
				 .ALU_op_o(ALUOp),   
				 .ALUSrc_o(ALUSrc),   
				 .RegDst_o(RegDst),   
				 .Branch_o(Branch),
				 .BranchType_o(BranchType),
				 .Jump_o(Jump),
				 .MemRead_o(MemRead),
				 .MemWrite_o(MemWrite),
				 .MemtoReg(MemtoReg) );

Sign_Extend Sign_Extend( .data_i(IF_ID_o[15:0]),
						 .data_o(Sign_Ex) );

wire [5:0] ID_funct;
wire [1:0] EX_BranchType;
//                     ┌   WB   ┐          ┌       MEM       ┐        ┌      EX      ┐
//                  [153]      [152]    [151]    [150]     [149]   [148] [147:144] [143]
assign ID_EX_i = { RegWrite, MemtoReg, Branch, MemRead, MemWrite, RegDst, ALUOp, ALUSrc,
//                                 [142:111]pc+4   [110:79] [78:47]  [46:15]   rs[14;10]      rt[9:5]            rd[4:0]
				   IF_ID_o[63:32], Rdata1, Rdata2, Sign_Ex, IF_ID_o[25:21], IF_ID_o[20:16], IF_ID_o[15:11] };
Pipe_Reg #(.size(162)) ID_EX( .rst_i(rst_n),
						      .clk_i(clk_i),
						      .data_i({ID_EX_i, IF_ID_o[5:0], BranchType}),
						      .data_o({ID_EX_o, ID_funct, EX_BranchType}) );
		
		
		
//Instantiate the components in EX stage	

//add
wire [1:0] A_forward;
wire [1:0] B_forward;
wire [32-1:0] ALU_Asrc;
wire [32-1:0] ALU_Bsrc;
Forwarding_unit FU(.MEM_rd(EX_MEM_o[4:0]),
		.WB_rd(MEM_WB_o[4:0]),
		.EX_rs(ID_EX_o[14:10]),
		.EX_rt(ID_EX_o[9:5]),
		.MEM_RegWrite(EX_MEM_o[106]),
		.WB_RegWrite(MEM_WB_o[70]),
		.A_o(A_forward),
		.B_o(B_forward) );
//add
   
MUX_3to1  #(.size(32)) MUX_A( .data0_i(ID_EX_o[110:79]), 
				.data1_i(EX_MEM_o[68:37]), 
				.data2_i(WriteData), 
				.select_i(A_forward), 
				.data_o(ALU_Asrc));

MUX_3to1 #(.size(32)) MUX_B ( .data0_i(ID_EX_o[78:47]), 
				.data1_i(EX_MEM_o[68:37]), 
				.data2_i(WriteData), 
				.select_i(B_forward), 
				.data_o(ALU_Bsrc));



Shift_Left_Two_32 Shift_Left_Two_32( .data_i(ID_EX_o[46:15]),
									 .data_o(shift) );

Adder Add2( .src1_i(ID_EX_o[142:111]),
			.src2_i(shift),
			.sum_o(add_result) );

ALU ALU( .src1_i(ALU_Asrc),
		 .src2_i(ALU_src2),
		 .ctrl_i(ALU_ctrl),
		 .result_o(ALU_result),
		 .zero_o(zero) );
		
ALU_Ctrl ALU_Control( .funct_i(ID_funct),
					  .ALUOp_i(ID_EX_o[147:144]),
					  .ALUCtrl_o(ALU_ctrl) );

MUX_2to1 #(.size(32)) Mux1( .data0_i(ALU_Bsrc),
							.data1_i(ID_EX_o[46:15]),
							.select_i(ID_EX_o[143]),
							.data_o(ALU_src2) );
		
MUX_2to1 #(.size(5)) Mux2( .data0_i(ID_EX_o[9:5]),
						   .data1_i(ID_EX_o[4:0]),
						   .select_i(ID_EX_o[148]),
						   .data_o(Dst) );


wire [1:0] MEM_BranchType;

//                    RegWrite       MemtoReg      Branch         MemRead      MemWrite
//                     [106]           [105]       [104]           [103]        [102]
assign EX_MEM_i = { ID_EX_o[153], ID_EX_o[152], ID_EX_o[151], ID_EX_o[150], ID_EX_o[149],
//					 [101:70]   [69]    [68:37]       [36:5]     [4:0] 
					add_result, zero, ALU_result, ID_EX_o[78:47], Dst };
Pipe_Reg #(.size(109)) EX_MEM( .rst_i(rst_n),
						       .clk_i(clk_i),
						       .data_i({EX_MEM_i, EX_BranchType}),
						       .data_o({EX_MEM_o, MEM_BranchType}) );
			   
			   
			   
//Instantiate the components in MEM stage

//add
wire B_select;
MUX_4to1 #(.size(1)) Branch_MUX(
		.data0_i(zero),
		.data1_i(~(zero|ALU_result[31])),
		.data2_i(~ALU_result[31]),
		.data3_i(~zero),
		.select_i(MEM_BranchType),
		.data_o(B_select)
		);

//add


assign PCSrc = EX_MEM_o[104] & B_select;

Data_Memory DM( .clk_i(clk_i),
				.addr_i(EX_MEM_o[68:37]),
				.data_i(EX_MEM_o[36:5]),
				.MemRead_i(EX_MEM_o[103]),
				.MemWrite_i(EX_MEM_o[102]),
				.data_o(ReadData) );
				
//                    RegWrite          MemtoReg 
//                      [70]             [69]
assign MEM_WB_i = { EX_MEM_o[106], EX_MEM_o[105],
//					 [68:37]       [36:5]           [4:0]
					ReadData, EX_MEM_o[68:37], EX_MEM_o[4:0]};
Pipe_Reg #(.size(71)) MEM_WB( .rst_i(rst_n),
						      .clk_i(clk_i),
						      .data_i(MEM_WB_i),
						      .data_o(MEM_WB_o) );
        


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3( .data0_i(MEM_WB_o[68:37]),
							.data1_i(MEM_WB_o[36:5]),
							.select_i(MEM_WB_o[69]),
							.data_o(WriteData) );


/****************************************
signal assignment
****************************************/	
endmodule

