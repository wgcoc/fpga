//1位二进制全加器顶层设计描述
module f_adder(ain,bin,cin,cout,sum);
	input ain,bin,cin;
	output cout,sum;
	wire e,d,f; //定义网线型变量用作内部元件间连线
	//使用位置关联法进行例化(不灵活，不推荐)
	h_adder u1( ain, bin, e, d );
	//使用端口名关联法(信号名映射法)进行例化，
	//格式：<模块元件名> <例化元件名>( .例化元件端口(例化元件外接端口名)， ...);
	//括号中的信号名是外部端口名，括号外带点的信号名是待连接的元件自己的端口名
	h_adder u2(.a(e), .so(sum), .b(cin), .co(f));
	or2a u3(.a(d), .b(f), .c(cout));
endmodule 