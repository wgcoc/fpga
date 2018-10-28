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
endmodule 








