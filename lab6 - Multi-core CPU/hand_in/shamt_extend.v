module Shamt_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [6-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
wire     [32-1:0] data_o;

//Sign extended
assign data_o = data_i[5]? {27'b111111111111111111111111111,data_i}:{27'b000000000000000000000000000,data_i};   
endmodule      
     