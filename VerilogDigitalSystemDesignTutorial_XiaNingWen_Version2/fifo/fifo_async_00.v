module fifo_async#(
	parameter	data_width = 16,
	parameter	data_depth = 256,
	parameter	addr_width = 8
)
(
	input		rst,
	input		wr_clk,
	input		wr_en,
	input [data_width-1:0] din,
	input		rd_clk,
	input		rd_en,
	input reg	valid,
	output reg [data_width-1:0] dout,
	output		empty,
	output		full
);

	reg [addr_width:0] wr_addr_ptr; //地址指针，比地址多一位，MSB用于检测在同一圈
	reg    [addr_width:0]    rd_addr_ptr;
	wire   [addr_width-1:0]  wr_addr;//RAM 地址
	wire   [addr_width-1:0]  rd_addr;

wire [addr_width:0] wr_addr_gray;//地址指针对应的格雷码 
reg  [addr_width:0] wr_addr_gray_d1; 
reg  [addr_width:0] wr_addr_gray_d2; 
wire [addr_width:0] rd_addr_gray; 
reg  [addr_width:0] rd_addr_gray_d1; 
reg  [addr_width:0] rd_addr_gray_d2;

endmodule 
