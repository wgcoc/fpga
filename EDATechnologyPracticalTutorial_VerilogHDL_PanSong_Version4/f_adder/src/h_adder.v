//半加器描述：利用布尔函数描述方法
module h_adder(a,b,so,co);
	input a,b;
	output so,co;
	assign so = a ^ b;
	assign co = a & b;
endmodule 