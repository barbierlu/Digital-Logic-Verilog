/* Decodes input from BCD_counter to 7 segment displays */ 
module BCD_decoder (Clk, state, S, tS, hS, mS, Sout, tSout, hSout, mSout);
	input Clk;
	input [1:0] state;
	
	input [3:0] S, tS, hS, mS;
	
	output reg [3:0] Sout, tSout, hSout, mSout;
	
	reg [3:0] h_S, h_tS, h_hS, h_mS;
	
	reg update_high_score;
	
	always @ (posedge Clk)
		begin
			if ((h_S == 0) && (h_tS == 0) && (h_hS == 0) && (h_mS == 0))
				update_high_score <= 1;
			else
			begin
			if (state == 2'b00) // display high score
				begin
				Sout <= h_S;
				tSout <= h_tS;
				hSout <= h_hS;
				mSout <= h_mS;
				update_high_score <= 0;
				end
			else if (state == 2'b11) // compare high score
				begin
				if(S < h_S)
					update_high_score <= 1;
				else if (S == h_S)
					if (tS < h_tS)
						update_high_score <= 1;
					else if (tS == h_tS)
						if(hS < h_hS)
							update_high_score <= 1;
						else if (hS == h_hS)
							if(mS < h_mS) // update high score
								update_high_score <= 1;
							else
								update_high_score <= 0;
						else
							update_high_score <= 0;
					else
						update_high_score <= 0;
				else
					update_high_score <= 0;
					
				Sout <= S;
				tSout <= tS;
				hSout <= hS;
				mSout <= mS;
				end
			else // states B and C
				begin
				Sout <= S;
				tSout <= tS;
				hSout <= hS;
				mSout <= mS;
				update_high_score <= 0;
				end
			end
		end
	always @(posedge update_high_score)
		begin
		if ((h_S == 0) && (h_tS == 0) && (h_hS == 0) && (h_mS == 0))
			begin
			h_S <= 9;
			h_tS <= 9;
			h_hS <= 9;
			h_mS <= 9;
			end
		else
			begin
			h_S <= S;
			h_tS <= tS;
			h_hS <= hS;
			h_mS <= mS;
			end
		end
	
endmodule
