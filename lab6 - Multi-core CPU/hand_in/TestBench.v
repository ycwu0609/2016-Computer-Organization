//Subject:     CO project 4 - Test Bench
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns / 1ps
`define CYCLE_TIME 10			

module TestBench;

//Internal Signals
reg         CLK;
reg         RST;
//reg [31:0] mem [0:31];
wire 	[31:0]			addr_i_1;
wire 	[31:0]			addr_i_2;
wire 	[31:0]			data_i_1;
wire 	[31:0]			data_i_2;
wire				MemRead_i_1;
wire				MemRead_i_2;
wire				MemWrite_i_1;
wire				MemWrite_i_2;
wire	[31:0] 		data_o_1;
wire	[31:0] 		data_o_2;
integer     count;
integer     i;
integer     handle;




//Greate tested modle  
Pipe_CPU_1 cpu1(
        .clk_i(CLK),
	    .rst_n(RST),
	.addr_i(addr_i_1),
	.data_i(data_i_1),
	.MemRead_i(MemRead_i_1),
	.MemWrite_i(MemWrite_i_1),
	.data_o(data_o_1)
		);
 

Pipe_CPU_1 cpu2(
        .clk_i(CLK),
	    .rst_n(RST),
	.addr_i(addr_i_2),
	.data_i(data_i_2),
	.MemRead_i(MemRead_i_2),
	.MemWrite_i(MemWrite_i_2),
	.data_o(data_o_2)
		);



Data_Memory Share_Data_Memory(
	.clk_i(CLK),
	.addr_i_1(addr_i_1),
	.addr_i_2(addr_i_2),
	.data_i_1(data_i_1),
	.data_i_2(data_i_2),
	.MemRead_i_1(MemRead_i_1),
	.MemRead_i_2(MemRead_i_2),
	.MemWrite_i_1(MemWrite_i_1),
	.MemWrite_i_2(MemWrite_i_2),
	.data_o_1(data_o_1),
	.data_o_2(data_o_2)
);

//Main function

always #(`CYCLE_TIME/2) CLK = ~CLK;	

initial  begin
$readmemb("LAB6_machine_1.txt", cpu1.IM.Instr_Mem);
$readmemb("LAB6_machine_2.txt", cpu2.IM.Instr_Mem);
    
	CLK = 0;
	RST = 0;
	count = 0;
	//memory = 0;


    
    #(`CYCLE_TIME)      RST = 1;
    #(`CYCLE_TIME*60)      $stop;

end


always@(posedge CLK) begin
    count = count + 1;
	if( count ==  1 ) begin
			$display("\nInitial Memory===========================================================\n");
	$display("m0=%d, m1=%d, m2=%d, m3=%d, m4=%d, m5=%d, m6=%d, m7=%d\n\nm8=%d, m9=%d, m10=%d, m11=%d, m12=%d, m13=%d, m14=%d, m15=%d\n\nm16=%d, m17=%d, m18=%d, m19=%d, m20=%d, m21=%d, m22=%d, m23=%d\n\nm24=%d, m25=%d, m26=%d, m27=%d, m28=%d, m29=%d, m30=%d, m31=%d",							 
	          Share_Data_Memory.mem[0], Share_Data_Memory.mem[1], Share_Data_Memory.mem[2], Share_Data_Memory.mem[3],
				 Share_Data_Memory.mem[4], Share_Data_Memory.mem[5], Share_Data_Memory.mem[6], Share_Data_Memory.mem[7],
				 Share_Data_Memory.mem[8], Share_Data_Memory.mem[9], Share_Data_Memory.mem[10], Share_Data_Memory.mem[11],
				 Share_Data_Memory.mem[12], Share_Data_Memory.mem[13], Share_Data_Memory.mem[14], Share_Data_Memory.mem[15],
				 Share_Data_Memory.mem[16], Share_Data_Memory.mem[17], Share_Data_Memory.mem[18], Share_Data_Memory.mem[19],
				 Share_Data_Memory.mem[20], Share_Data_Memory.mem[21], Share_Data_Memory.mem[22], Share_Data_Memory.mem[23],
				 Share_Data_Memory.mem[24], Share_Data_Memory.mem[25], Share_Data_Memory.mem[26], Share_Data_Memory.mem[27],
				 Share_Data_Memory.mem[28], Share_Data_Memory.mem[29], Share_Data_Memory.mem[30], Share_Data_Memory.mem[31]
			  );
	end
	if( count == 50 ) begin 
	//print result to transcript 
	
