module fifo_interface(
	in_data,	//用户的输入数据总线
	out_data,	//用户的输出数据总线
	fiford,		//FIFO读控制信号，低电平有效
	fifowr,		//FIFO写控制信号，低电平有效
	nfull,		
	nempty,
	address,	//到SRAM的地址总线
	sram_data,	//到SRAM的双向地址总线
	rd,			//SRAM的读使能，低电平有效
	wr,			//SRAM的写使能，低电平有效
	clk,		//系统时钟信号
	rst);		//全局复位信号，低电平有效

	//来自用户的控制输入信号
	input	fiford,fifowr,clk,rst;

	//来自用户的数据信号
	input [7:0]  in_data;
	output [7:0] out_data;
	reg [7:0]    in_data_buf,	//输入数据缓冲区
				 out_data_buf;	//输出数据缓冲区

	//输出到用户的状态指示信号
	output nfull,nempty;
	reg    nfull,nempty;

	//输出到SRAM的控制信号
	output rd,wr;
	
	//到SRAM的双向数据总线
	inout [7:0] sram_data;

	//输出到SRAM的地址总线
	output [10:0] address;
	reg [10:0]    address;

	//Internal Register
	reg [10:0] fifo_wp, //FIFO写指针
			   fifo_rp; //FIFO读指针

	reg [10:0] fifo_wp_next, //fifo_wp的下一个值
			   fifo_rp_next; //fifo_rp的下一个值

	reg [3:0]  state; //SRAM操作状态机寄存器

	parameter	idle = 'b0000,
				read_ready = 'b0100,
				read = 'b0101,
				read_over = 'b0111,
				write_ready = 'b1000,
				write = 'b1001,
				write_over = 'b1011;

	//SRAM操作状态机
	always@(posedge clk or negedge rst)
	begin
		if(~rst)
			state <= idle;
		else
			case(state)
				idle:				//等待FIFO的操作控制信号
					if(fifoer==0 && nfull) //用户发出写FIFO申请，且FIFO未满
						state <= write_ready;
					else if(fiford==0 && nempty) //用户发出读FIFO申请，且FIFO未空
						state <= read_ready;
					else					//没有对FIFO操作申请
						state <= idle;
				read_ready:	//建立SRAM操作所需地址和数据
					state <= read;
				read:	//等待用户结束当前操作
					if(fiford == 1)
						state <= read_over;
					else 
						state <= read;
				read_over: //继续给SRAM地址以保证数据稳定
					state <= idle;
				write_ready: //建立SRAM操作所需地址和数据
					state <= write;
				write: //等待用户结束当前写操作
					if(fifowr == 1)
						state <= write_over;
					else 
						state <= write;
				write_over: //继续给出SRAM地址和写入数据以保证数据稳定
					state <= idle;
				default: 
					state <= idle;
			endcase

	//产生SRAM操作相关信号
	
	end
endmodule 
