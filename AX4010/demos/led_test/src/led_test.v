module led_test(clk,rst,led_out);
	input clk,rst;
	output led_out; //与LED引脚相连
	
	reg led_reg;	 //过程中使用
	reg [31:0] timer; //32位的计时器
	
	/*主频50MHz，1个clk是20ns，那么1s（1000000000ns）就需要
	需要1000000000ns/20ns=50000000个clk。又由于timer从0开始
	计数，所以0~49999999个clk就是1s。
	*/
	parameter time_1s = 32'd49_999_999;
	
/*	
	//initial通常用于仿真模块中对激励矢量的描述，或对寄存器变量赋初值，
	//而在实际电路中，赋初值是没有意义的。因此这是面向模拟仿真的过程语句，
	//通常不能被综合工具所接受，或在综合时被忽略。
   initial
	begin
		led_reg = 1'b0;
		timer = 32'b0;
	end
*/
	
	//此模块并不参与LED闪烁的直接实现
	always@(posedge clk or negedge rst)
	begin
		if(rst == 0) //复位
			begin 
				led_reg <= 1'b0;
				timer <= 32'b0;
			end
		else if(timer == time_1s)
			begin
				led_reg <= ~led_reg;
				timer <= 32'b0;
			end
		else
			timer <= timer + 1'b1;
	end
	
	assign led_out = led_reg;
endmodule 