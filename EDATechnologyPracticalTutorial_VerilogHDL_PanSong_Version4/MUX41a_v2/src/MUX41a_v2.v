module MUX41a_v2(A,B,C,D,S1,S0,Y);
	input A,B,C,D,S1,S0;
	output Y;
	//如果S0=1成立，则AT=D；如果S0=0成立，则AT=C
	wire AT = S0 ? D : C;
	//如果S0=1成立，则AT=B；如果S0=0成立，则AT=A
	wire BT = S0 ? B : A;
	//如果S1=1成立，则Y=AT；如果S1=0成立，则Y=BT
	wire Y =(S1 ? AT : BT);
endmodule 