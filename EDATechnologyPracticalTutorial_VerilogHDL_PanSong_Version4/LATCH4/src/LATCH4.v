//使用的是常规的具有时序语句特色
module LATCH4(CLK,D,Q,RST);
	input CLK,D,RST;
	output Q;
	reg Q;
	always @(D or CLK or RST)
	begin
		if(!RST)	Q <= 0;
		else if(CLK) Q <= D;
	end
endmodule 