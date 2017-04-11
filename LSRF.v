module LSRF (Clk, Q);
	parameter n = 15;
	
	input Clk;
	output reg [n-1:0] Q;
	
	
	parameter start = 17;
	
	integer k;
	
	always @(posedge Clk)
		begin
		if (Q == 0)
			Q <= start;
		else
			begin
				Q[0] <= Q[n-1] ^ Q[n-2];
				
				for (k=0; k < (n-1); k=k+1)
					begin: k_loop
						Q[k+1] <= Q[k];
					end
			end // else
		end // always
endmodule
