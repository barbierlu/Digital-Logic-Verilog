module Clock_divider (Clk_in, Clk_out);
	input Clk_in;
	output reg Clk_out;
	
	parameter n = 25000; // make 1kHz clock counting to 50,000
	
	reg [15:0] count;
	
	always @ (posedge Clk_in)
		begin
			if(count == n)
				begin
					count <= 0;
					Clk_out <= ~Clk_out; // toggle the clock
				end
			else
				count <= count + 1;
		end
endmodule 
