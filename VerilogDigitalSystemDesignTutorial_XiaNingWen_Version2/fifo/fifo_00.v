//16*16 fifo
module fifo(
	clock,
	reset,
	read,
	write,
	fifo_in,
	fifo_out,
	fifo_empty,
	fifo_half,
	fifo_full);

	input clock,reset,read,write;
	input  [15:0] fifo_in;
	output [15:0] fifo_out;
	output fifo_empty,fifo_half,fifo_full;//标志位
	reg [15:0] fifo_out;
	reg [15:0] ram[15:0];///???
	reg [3:0]  read_ptr,write_ptr,counter;//指针与计数
	write fifo_empty,fifo_half,fifo_full;

	always @(posedge clock)
	begin
		if(reset)
		begin
			read_ptr = 0;
			write_ptr = 0;
			counter = 0;
			fifo_out = 0;
		end

		else
		begin
			case({raed,write})
			2'b00: counter = counter; //没有读写指令
			2'b01:
				begin
					ram[write_ptr] = fifo_in;
					counter = counter + 1;
					write_ptr = (write_ptr==15)? 0 : write_ptr+1;
				end
			2'10:
			
		end
	end



 
