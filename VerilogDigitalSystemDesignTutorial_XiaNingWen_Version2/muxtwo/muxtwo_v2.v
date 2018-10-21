module muxtwo_v2 (out, a, b, sl);
	input a,b,sl;
	output out;
	wire nsl,sela,selb;		//定义内部连接线
		assign nsl = ~sl;	//求反
		assign sela = a & nsl;	//按位与运算
		assign selb = b & sl;
		assign out = sela | selb;//按位或运算
endmodule 
