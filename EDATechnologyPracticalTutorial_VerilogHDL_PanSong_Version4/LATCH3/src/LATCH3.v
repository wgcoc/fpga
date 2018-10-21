//使用的是含有并行语句特色的连续赋值语句，其中使用了条件操作符
module LATCH3(CLK,D,Q,RST);
	input CLK,D,RST;
	output Q;
	assign Q = (!RST)? 0:(CLK? D:Q);
endmodule 