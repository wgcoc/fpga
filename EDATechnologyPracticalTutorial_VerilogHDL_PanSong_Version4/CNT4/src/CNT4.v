//4位二进制计数器：随着时钟的不断出现，从0000到1111循环输出技术值
//纯组合电路（完成累加） + 纯时序电路
module CNT4(CLK,Q); //最简单的4位二进制加法计数器
	input CLK;
	output [3:0] Q;
	//定义一个内部4位寄存节点
	//为便于累加，需定义一个内部寄存器变量Q1，具备输入和输出特性
	reg [3:1] Q1;
	always @(posedge CLK)
	begin 
	Q1 <= Q1 + 1; //CLK有上跳沿时，Q1累加1，否则保持
	end 
	assign Q = Q1; //将Q1数据向端口Q输出
endmodule 