$display("Core1 Register===========================================================\n");
	$display("r0=%d, r1=%d, r2=%d, r3=%d, r4=%d, r5=%d, r6=%d, r7=%d\n",
	cpu1.RF.Reg_File[0], cpu1.RF.Reg_File[1], cpu1.RF.Reg_File[2], cpu1.RF.Reg_File[3], cpu1.RF.Reg_File[4], 
	cpu1.RF.Reg_File[5], cpu1.RF.Reg_File[6], cpu1.RF.Reg_File[7],
	);
	$display("r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d, r15=%d\n",
	cpu1.RF.Reg_File[8], cpu1.RF.Reg_File[9], cpu1.RF.Reg_File[10], cpu1.RF.Reg_File[11], cpu1.RF.Reg_File[12], 
	cpu1.RF.Reg_File[13], cpu1.RF.Reg_File[14], cpu1.RF.Reg_File[15],
	);
	$display("r16=%d, r17=%d, r18=%d, r19=%d, r20=%d, r21=%d, r22=%d, r23=%d\n",
	cpu1.RF.Reg_File[16], cpu1.RF.Reg_File[17], cpu1.RF.Reg_File[18], cpu1.RF.Reg_File[19], cpu1.RF.Reg_File[20], 
	cpu1.RF.Reg_File[21], cpu1.RF.Reg_File[22], cpu1.RF.Reg_File[23],
	);
	$display("r24=%d, r25=%d, r26=%d, r27=%d, r28=%d, r29=%d, r30=%d, r31=%d\n",
	cpu1.RF.Reg_File[24], cpu1.RF.Reg_File[25], cpu1.RF.Reg_File[26], cpu1.RF.Reg_File[27], cpu1.RF.Reg_File[28], 
	cpu1.RF.Reg_File[29], cpu1.RF.Reg_File[30], cpu1.RF.Reg_File[31],
	);

$display("Core2 Register===========================================================\n");
	$display("r0=%d, r1=%d, r2=%d, r3=%d, r4=%d, r5=%d, r6=%d, r7=%d\n",
	cpu2.RF.Reg_File[0], cpu2.RF.Reg_File[1], cpu2.RF.Reg_File[2], cpu2.RF.Reg_File[3], cpu2.RF.Reg_File[4], 
	cpu2.RF.Reg_File[5], cpu2.RF.Reg_File[6], cpu2.RF.Reg_File[7],
	);
	$display("r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d, r15=%d\n",
	cpu2.RF.Reg_File[8], cpu2.RF.Reg_File[9], cpu2.RF.Reg_File[10], cpu2.RF.Reg_File[11], cpu2.RF.Reg_File[12], 
	cpu2.RF.Reg_File[13], cpu2.RF.Reg_File[14], cpu2.RF.Reg_File[15],
	);
	$display("r16=%d, r17=%d, r18=%d, r19=%d, r20=%d, r21=%d, r22=%d, r23=%d\n",
	cpu2.RF.Reg_File[16], cpu2.RF.Reg_File[17], cpu2.RF.Reg_File[18], cpu2.RF.Reg_File[19], cpu2.RF.Reg_File[20], 
	cpu2.RF.Reg_File[21], cpu2.RF.Reg_File[22], cpu2.RF.Reg_File[23],
	);
	$display("r24=%d, r25=%d, r26=%d, r27=%d, r28=%d, r29=%d, r30=%d, r31=%d\n",
	cpu2.RF.Reg_File[24], cpu2.RF.Reg_File[25], cpu2.RF.Reg_File[26], cpu2.RF.Reg_File[27], cpu2.RF.Reg_File[28], 
	cpu2.RF.Reg_File[29], cpu2.RF.Reg_File[30], cpu2.RF.Reg_File[31],
	);


	$display("\nMemory===========================================================\n");
	$display("m0=%d, m1=%d, m2=%d, m3=%d, m4=%d, m5=%d, m6=%d, m7=%d\n\nm8=%d, m9=%d, m10=%d, m11=%d, m12=%d, m13=%d, m14=%d, m15=%d\n\nm16=%d, m17=%d, m18=%d, m19=%d, m20=%d, m21=%d, m22=%d, m23=%d\n\nm24=%d, m25=%d, m26=%d, m27=%d, m28=%d, m29=%d, m30=%d, m31=%d",							 
	          Share_Data_Memory.mem[0], Share_Data_Memory.mem[1], Share_Data_Memory.mem[2], Share_Data_Memory.mem[3],
				 Share_Data_Memory.mem[4], Share_Data_Memory.mem[5], Share_Data_Memory.mem[6], Share_Data_Memory.mem[7],
				 Share_Data_Memory.mem[8], Share_Data_Memory.mem[9], Share_Data_Memory.mem[10], Share_Data_Memory.mem[11],
				 Share_Data_Memory.mem[12], Share_Data_Memory.mem[13], Share_Data_Memory.mem[14], Share_Data_Memory.mem[15],
				 Share_Data_Memory.mem[16], Share_Data_Memory.mem[17], Share_Data_Memory.mem[18], Share_Data_Memory.mem[19],
				 Share_Data_Memory.mem[20], Share_Data_Memory.mem[21], Share_Data_Memory.mem[22], Share_Data_Memory.mem[23],
				 Share_Data_Memory.mem[24], Share_Data_Memory.mem[25], Share_Data_Memory.mem[26], Share_Data_Memory.mem[27],
				 Share_Data_Memory.mem[28], Share_Data_Memory.mem[29], Share_Data_Memory.mem[30], Share_Data_Memory.mem[31]
			  );
	//$display("\nPC=%d\n",cpu.PC.pc_i);
	end
	//else ;
end
  
endmodule


