/* Decodes input from BCD_counter to 7 segment displays */ 
module BCD_decoder (Clk, state, S, tS, hS, mS, h_S, h_tS, h_hS, h_mS, Sout, tSout, hSout, mSout);
	input Clk;
	input [1:0] state;
	input [3:0] S, tS, hS, mS, h_S, h_tS, h_hS, h_mS;
	output reg [3:0] Sout, tSout, hSout, mSout;
	
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	
	
	always @ (posedge Clk)
	begin
		case (state)
			A:	// Display high score
				begin
				Sout <= h_S;
				tSout <= h_tS;
				hSout <= h_hS;
				mSout <= h_mS;
				end
			default: // all other states display input
				begin
				Sout <= S;
				tSout <= tS;
				hSout <= hS;
				mSout <= mS;
				end
		endcase
	end
endmodule
