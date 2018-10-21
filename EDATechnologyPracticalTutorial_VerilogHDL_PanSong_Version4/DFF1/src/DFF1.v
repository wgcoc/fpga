//边沿触发型触发器及其Verilog表述
//D触发器的一种经典描述
module DFF1(CLK,D,Q);
	output Q;
	input CLK,D;
	reg Q;
	/*1.CLK上升沿启动，与posedge CLK对应的还有negsedge CLK是时钟下降沿敏感的表述
	  2.在过程语句敏感信号表中的逻辑表述：posedge CLK，可以看成是对时钟信号CLK的
	    上升沿敏感的敏感变量或敏感表述
	  3.Verilog对于时序模块的描述特点，即凡是边沿触发性质的时序元件必须使用时钟边沿
	    敏感表述，而不用此表述产生的时序电路都是电平敏感性的时序电路
	*/
	always @( posedge CLK )
		Q <= D;	//当CLK有上升沿时D被锁入Q
endmodule 