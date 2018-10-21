module ADDER8B(A,B,CIN,COUT,DOUT);
	input [7:0] A,B;
	input CIN;
	output [7:0] DOUT;
	output COUT;
	wire [8:0] DATA;
	//加操作的进位自动进入DATA[8]
	assign DATA = A + B + CIN;
	assign COUT = DATA[8];
	assign DOUT = DATA[7:0];
endmodule 