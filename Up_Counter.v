module Up_Counter (En, Clk, random_num, done);
	parameter n = 15;

	input En, Clk;
	input [n-1:0] random_num;
	reg [n-1:0] count_to;
	output reg done;
	
	reg [n-1:0] count;
	
	always @(posedge Clk)
		begin
		if (En)
			begin
			if (count == count_to)
				begin
				done <= 1;
				end
			else
				begin
				count <= count + 1;
				done <= 0;
				end
			end
		else
			begin
			count_to <= random_num;
			count <= 0;
			done <= 0;
			end
		end

endmodule
