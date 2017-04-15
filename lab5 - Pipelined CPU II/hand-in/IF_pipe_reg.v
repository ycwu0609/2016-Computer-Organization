module IF_pipe_reg(
		rst_i,
		clk_i,   
		data_i,
		keep_i,
		data_o
    );

         
					
parameter size = 0;
input                    rst_i;
input                    clk_i;		  
input      [size-1: 0] data_i;
input      keep_i;
output     [size-1: 0] data_o;

wire [size-1: 0] data_o;

assign data_o = (!rst_i) ? 0 :
		(keep_i) ? data_o: data_i;

endmodule
