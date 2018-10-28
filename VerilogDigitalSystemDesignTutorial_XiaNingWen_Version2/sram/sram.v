/********************************************************************************
* File Name				: sram.v				*
* Function				: 2K*8bit Asynchronous CMOS Static ARM	*
********************************************************************************/
/********************************************************************************
* Module Name				: sram					*
* Description				: 2K*8bit Asynchronous CMOS Static ARM	*
* Reference				: HM-65162 reference book		*
********************************************************************************/
/********************************************************************************
* sram is a Verilog HDL model for HM-65162,2K*8bit Asynchronous COMS Static	*
* RAM.It is used in simulation to substitute the real RAM to verify whther	*
* the writing or reading of the RAM is OK.This module is a behavioral model	*
* for simulation only,not synthesizable.It's writing and reading function	*
* are verified.									*
********************************************************************************/
//-------------------------------sram--------------------------------------------
module sram(Address, Data, SRG, SRE, SRW);
	input [10:0] Address;

	input SRG, //Output enable
	      SRE, //Chip enable
	      SRW; //Write enable

	input [7:0] Data; //Bus

	wire [10:0] Addr = Address;
	reg  [7:0]  RdData;
	reg  [7:0]  SramMem[0:'h7ff];
	reg         RdSramDly, RdFile;
	reg  [7:0]  FlpData,   Data;
	reg         WR_flag; //To judge the signals according to the specification of HM-65162
	integer     i;
	
	wire        RdSram = ~SRG & ~SRE;
	wire        WrSram = ~SRW & ~SRE;
	reg  [10:0] DelayAddr;
	reg  [7:0]  DelayData;
	reg         WrSramDly;
	
	integer     file;

	assign FlpData = (RdFile)? ~RdData : RdData;
	assign Data    = (RdSramDly)? FlyData : 'hz;

	/*******************parameters of read circle***************************/
	                       //参数序号、最大或最小、参数含义
	parameter TAVQV = 90,  // 2      (max)    Address access time
		  TELQV = 90,  // 3      (max)    Chip enable access time
		  TELQX = 5,   // 4      (min)    Chip enable output enable time
		  TGLQV = 65,  // 5      (max)    Output enable access time
		  TGLQX = 5,   // 6      (min)    Output inable output enable time
		  TEHQZ = 50,  // 7      (max)    Chip enable output disable time
		  TGHQZ = 40,  // 8      (max)    Output enable output disable time
		  TAVQX = 5;   // 9      (min)    Output hold from address change

	/*******************parameters of write circle**************************/
	parameter TAVWL = 10,  // 12      (min)   Address setup time
		  TWLWH = 55,  // 13      (min)   Chip enable pulse setup time
						  //write enable pulse width
		  TWHAX = 15,  // 14      (min10) Write enable read setup time
						  //读上升沿后地址保留时间
		  TWLQZ = 50,  // 16      (max)   Write enable output disable time
		  TDVWH = 30,  // 17      (min)   Data setup time
		  TWHDX = 20,  // 18      (min15) Data hold time
		  TWHQX = 20,  // 19      (min0)  Write enable output enable time,0
		  TWLEH = 55,  // 20      (min)   Write enable pluse setup time
		  TDVEH = 30,  // 21      (min)   Chip enable data setup time
		  TAVWH	= 70;  // 22      (min65) Adress valid to end of write

	initial 
	begin
		file = $fopen("ramlow.txt");
		if(!file)
		begin
			$display("Could not open the file.");
			$stop;
		end
	end

	initial 
	begin
		for(i=0;i<'h7ff;i=i+1)
		begin
			SramMem[i] = i;
		end
		
		//$monitor($time, ,"DelayAddr=%h,DelayData=%h",DelayAddr,DelayData);
	end

	initial RdSramDly = 0;
	initial WR_flag = 1;
	
	/***************************READ CIRCLE*********************************/
	always @(posedge RdSram) #TGLQX RdSramDly = RdSram;		
	always @(posedge SRW)    #TWHQX RdSramDly = RdSram;

	always @(Addr)
	begin
		#TAVQX;
		RdFile = 1;
		#(TGLQV - TAVQX); //address access time
		if(RdSram) RdFile = 0;
	end

	always @(posedge RdSram)
	begin
		RdFile = 1;
		#TAVQV; //Output enable access time
		if(RdSram) RdFile = 0;
	end

	always @(Addr)        #TAVQX RdFile = 1;
	always @(posedge SRG) #TEHQZ RdSramDly = RdSram;
	always @(posedge SRE) #TGHQZ RdSramDly = RdSram;
	always @(posedge SRW) #TWLQZ RdSramDly = 0;
	
	always @(negedge WrSramDly or posedge RdSramDly) RdData = SramMem[Addr];

	/***************************WRITE CIRCLE********************************/
	always @(Addr)   #TAVWL DelayAddr = Addr; //Address setup
	always @(Data)   #TDVWH DelayData = Data; //Data setup
	always @(WrSram) #5 WrSramDly = WrSram;
	always @(Addr or Data or WrSram) WR_flag = 1;

	always @(negedge SRW)
	begin
		#TWLWH; //Write enable pulse width
		if(SRW)
		begin
			WR_flag = 0;
			$display("ERROR! Can't write! Write enable time(W) is too short!");
		end
	end

	always @(negedge SRW)
	begin
		#TWLEH; //Write enable pulse setup time
		if(SRE)
		begin
			WR_flag = 0;
			$display("ERROR! Can't write! Write enable time(E) is too short!");
		end
	end

	always @(posedge SRW)
	begin
		#TWHAX; //Write enable read setup time
		if(DelayAddr != Addr)
		begin
			WR_flag = 0;
			$display("ERROR! Can't write! Write enable read setup time is too short!");
		end
	end

	always @(Data)
	begin
		if(WrSram)
		begin
			#TDVEH; //Chip enable data setup time
			if(SRE)
			begin
				WR_flag = 0;
				$display("ERROR! Can't write! Chip enable data setup is too short!");
			end
		end
	end

	always @(Data)
	begin
		if(WrSram)
		begin
			#TDVEH;
			if(SRW)
			begin
				WR_flag = 0;
				$display("ERROR! Can't write! Chip enable data setup is too short!");
			end		
		end
	end

	always @(posedge SRW)
	begin
		#TWHDX; //Data hold time
		if(DelayData !== Data)
			$display("Warning! Data hold time is too short!");
	end

	always @(DelayAddr or DelayData or WrSramDly)
	begin
		if(!Addr[5])
		begin
			#15 SramMem[Adrr] = Data;
			//$display("mem[%h]=%h",Addr,Data);
			$fwrite(file,"mem[%h]=%h",Addr,Data);
			if(Addr[0] && Addr[1]) $fwrite(file,"\n");
		end

		else
		begin
			$fclose(file);
			$display("Please check the txt.");
			$stop;
		end		
	end

********************************************************************************/

endmodule 








