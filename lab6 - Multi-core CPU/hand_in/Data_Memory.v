`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:32 08/18/2010 
// Design Name: 
// Module Name:    Data_Memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Data_Memory
(
	clk_i,
	addr_i_1,
	addr_i_2,
	data_i_1,
	data_i_2,
	MemRead_i_1,
	MemRead_i_2,
	MemWrite_i_1,
	MemWrite_i_2,
	//memory,
	data_o_1,
	data_o_2
);

// Interface
input				clk_i;
input 	[31:0]			addr_i_1;
input 	[31:0]			addr_i_2;
input 	[31:0]			data_i_1;
input 	[31:0]			data_i_2;
input				MemRead_i_1;
input				MemRead_i_2;
input				MemWrite_i_1;
input				MemWrite_i_2;
//input   [32*32-1:0]		memory;
output	[31:0] 		data_o_1;
output	[31:0] 		data_o_2;

// Signals
reg		[31:0]		data_o_1;
reg		[31:0]		data_o_2;

// Memory
reg		[7:0]		Mem 			[0:127];	// address: 0x00~0x80
integer				i;

// For Testbench to debug
reg    [31:0]	mem [0:31];


always@(*) begin
  mem[0] <= {Mem[3], Mem[2], Mem[1], Mem[0]};
  mem[1] <= {Mem[7], Mem[6], Mem[5], Mem[4]};
  mem[2] <= {Mem[11], Mem[10], Mem[9], Mem[8]};
  mem[3] <= {Mem[15], Mem[14], Mem[13], Mem[12]};
  mem[4] <= {Mem[19], Mem[18], Mem[17], Mem[16]};
  mem[5] <= {Mem[23], Mem[22], Mem[21], Mem[20]};
  mem[6] <= {Mem[27], Mem[26], Mem[25], Mem[24]};
  mem[7] <= {Mem[31], Mem[30], Mem[29], Mem[28]};
  mem[8] <= {Mem[35], Mem[34], Mem[33], Mem[32]};
  mem[9] <= {Mem[39], Mem[38], Mem[37], Mem[36]};
  mem[10] <= {Mem[43], Mem[42], Mem[41], Mem[40]};
  mem[11] <= {Mem[47], Mem[46], Mem[45], Mem[44]};
  mem[12] <= {Mem[51], Mem[50], Mem[49], Mem[48]};
  mem[13] <= {Mem[55], Mem[54], Mem[53], Mem[52]};
  mem[14] <= {Mem[59], Mem[58], Mem[57], Mem[56]};
  mem[15] <= {Mem[63], Mem[62], Mem[61], Mem[60]};
  mem[16] <= {Mem[67], Mem[66], Mem[65], Mem[64]};
  mem[17] <= {Mem[71], Mem[70], Mem[69], Mem[68]};
  mem[18] <= {Mem[75], Mem[74], Mem[73], Mem[72]};
  mem[19] <= {Mem[79], Mem[78], Mem[77], Mem[76]};
  mem[20] <= {Mem[83], Mem[82], Mem[81], Mem[80]};
  mem[21] <= {Mem[87], Mem[86], Mem[85], Mem[84]};
  mem[22] <= {Mem[91], Mem[90], Mem[89], Mem[88]};
  mem[23] <= {Mem[95], Mem[94], Mem[93], Mem[92]};
  mem[24] <= {Mem[99], Mem[98], Mem[97], Mem[96]};
  mem[25] <= {Mem[103], Mem[102], Mem[101], Mem[100]};
  mem[26] <= {Mem[107], Mem[106], Mem[105], Mem[104]};
  mem[27] <= {Mem[111], Mem[110], Mem[109], Mem[108]};
  mem[28] <= {Mem[115], Mem[114], Mem[113], Mem[112]};
  mem[29] <= {Mem[119], Mem[118], Mem[117], Mem[116]};
  mem[30] <= {Mem[123], Mem[122], Mem[121], Mem[120]};
  mem[31] <= {Mem[127], Mem[126], Mem[125], Mem[124]};
end

initial begin
	for(i=0; i<128; i=i+1)
		//Mem[i] = 8'b0;
	/*initial your data memory here*/
	//matrix 1

	mem[0] <= 32'd1;
	mem[1] <= 32'd3;
	mem[2] <= -32'd100;
	mem[3] <= 32'd2;
	mem[4] <= -32'd2;
	mem[5] <= 32'd10;
	mem[6] <= 32'd3;
	mem[7] <= 32'd1;
	mem[8] <= 32'd0;
	//matrix 2
	mem[9] <= 32'd3;
	mem[10] <= 32'd4;
	mem[11] <= -32'd2;
	mem[12] <= 32'd5;
	mem[13] <= -32'd1;
	mem[14] <= 32'd6;
	
	mem[15] <= 0;
	mem[16] <= 0;
	mem[17] <= 0;
	mem[18] <= 0;
	mem[19] <= 0;
	mem[20] <= 0;
	mem[21] <= 0;
	mem[22] <= 0;
	mem[23] <= 0;
	mem[24] <= 0;
	mem[25] <= 0;
	mem[26] <= 0;
	mem[27] <= 0;
	mem[28] <= 0;
	mem[29] <= 0;
	mem[30] <= 0;
	mem[31] <= 0;

end 

always@(posedge clk_i) begin
    if(MemWrite_i_1) begin
		mem[addr_i_1/4] <= data_i_1;
	/*
		Mem[addr_i_1+3] <= data_i_1[31:24];
		Mem[addr_i_1+2] <= data_i_1[23:16];
		Mem[addr_i_1+1] <= data_i_1[15:8];
		Mem[addr_i_1]   <= data_i_1[7:0];
	*/
	end
    if(MemWrite_i_2) begin
		mem[addr_i_2/4] <= data_i_2;
	/*  Mem[addr_i_2+3] <= data_i_2[31:24];
		Mem[addr_i_2+2] <= data_i_2[23:16];
		Mem[addr_i_2+1] <= data_i_2[15:8];
		Mem[addr_i_2]   <= data_i_2[7:0];
    */
	end
end

always@(MemRead_i_1) begin
	if(MemRead_i_1)
		//data_o_1 = {Mem[addr_i_1+3], Mem[addr_i_1+2], Mem[addr_i_1+1], Mem[addr_i_1]};
		data_o_1 = mem[addr_i_1/4];
end

always@(MemRead_i_2) begin
	if(MemRead_i_2)
		//data_o_2 = {Mem[addr_i_2+3], Mem[addr_i_2+2], Mem[addr_i_2+1], Mem[addr_i_2]};
		data_o_2 = mem[addr_i_2/4];
end

endmodule

