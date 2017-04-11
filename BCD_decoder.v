
/* Decodes input from BCD_counter to 7 segment displays */ 
module BCD_decoder (S, tS, hS, mS, Sout, tSout, hSout, mSout);
	input [3:0] S, tS, hS, mS;
	output [3:0] Sout, tSout, hSout, mSout;
	
	assign Sout = S;
	assign tSout = tS;
	assign hSout = hS;
	assign mSout = mS;
	
endmodule
