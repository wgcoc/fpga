//基于逻辑单元互联结构的描述
//1.and,or和not都是verilog语言的保留字，由verilog语言的原语(primitive)规定它们的接口顺序和用法，
//分别表示与门、或门和非门，其中元器件的输出口都规定在第一个端口
//2.#1和#2分别表示门输入到输出的延迟为1和2个单位时间
module muxtwo_v3 (out,a,b,sl);
	input a,b,sl;
	output out;
		not u1(nsl,sl);
		and #1 u2(sela,a,nsl);
		and #1 u3(selb,b,sl);
		or  #1 u4(out,sela,selb);
endmodule 

