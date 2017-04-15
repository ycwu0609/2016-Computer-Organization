
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:23 05/30/2016 
// Design Name: 
// Module Name:    Hazrd_detection_unit 
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
module Hazard_detection_unit(
	ID_rs,
	ID_rt,
	EX_rt,
	EX_MemRead,
	branch,
	IF_ID_o,
	Pc_Write_o,
	IF_flush,
	ID_flush,
	EX_flush
	 );

//I/O ports  
input [5-1:0]ID_rs;
input [5-1:0]ID_rt;
input [5-1:0]EX_rt;
input EX_MemRead;
input branch;
output IF_ID_o;
output Pc_Write_o;
output IF_flush;
output ID_flush;
output EX_flush;

//Internal Signals
wire IF_ID_o;
wire Pc_Write_o;
wire IF_flush;
wire ID_flush;
wire EX_flush;


//Main function

assign IF_ID_o = (EX_MemRead & ((EX_rt == ID_rs) | (EX_rt == ID_rt)))?1:0;
assign Pc_Write_o = (EX_MemRead & ((EX_rt == ID_rs) | (EX_rt == ID_rt)))?1:0;
assign IF_flush = (!(EX_MemRead & ((EX_rt == ID_rs) | (EX_rt == ID_rt))))?0:(branch)?1:0;
assign ID_flush = (EX_MemRead & ((EX_rt == ID_rs) | (EX_rt == ID_rt)))?1:(branch)?1:0;
assign EX_flush = (!(EX_MemRead & ((EX_rt == ID_rs) | (EX_rt == ID_rt))))?0:(branch)?1:0;


endmodule
