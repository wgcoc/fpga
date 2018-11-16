module beh_fifo #(
	parameter DSIZE = 8,
	parameter ASIZE = 4
	)(
	output [DSIZE-1:0]	rdata, 
	output 		   		wfull, 
	output 		   		rempty, 
	input  [DSIZE-1:0] 	wdata, 
	input 		   		winc, wclk, wrst, 
	input 		   		rinc, rclk, rrst 
	);

	localparam MEMDEPTH = 1<<ASIZE; 
	
	reg [DSIZE-1:0] ex_mem [0:MEMDEPTH-1]; 
	reg [ASIZE:0] wptr, wrptr1, wrptr2, wrptr3; 
	reg [ASIZE:0] rptr, rwptr1, rwptr2, rwptr3; 

	always @(posedge wclk or posedge wrst)
	begin 
		if(wrst) begin 
			wptr <= 0; 
		end 
		else if(winc && !wfull) begin 
			ex_mem[wptr[ASIZE-1:0]] <= wdata; 
			wptr <= wptr + 1; 
		end
	end 

	always @(posedge wclk or posedge wrst) 
	begin 
		if(wrst) begin 
			{wrptr3, wrptr2, wrptr1} <= 0; 
		end 
		else begin
			{wrptr3, wrptr2, wrptr1} <= {wrptr2, wrptr1, rptr}; 
		end
	end

	always @(posedge rclk or posedge rrst) 
	begin 
		if(rrst) begin 
			rptr <= 0; 
		end 
		else if(rinc && !rempty) begin 
			rptr <= rptr+1; 
		end 
	end 

	always @(posedge rclk or posedge rrst) 
	begin 
		if(rrst) begin 
			{rwptr3, rwptr2, rwptr1} <= 0; 
		end 
		else begin 
			{rwptr3, rwptr2, rwptr1} <= {rwptr2, rwptr1, wptr}; 
		end 
	end 

	assign rdata  = ex_mem[rptr[ASIZE-1:0]]; 
	assign rempty = (rptr == rwptr3); 
	assign wfull  = ((wptr[ASIZE-1:0] == wrptr3[ASIZE-1:0]) && 
						  (wptr[ASIZE] != wrptr3[ASIZE]) ); 

endmodule 

