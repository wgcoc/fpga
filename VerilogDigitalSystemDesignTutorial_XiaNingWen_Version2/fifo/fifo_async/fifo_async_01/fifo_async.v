//https://blog.csdn.net/maxwell2ic/article/details/81105554
module fifo_async #(
	parameter DSIZE = 8,
	parameter ASIZE = 4
	)(
	output [DSIZE-1:0] rdata,
	output		   wfull,
	output		   rempty,
	input  [DSIZE-1:0] wdata,
	input		   winc,wclk,wrst,
	input		   rinc,rclk,rrst
	);

	wire [ASIZE-1:0] waddr, raddr;
	wire [ASIZE:0]   wptr,rptr,wrptr2,rwptr2;

	sync_r2w #(ASIZE) U1(
		.wrptr2(wrptr2),
		.rptr(rptr),
		.wclk(wclk),
		.wrst(wrst)
		);

	sync_w2r #(ASIZE) U2(
		.rwptr2(rwptr2),
		.wptr(wptr),
		.rclk(rclk),
		.rrst(rrst)		
		);

	fifomem #(DSIZE,ASIZE) U3(
		.rdata(rdata),
		.wdata(wdata),
		.waddr(waddr),
		.raddr(raddr),
		.wclken(winc),
		.wclk(wclk)
		);

	rptr_empty #(ASIZE) U4(
		.rempty(rempty),
		.raddr(raddr),
		.rptr(rptr),
		.rwptr2(rwptr2),
		.rinc(rinc),
		.rclk(rclk),
		.rrst(rrst)
		);

	wptr_full #(ASIZE) U5(
		.wfull(wfull),
		.waddr(waddr),
		.wptr(wptr),
		.wrptr2(wrptr2),
		.winc(winc),
		.wclk(wclk),
		.wrst(wrst)
		);

endmodule 
