//数据流的逻辑描述方式
//并行语句加纯布尔逻辑表达式实现的模块功能
module MUX41a_v1(a,b,c,d,s1,s0,y);
	input a,b,c,d,s1,s0;
	output y;
	//定义2元素位矢量SEL为网线型变量wire
	wire [1:0] SEL;
	//定义中间变量，以作连线或信号节点
	wire AT,BT,CT,DT;
	//assign语句中的变量必须是网线型变量
	//assign引导的赋值语句属于并行赋值语句
	//对s1,s0进行并位操作，即SEL[1]=s1；SEL[0]=s0
	assign SEL = {s1,s0};
	assign AT =(SEL==2'D0); //D 表示十进制
	assign BT =(SEL==2'D1);
	assign CT =(SEL==2'D2);
	assign DT =(SEL==2'D3);
	//4个逻辑信号相或
	assign y =(a & AT)|(b & BT)|(c & CT)|(d & DT);
endmodule 