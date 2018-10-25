`timescale 1ns/1ns
module led_test_tb;
reg clk;
reg rst;
wire led;
initial
begin
	clk = 1'b0;
	rst = 1'b0;
	#100 rst = 1'b1;	
end
always#10 clk = ~clk;//50Mhz
led_test dut
(
	.clk           (clk),// 开发板上输入时钟: 50Mhz
	.rst         	(rst),// 开发板上输入复位按键
	.led_out       (led)// 输出LED灯,用于控制开发板上四个LED(LED0~LED3)
);
endmodule 