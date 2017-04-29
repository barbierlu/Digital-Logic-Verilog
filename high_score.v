module high_score(Clk, En_update, S, tS, hS, mS, h_S, h_tS, h_hS, h_mS);
	input Clk, En_update;
	input [3:0] S, tS, hS, mS;
	output reg [3:0] h_S, h_tS, h_hS, h_mS;
	
	reg update_high_score;
	
	always @ (posedge Clk)
		begin
		if ((h_S == 0) && (h_tS == 0) && (h_hS == 0) && (h_mS == 0))
				update_high_score <= 1;
				
		else if (En_update)
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
			end
		end
		
	always @(posedge Clk)
	begin
	if(update_high_score)
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
				h_S = S;
				h_tS = tS;
				h_hS = hS;
				h_mS = mS;
				end
		end
	end
endmodule
