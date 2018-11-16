`timescale 1ns/100ps

module fifo_tb; 

	parameter DSIZE = 8; 
	parameter ASIZE = 4;
 
	wire [DSIZE-1:0]	rdata, beh_rdata;
	wire 		 			wfull, beh_wfull;
	wire 		 			rempty, beh_rempty;
	
	reg  [DSIZE-1:0] 	wdata; 
	reg 			 		winc, wclk, wrst;
	reg 		 			rinc, rclk, rrst;

	fifo_async #(DSIZE, ASIZE) U1( 
		.rdata(rdata), 
		.wfull(wfull), 
		.rempty(rempty), 
		.wdata(wdata), 
		.winc(winc), 
		.wclk(wclk), 
		.wrst(wrst), 
		.rinc(rinc), 
		.rclk(rclk), 
		.rrst(rrst) 
		); 
		
	beh_fifo #(DSIZE, ASIZE) U2( 
		.rdata(beh_rdata), 
		.wfull(beh_wfull), 
		.rempty(beh_rempty), 
		.wdata(wdata), 
		.winc(winc), 
		.wclk(wclk), 
		.wrst(wrst), 
		.rinc(rinc), 
		.rclk(rclk), 
		.rrst(rrst)
		); 

	always #30 wclk = ~wclk; 
	always #20 rclk = ~rclk; 
	always #30 wdata = {$random}%256;
	
	initial 
	begin 
		wrst = 0; 
		rrst = 0; 
		rclk = 0; 
		wclk = 0; 
		winc = 0; 
		rinc = 0; 
		#50 wrst = 1; 
			 rrst = 1; 
		#50 wrst = 0; 
			 rrst = 0; 
		#10 rinc = 1; 
		#100 rinc = 0; 
		#100 winc = 1; 
		#1000 winc = 0; 
		#100 rinc = 1; 
		#2000 $finish; 
	end
	
	always @((rdata != beh_rdata) && 
		      (wfull != beh_wfull) && 
		      (rempty != beh_rempty) ) 
	begin 
		$display($time, "rdata is %h, beh_rdata is %h", rdata, beh_rdata); 
	end
 
endmodule 

