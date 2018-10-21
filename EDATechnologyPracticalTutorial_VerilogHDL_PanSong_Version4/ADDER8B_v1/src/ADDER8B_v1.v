module ADDER8B_v1(A,B,CIN,COUT,DOUT);
	input [7:0] A,B;
	input CIN;
	output [7:0] DOUT;
	output COUT;
	//加操作的进位进入并位COUT
	assign {COUT,DOUT} = A + B + CIN;
endmodule 