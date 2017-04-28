module Project_2_top (button, Clk, led, state_leds, seg_sec, seg_tsec, seg_hsec, seg_msec);
	input [1:0] button;
	input Clk;
	output reg led;
	output reg [2:0] state_leds;
	
	output [7:0] seg_sec;
		assign seg_sec[7] = 0; // set the decimal point always on (active low)
	output [6:0] seg_tsec, seg_hsec, seg_msec;
	
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	
	// delay reg and wire
	reg en_wait, leave_D;
	wire wait_done;
	
	reg en_bcd, en_upcount, reset_n;
	wire up_count_done;

	parameter t = 13;
	
	defparam U3.n = t;
	defparam U5.n = t;
	
	
	reg [1:0] state;
	
	wire Clk_1kHz;
	wire [3:0] dec_in_sec, dec_in_tsec, dec_in_hsec, dec_in_msec;
	wire [3:0] dec_out_sec, dec_out_tsec, dec_out_hsec, dec_out_msec;
	wire [t-1:0] random_num;
	
	
	
	always @(posedge Clk)  // negedge button[0], negedge button[1]
	begin
		if (button[1] == 0)
			begin
			case (state)
				A: 
					state <= B;
				//B: state <= A;
				C:
				begin
					state <= D;
				end
				D:
					if(leave_D)
						state <= B;
			endcase
			end
		else if (button[0] == 0) // RESET
			begin
				state <= A;
			end
		else
			case (state)
				A:
					begin
						leave_D <= 0;
						en_wait <= 0;
						en_bcd <= 0;
						en_upcount <= 0;
						led <= 0;
						reset_n <= 0;
						state_leds = 3'b000;
					end
				B: 
					begin
						if (up_count_done)
							state <= C;
						leave_D <= 0;
						en_wait <= 0;
						en_upcount <= 1; // start counting
						led <= 0;
						en_bcd <= 0;
						reset_n <= 0;	  // clear the counter
						state_leds = 3'b010;
					end	
				C: 
					begin
					leave_D <= 0;
					reset_n <= 1;
					en_wait <= 0;
					led <= 1; // turn LED on
					en_bcd <= 1;
					en_upcount <= 0; // stop up_counter
					state_leds = 3'b100;
					end
				D: 
					begin
					if (wait_done)
							leave_D <= 1;
					en_wait <=1;
					led <= 0;
					reset_n <= 1;
					en_bcd <= 0;
					en_upcount <= 0;
					state_leds = 3'b110;
					
					end // stop the clock
			endcase
	end	
		
		Clock_divider U4 (Clk, Clk_1kHz);
		
		LSRF U3 (Clk, random_num);
		Up_Counter U5 (en_upcount, Clk_1kHz, random_num, up_count_done);
		
		defparam U7.top = 700;
		defparam U7.bottom = 400;
		Up_Counter U7 (en_wait, Clk_1kHz, 500, wait_done);
		
		
		BCD_counter U1 (Clk_1kHz, reset_n, en_bcd, dec_in_sec, dec_in_tsec, dec_in_hsec, dec_in_msec);
		BCD_decoder U2 (Clk, state, dec_in_sec, dec_in_tsec, dec_in_hsec, dec_in_msec, dec_out_sec, dec_out_tsec, dec_out_hsec, dec_out_msec);
		
		Segment SEC (dec_out_sec, seg_sec[6:0]);
		Segment tSEC (dec_out_tsec, seg_tsec);
		Segment hSEC (dec_out_hsec, seg_hsec);
		Segment mSEC (dec_out_msec, seg_msec);

endmodule 
