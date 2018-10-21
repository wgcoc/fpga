//半加器描述：直接用符号描述
module h_adder_v2(a,b,so,co);
	input a,b;
	output so,co;
	//两位二进制数直接相加，进位进入并位后的co
	assign {co,so} = a + b;
endmodule 