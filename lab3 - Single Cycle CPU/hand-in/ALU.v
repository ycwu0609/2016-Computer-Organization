//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	shamt_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;
input  [32-1:0] shamt_i;

output [32-1:0]	 result_o;
output           zero_o;


//Internal signals
reg    [32-1:0]  result_o;
reg             zero_o;

//Parameter

//Main function
always@(*)begin

	case(ctrl_i)
		4'b0000:begin			//and
		 result_o = src1_i & src2_i;
		 zero_o=0;
		end

		4'b0001:begin			//or
		 result_o = src1_i | src2_i;
		 zero_o=0;
		end

		4'b0010:begin			//add
		 result_o = src1_i + src2_i;
		 zero_o=0;
		end

		4'b0011:begin			//sub
		 result_o = src1_i - src2_i;
		
		 zero_o=0;
		end

		4'b0100:begin			//slt, slti
		 if(src1_i<src2_i) result_o=1;
		 else result_o=0;
		 zero_o=0;
		end

		4'b0101:begin			//sll,
		 result_o = src2_i<<shamt_i;
		 zero_o=0;     
		end
		
		4'b0110:begin			//srlv
		 result_o = src1_i>>src2_i;
		 zero_o=0;
		end

		4'b0111:begin			//BEQ
		 if(src1_i==src2_i) zero_o<=1;
		 else zero_o<=0;
		end

		4'b1000:begin			//LUI
		 result_o={src2_i[15:0],16'b0000000000000000};
		 zero_o=0;
		end

		4'b1001:begin			//BGT
		 if(src1_i>src2_i)zero_o<=1;
		 else zero_o<=0;
		end

		4'b1010:begin			//BNE
		 if(src1_i!=src2_i) zero_o<=1;
		 else zero_o<=0;
		// result_o=src1_i-src2_i;
		end
		
		4'b1011:begin
		 result_o = src1_i*src2_i;
		end		
		
		4'b1100:begin
		 if(src1_i!=0) zero_o<=1;
		 zero_o<=0;
		end

		4'b1101:begin
		 if(src1_i>=0) zero_o<=1;
		 zero_o<=0;
		end

		default: ;
	endcase




end

endmodule




                    
                    