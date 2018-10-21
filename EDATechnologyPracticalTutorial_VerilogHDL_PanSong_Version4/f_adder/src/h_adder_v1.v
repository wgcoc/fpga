//半加器描述：基于case语句的类真值表描述方法
module h_adder_v1(a,b,so,co);
	input a,b;
	output so,co;
	reg so,co;
	always @(a, b, so, co)
	begin //主块开始
		case({a,b})
			0 : begin so=0; co=1'b0	end //注意这里使用了块语句 
			1 : begin so=1; co=1'b0	end 
			2 : begin so=1; co=1'b0	end 
			3 : begin so=0; co=1'b1	end 
			default : begin so=0; co=0	end 
		endcase 
	end //主块结束
endmodule 