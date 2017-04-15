module ALU(
	rst_n,
   src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input rst_n;
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]  result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
wire cout;
wire overflow;
reg [1:0]op;
reg [2:0]cp_ctrl;
wire [31:0]c;
reg a1, b1;
reg less_flag;
wire set;
wire equal;
wire equal_zero;
reg cmp;

assign equal = (src1_i == src2_i) ? 1 : 0;
assign equal_zero = (src1_i==0)? 1 : 0;
assign c[0] = (ctrl_i == 4'b0110) ? 1 : (ctrl_i == 4'b0111) ? 1 : 0;
assign zero = (result_o == 0) ? 1 : 0;
assign overflow = (( ctrl_i == 4'b0000)&src1_i[31]&src2_i[31]&~result_o[31]) ? 1 
			:((ctrl_i==4'b0000)&~src1_i[31]&~src2_i[31]&result_o[31]) ? 1
			:((ctrl_i==4'b0110)&src1_i[31]&~src2_i[31]&~result_o[31]) ? 1
			:((ctrl_i==4'b0110)&~src1_i[31]&src2_i[31]&result_o[31]) ? 1 : 0;


//Main function
/*your code here*/
always@(*)begin
if(rst_n==1)begin	
	cmp <= 0;

	case(ctrl_i)
		4'b0000:begin			//and
		 a1 <= 0;
		 b1 <= 0;
		 op <= 2'b00;

		end

		4'b0001:begin			//or
		 a1 <= 0;
		 b1 <= 0;
		 op <= 2'b01;
		end

		4'b0010:begin			//add
		 a1 <= 0;
		 b1 <= 0;
		 op <= 2'b10;
		end

		4'b0110:begin			//sub
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b10;
		end

		4'b1100:begin			//nor
		 a1 <= 1;
		 b1 <= 1;
		 op <= 2'b00;
		end

		4'b1101:begin			//nand
		 a1 <= 1;
		 b1 <= 1;
		 op <= 2'b01;
		end
		
		4'b0111:begin			//set less than
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b000;
		end

		4'b1000:begin			//set great than
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b001;
		end

		4'b1001:begin			//set less equal
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b010;
		end

		4'b1010:begin			//set great equal
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b011;
		end

		4'b1011:begin			//set equal
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b100;
		end
		
		4'b1110:begin			//set non equal
		 a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b101;
		end

		4'b0011:begin		//multiplication
		   multiplication(src1_i,src2_i,result_o);
		end

		4'b0100:begin			//set equal zero
		  a1 <= 0;
		 b1 <= 1;
		 op <= 2'b11;
		cmp <= 1;
		cp_ctrl <= 3'b110;
		end
		default: ;
	endcase
end
end



alu_top alu0( .a(src1_i[0]), .b(src2_i[0]), .less(set), .A_inv(a1), .B_inv(b2),.cin(c[0]), .op(op), .result(result_o[0]), .cout(c[1]) );

alu_top alu1( .a(src1_i[1]), .b(src2_i[1]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[1]), .op(op), .result(result_o[1]), .cout(c[2]) );
				  
alu_top alu2( .a(src1_i[2]), .b(src2_i[2]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[2]), .op(op), .result(result_o[2]), .cout(c[3]) );
				  
alu_top alu3( .a(src1_i[3]), .b(src2_i[3]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[3]), .op(op), .result(result_o[3]), .cout(c[4]) );
				  
alu_top alu4( .a(src1_i[4]), .b(src2_i[4]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[4]), .op(op), .result(result_o[4]), .cout(c[5]) );
				  
alu_top alu5( .a(src1_i[5]), .b(src2_i[5]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[5]), .op(op), .result(result_o[5]), .cout(c[6]) );
				  
alu_top alu6( .a(src1_i[6]), .b(src2_i[6]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[6]), .op(op), .result(result_o[6]), .cout(c[7]) );
				  
alu_top alu7( .a(src1_i[7]), .b(src2_i[7]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[7]), .op(op), .result(result_o[7]), .cout(c[8]) );
				  
alu_top alu8( .a(src1_i[8]), .b(src2_i[8]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[8]), .op(op), .result(result_o[8]), .cout(c[9]) );
				  
alu_top alu9( .a(src1_i[9]), .b(src2_i[9]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[9]), .op(op), .result(result_o[9]), .cout(c[10]) );
				  
alu_top alu10( .a(src1_i[10]), .b(src2_i[10]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[10]), .op(op), .result(result_o[10]), .cout(c[11]) );
					
alu_top alu11( .a(src1_i[11]), .b(src2_i[11]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[11]), .op(op), .result(result_o[11]), .cout(c[12]) );
					
alu_top alu12( .a(src1_i[12]), .b(src2_i[12]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[12]), .op(op), .result(result_o[12]), .cout(c[13]) );
					
alu_top alu13( .a(src1_i[13]), .b(src2_i[13]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[13]), .op(op), .result(result_o[13]), .cout(c[14]) );
					
alu_top alu14( .a(src1_i[14]), .b(src2_i[14]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[14]), .op(op), .result(result_o[14]), .cout(c[15]) );
					
alu_top alu15( .a(src1_i[15]), .b(src2_i[15]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[15]), .op(op), .result(result_o[15]), .cout(c[16]) );
					
alu_top alu16( .a(src1_i[16]), .b(src2_i[16]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[16]), .op(op), .result(result_o[16]), .cout(c[17]) );
					
alu_top alu17( .a(src1_i[17]), .b(src2_i[17]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[17]), .op(op), .result(result_o[17]), .cout(c[18]) );
					
alu_top alu18( .a(src1_i[18]), .b(src2_i[18]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[18]), .op(op), .result(result_o[18]), .cout(c[19]) );
					
alu_top alu19( .a(src1_i[19]), .b(src2_i[19]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[19]), .op(op), .result(result_o[19]), .cout(c[20]) );
					
alu_top alu20( .a(src1_i[20]), .b(src2_i[20]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[20]), .op(op), .result(result_o[20]), .cout(c[21]) );
					
alu_top alu21( .a(src1_i[21]), .b(src2_i[21]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[21]), .op(op), .result(result_o[21]), .cout(c[22]) );
					
alu_top alu22( .a(src1_i[22]), .b(src2_i[22]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[22]), .op(op), .result(result_o[22]), .cout(c[23]) );
					
alu_top alu23( .a(src1_i[23]), .b(src2_i[23]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[23]), .op(op), .result(result_o[23]), .cout(c[24]) );
					
alu_top alu24( .a(src1_i[24]), .b(src2_i[24]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[24]), .op(op), .result(result_o[24]), .cout(c[25]) );
					
alu_top alu25( .a(src1_i[25]), .b(src2_i[25]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[25]), .op(op), .result(result_o[25]), .cout(c[26]) );
					
alu_top alu26( .a(src1_i[26]), .b(src2_i[26]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[26]), .op(op), .result(result_o[26]), .cout(c[27]) );
					
alu_top alu27( .a(src1_i[27]), .b(src2_i[27]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[27]), .op(op), .result(result_o[27]), .cout(c[28]) );
					
alu_top alu28( .a(src1_i[28]), .b(src2_i[28]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[28]), .op(op), .result(result_o[28]), .cout(c[29]) );
					
alu_top alu29( .a(src1_i[29]), .b(src2_i[29]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[29]), .op(op), .result(result_o[29]), .cout(c[30]) );
					
alu_top alu30( .a(src1_i[30]), .b(src2_i[30]), .less(less_flag), .A_inv(a1), .B_inv(b2),.cin(c[30]), .op(op), .result(result_o[30]), .cout(c[31]) );

alu_bottom alu31(.a(src1_i[31]), .b(src2_i[31]), .less(less_flag), .A_inv(a1), .B_inv(b2), .cin(c[31]), .op(op), .equal(equal), .equal_zero(equal_zero), .cp(cp_crtl), .cmp(cmp),
               	.result(result_o[31]), .cout(cout));







endmodule

module multiplication(input [31:0]a, input [31:0]b, output reg [31:0]result);
 
reg [31:0]a_copy;
reg [31:0]b_copy;

 reg [5:0]cnt;
 reg [63:0] product;

initial a_copy = a;
initial b_copy = b;
always@(*)begin   
if(cnt != 32)begin
		if(b[0] == 1) product <= product + (a << 32);
			
		cnt <= cnt + 1;
		a_copy <= a_copy << 1;
		b_copy <= b_copy >> 1;
		
	end
				
   else begin
	cnt <= 0;
	result <= product[31:0];
   end
end
endmodule

module alu_top(input a, input b, input less, input A_inv,input B_inv,input cin, input [1:0]op,
                output reg result, output reg cout);

reg c1, c2;
reg flag;

always@(*)begin
flag=0;
if(flag==0)begin
	if(A_inv) c1 = ~a;	else c1 = a;
	if(B_inv) c2 = ~b;	else c2 = b;
	
	case(op)
		2'b00:begin
			result = c1 & c2;
			cout = 0;
		end
			
		2'b01:begin
			result = c1 | c2;
			cout = 0;
		end
		
		2'b10:begin
			result = c1 ^ c2 ^ cin;
			cout = (c1&c2) + (c1&cin) + (c2&cin); 
		end
		
		2'b11:begin
			result = less;
			cout = (c1&c2) + (c1&cin) + (c2&cin); 
		end
	endcase
	
	flag = 1;
	
end
else begin
	result = result;
	cout = cout;
end
end				//end always

endmodule

module alu_bottom(input a,input b,input less,input A_inv,input B_inv,input cin,input [1:0] op, input equal, input equal_zero, input [2:0]cp, input cmp,
               	output reg result, output reg cout);
reg c1, c2;
reg flag;


always@(*)begin

flag =0 ;

if(cmp == 1)begin
	result = (cp==3'b000) ? (c1 ^ c2 ^ cin) : //set less than <
		(cp==3'b001) ? ~( (c1 ^ c2 ^ cin) | equal) :	 //set great than >
		(cp==3'b010) ? ((c1 ^ c2 ^ cin) | equal) : 	//set less equal <=
		(cp==3'b011) ? (~ (c1 ^ c2 ^ cin)) :		//set great equal >=
		(cp==3'b100) ? (equal) :			//set equal ==
		(cp==3'b101) ? (~equal) :   			//set not equal !=
		(cp==3'b110) ? (equal_zero):0;
		
end
else begin

if(flag == 0)begin
	if(A_inv) c1 = ~a;	else c1 = a;
	if(B_inv) c2 = ~b;	else c2 = b;
	
	case(op)
		2'b00:begin
			result = c1 & c2;
			cout = 0;
		end
			
		2'b01:begin
			result = c1 | c2;
			cout = 0;
		end
		
		2'b10:begin
			result = c1 ^ c2 ^ cin;
			cout = (c1&c2) + (c1&cin) + (c2&cin); 
		end
		
		2'b11:begin
			result = less;
			cout = 0; 			//SLT do not have cout!
		end
	endcase
	
	flag = 1;
	
	end

else begin
	result = result;
	cout = cout;
end
	
end
end
endmodule
