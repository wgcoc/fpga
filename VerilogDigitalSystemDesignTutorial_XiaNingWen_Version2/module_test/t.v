include "muxtwo.v"

module t;
	reg ain, bin, select;
	reg clock;
	wire outw;
	
	//把寄存器变量初始化为一确定值	
	initial
	begin
		ain = 0;
		bin = 0;
		select = 0;
		clock = 0;
	end
	
	//产生一个不断重复的周期为100个时钟信号的clock
	always #50 clock = ~clock;

	always @(posedge clock)
	begin	//{$random}为系统任务，会产生一个随机数
		#1 ain={$random}%2; //产生随机的位信号流，%2为模2运算
		#3 bin={$random}%2; //分别延迟1和3个时间单位后产生随机数的位信号流ain和bin
	end
	
	//产生周期为10000个单位时间的选通信号变化
	//......
	/* 实例引用多路器，并加入测试信号流，以观察模块的输出out。其中，muxtwo是已经
	定义的（行为的或结构的）模块，m表示在本测试模块中有一个名为m的muxtwo的模块，
	其4个端口分别为：
		.out(), .a(), .b(), .sl(),
	“.”表示端口，后面紧跟端口名，其名称必须与muxtwo模块定义的端口名一致；小括号中的
	信号名为与该端口连接的信号线名，可以用别的名，但必须在本模块中定义，说明其类型。
	*/
	muxtwo m(.out(outw), .a(ain), .b(bin), .sl(select));	
endmodule 
