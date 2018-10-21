//电平触发型锁存器及其Verilog表述
//锁存器
module LATCH1(CLK,D,Q);
	input CLK,D;
	output Q;
	reg Q;
	always @(D or CLK)
		if(CLK) Q <= D; //使用不完整条件语句
endmodule 