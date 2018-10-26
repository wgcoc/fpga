`timescale 1ns/1ns
module CNT10_TB;
	reg clk,rst,en,load;
	reg [3:0] data;
	
	initial 
	begin
		clk = 1'b0;
		rst = 1'b0;
		en  = 1'b0;
		load = 1'b0;
		data = 4'b0001;
		
		#100 rst = 1'b1;
		#100 en = 1'b1;
		#100 load = 1'b1;
	end
	
	always#10 clk = ~clk;
	CNT10 cnt10
	(
		.CLK(clk),
		.RST(rst),
		.EN(en),
		.LOAD(load),
		.DATA(data)
	);
	
endmodule 