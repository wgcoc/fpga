//三态门选择器
module trist2(out,in,enable);
	output out;
	input in,enable;
		//bufif1是verilog语言提供的原语库中现存的三态驱动器元件
		//这种引用现成元件或模块的方法叫做实例化或实例引用
		bufif1 mybuf(out,in,enable);
endmodule 
