//上层模块
module trist1(sout,sin,ena);
	output sout;
	input sin,ena;
		//引用由mytri模块定义的实例元件tri_inst
		//“.”表示被引用模块的端口，名称必须与被引用模块mytri的端口定义一致，
		//小括号中表示在本模块中与之连接的线路
		mytri tri_inst(.out(sout), .in(sin), .enable(ena));
endmodule 

//子模块
module mytri(out,in,enable);
	output out;
	input in,enable;
		assign out = enable? in : 'bz;
endmodule 
