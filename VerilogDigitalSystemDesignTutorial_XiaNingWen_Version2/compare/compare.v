module compare( equal,a,b );
	output equal; //声明输出信号equal
	input [1:0] a,b; //声明输入信号a,b
		assign equal = (a==b)? 1:0;
	//如果a,b两个输入信号相等，输出为1；否则为0
endmodule 
