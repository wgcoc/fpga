//同步复位型触发起
//含有同步清零的D触发器
module DFF2_v1(CLK,D,Q,RST);
	input CLK,D,RST;
	output Q;
	reg Q;
	//注意，敏感信号表中只放了对CLK上升沿的敏感表述
	always @(posedge CLK)
	begin
		if(RST == 1) Q = 0;		//当CLK有上升沿时，若RST=0，则Q被清零
		else if(RST == 0) Q = D;//当CLK有上升沿时，若RST=1，则Q被被更新为D值
		else Q = Q; //否则保持Q原值不便，此句可以不要
	end
endmodule 