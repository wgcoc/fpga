//带有异步复位、同步计数和可预置型十进制计数器
module CNT10(CLK,RST,EN,LOAD,COUT,DOUT,DATA);
	//时钟，时钟使能，复位，数据加载控制信号
	input CLK,EN,RST,LOAD;
	//4位并行加载数据
	input [3:0] DATA;
	//计数数据输出
	output [3:0] DOUT;
	//计数进位输出
	output COUT;
	reg [3:0] Q1;
	reg COUT;
	//将内部寄存器的计数结果输出至DOUT
	assign DOUT = Q1;
	//时序过程
	always @(posedge CLK,negedge RST)
	begin 
		if(!RST) 	
			Q1 <= 0; //RST=0时，对内部寄存器单元异步清零
		else if(EN) 
		begin //同步使能EN=1，则允许加载或计数
			if(!LOAD) 		Q1 <= DATA; 	//当LOAD=0时，向内部寄存器加载数据
			else if(Q1<9) 	Q1 <= Q1 + 1;	//当Q1小于9时，允许累加
			else 				Q1 <= 4'b0000;	//否则一个时钟清零返回初值
		end
	end
	//组合电路过程
	always @(Q1)
	begin
		if(Q1 == 4'h9)	COUT = 1'b1;	//当Q1=1001时，COUT输出进位标志0
		else 				COUT = 1'b0;	//否则输出进位标志0
	end
endmodule 