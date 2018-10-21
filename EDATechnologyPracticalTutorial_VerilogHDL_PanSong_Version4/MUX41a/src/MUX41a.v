module MUX41a(a,b,c,d,s1,s0,y);
	//端口信号默认wire类型（即，网线Net类型）
	input a,b,c,d;
	input s1,s0;
	output y;
	
	//被赋值信号y在过程语句always@引导的顺序语句中规定必须是reg型变量
	//定义reg类型只是always过程语句的需要和语法规则
	reg y; 
	
	//always@引导过程语句，所有过程语句结构本身都属于并行语句
	//过程语句又是一个不断重复运行的模块，只要其敏感信号发生变化，
	//就将启动此过程执行一遍其中的所有语句
	always @(a or b or c or d or s1 or s0)
	//理论上begin_end引导的是顺序语句
	//": 块名" 可以省略
		begin : MUX41
			//大括号{}是并位运算符
			//{s1,s0}用并位算符按二进制拼接起来得到新的信号变量
			case({s1,s0})
				//“<=”是赋值符号，只能用于顺序语句
				2'b00: y<=a;
				2'b01: y<=b'
				2'b10: y<=c'
				2'b11: y<=d;
				default: y<=a;
			endcase
		end
endmodule 