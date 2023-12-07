`timescale 1ns/1ps

module eight_point_fft (CLK, RST_N, 
in0_r,in0_imag, in1_r,in1_imag, in2_r,in2_imag, in3_r,in3_imag, in4_r,in4_imag, in5_r,in5_imag, in6_r,in6_imag, in7_r,in7_imag, 
out0_r,out0_imag, out1_r,out1_imag, out2_r,out2_imag, out3_r,out3_imag, out4_r,out4_imag, out5_r,out5_imag, out6_r,out6_imag, out7_r,out7_imag, write, start, ready);
	input CLK, RST_N;
	input write, start;
	output ready;
    input signed[15:0] in0_r,in0_imag, in1_r,in1_imag,  in2_r,in2_imag, in3_r,in3_imag, in4_r,in4_imag, in5_r,in5_imag, in6_r,in6_imag, in7_r,in7_imag;
	output signed[15:0] out0_r,out0_imag, out1_r,out1_imag, out2_r,out2_imag, out3_r,out3_imag, out4_r,out4_imag, out5_r,out5_imag, out6_r,out6_imag, out7_r,out7_imag;
	reg signed[15:0] a0r,a0i, a1r,a1i, a2r,a2i, a3r,a3i, a4r,a4i, a5r,a5i, a6r,a6i, a7r,a7i;
	reg signed[15:0] b0r,b0i, b1r,b1i, b2r,b2i, b3r,b3i, b4r,b4i, b5r,b5i, b6r,b6i, b7r,b7i;
	reg ready;
	reg signed[15:0] check_for_neg,dummy_variable,temp_integer,temp_fract,residual_int,residual_fract,result;
	reg [7:0] integer_part;
    reg [7:0] fractional_part;
	reg flag;
	/*********************twiddle = 0.703125****************/
	parameter p_t = 16'b10110100;
	assign out0_r = a0r;
	assign out0_imag = a0i;
	assign out1_r = a1r;
	assign out1_imag = a1i;
	assign out2_r = a2r;
	assign out2_imag = a2i;
	assign out3_r = a3r;
	assign out3_imag = a3i;
	assign out4_r = a4r;
	assign out4_imag = a4i;
	assign out5_r = a5r;
	assign out5_imag = a5i;
	assign out6_r = a6r;
	assign out6_imag = a6i;
	assign out7_r = a7r;
	assign out7_imag = a7i;
  always @(posedge CLK) begin
		if (~RST_N) begin
			ready <= 1'b0;
		end
		else begin
			if (start) begin	
				a0r =  b0r +  b1r + b2r + b3r + b4r + b5r + b6r + b7r;
				a0i = 0;
                a1r =  (b0r- b4r) +  (b2i - b6i);  //(b1r - b3r - b5r + b7r + b1i + b3i - b5i - b7i);
				check_for_neg = (b1r - b3r - b5r + b7r + b1i + b3i - b5i - b7i);
				dummy_variable = check_for_neg;                 // Store in dummy_variable variable
				if (check_for_neg[15] == 1'b1) begin                 // Check for negative number
					integer_part = check_for_neg[15:8];               // Separate higher order bits
					fractional_part  = check_for_neg[7:0];                //Separate lower order bits
					check_for_neg = {-integer_part , fractional_part};     // Get 2's complement for only integer part (higher order bits)
					flag = 1'b1;
				end
				temp_integer = check_for_neg>>8;                   // Right shift to get integer part
				temp_fract = {8'b00000000, check_for_neg[7:0]};    // Make the higher order 8 bits 0 to get only the fractional part
				residual_int = p_t *temp_integer;               // Multiply with 0.703125 and get result of integer part 
				if (flag) begin                             // Convert to 2's complement if original numner "check_for_neg" was negative
					integer_part = residual_int[15:8];            // Separate higher order bits
					fractional_part  = residual_int[7:0];             //Separate lower order bits
					residual_int = {-integer_part , fractional_part};  // Get 2's complement for only integer part (higher order bits)
					flag = 1'b0;
                end
				residual_fract = p_t * temp_fract;           
				residual_fract = residual_fract>>8;          
				result = residual_int + residual_fract;      
				a1r = a1r + result;
				a1i = (b6r - b2r) + (b0i - b4i);    // + p_t*(b5r + b7r- b1r - b3r + b1i - b3i - b5i + b7i);
				check_for_neg = (b5r + b7r- b1r - b3r + b1i - b3i - b5i + b7i);
				dummy_variable = check_for_neg;                 
				if (check_for_neg[15] == 1'b1) begin
                  integer_part = check_for_neg[15:8];               
				  fractional_part  = check_for_neg[7:0];            
				  check_for_neg = {-integer_part , fractional_part};
				  flag = 1'b1;
				end
				temp_integer = check_for_neg>>8;                   
				temp_fract = {8'b00000000, check_for_neg[7:0]};    
				residual_int = p_t *temp_integer;           
				if (flag) begin                             
					integer_part = residual_int[15:8];      
					fractional_part  = residual_int[7:0];   
					residual_int = {-integer_part , fractional_part};  
					flag = 1'b0;
                end
				residual_fract = p_t * temp_fract;           
				residual_fract = residual_fract>>8;          
				result = residual_int + residual_fract;      
				a1i =  a1i + result;
				a2r =  (b0r - b2r + b4r - b6r) + (b1i - b3i + b5i - b7i);
				a2i = (b3r - b1r - b5r + b7r) + (b0i - b2i + b4i - b6i);
                a3r =  (b0r -  b4r) + (b6i - b2i);   
				check_for_neg = (b3r + b5r - b1r - b7r + b1i + b3i - b5i - b7i);
				dummy_variable = check_for_neg;                 
				if (check_for_neg[15] == 1'b1) begin            
					integer_part = check_for_neg[15:8];         
					fractional_part  = check_for_neg[7:0];      
					check_for_neg = {-integer_part , fractional_part};     
					flag = 1'b1;
				end
				temp_integer = check_for_neg>>8;                
				temp_fract = {8'b00000000, check_for_neg[7:0]}; 
				residual_int = p_t *temp_integer;               
				if (flag) begin                                 
					integer_part = residual_int[15:8];            
					fractional_part  = residual_int[7:0];         
					residual_int = {-integer_part , fractional_part};  
					flag = 1'b0;
                end
				residual_fract = p_t * temp_fract;          
				residual_fract = residual_fract>>8;         
				result = residual_int + residual_fract;     
				a3r = a3r + result;
                a3i = (b2r - b6r) + (b0i - b4i);  // + p_t*(b5r + b7r - b1r - b3r + b3i + b5i - b7i - b1i);
				check_for_neg = (b5r + b7r - b1r - b3r + b3i + b5i - b7i - b1i);
				dummy_variable = check_for_neg;                 
				if (check_for_neg[15] == 1'b1) begin            
					integer_part = check_for_neg[15:8];         
					fractional_part  = check_for_neg[7:0];      
					check_for_neg = {-integer_part , fractional_part};     
					flag = 1'b1;
				end
				temp_integer = check_for_neg>>8;                  
				temp_fract = {8'b00000000, check_for_neg[7:0]};   
					residual_int = p_t *temp_integer;             
				if (flag) begin                             
					integer_part = residual_int[15:8];            
					fractional_part  = residual_int[7:0];         
					residual_int = {-integer_part , fractional_part};  
					flag = 1'b0;
                end
				residual_fract = p_t * temp_fract;           
				residual_fract = residual_fract>>8;          
				result = residual_int + residual_fract;      
				a3i = a3i + result;
				a4r =  b0r -  b1r + b2r - b3r +b4r - b5r + b6r - b7r;
				a4i = 0;
				a5r =  a1r;  //blocking				
				integer_part = a3i[15:8];               
				fractional_part  = a3i[7:0];            
				a5i = {-integer_part , fractional_part};
                a6r =  a2r;  //blocking			
				integer_part = a2i[15:8];               
				fractional_part  = a2i[7:0];            
				a6i = {-integer_part , fractional_part};
                a7r =  a3r;  //blocking
				integer_part = a1i[15:8];               
				fractional_part  = a1i[7:0];            
				a7i = {-integer_part , fractional_part};
				ready <= 1'b1;
			end
			else begin
				if (write) begin
					 b0r <= in0_r;
					b0i <= in0_imag;
					b1r <= in1_r;
					b1i <= in1_imag;
					b2r <= in2_r;
					b2i <= in2_imag;
					b3r <= in3_r;
					b3i <= in3_imag;
					b4r <= in4_r;
					b4i <= in4_imag;
					b5r <= in5_r;
					b5i <= in5_imag;
					b6r <= in6_r;
					b6i <= in6_imag;
					b7r <= in7_r;
					b7i <= in7_imag;
					flag <= 1'b0;
				end
				ready <= 1'b0;
			end
		end
	end
endmodule

/************************************************test bench************/
`timescale 1ns/1ps
module eight_point_fft_tb();
	parameter CLOCK_PERIOD = 10; // 10 MHz clock
	parameter NUM_TEST = 1; // Number of tests
    reg [2:0] test_count;
	reg clk, rst;
	reg write, start;
	reg [15:0] in0_r,in0_imag, in1_r,in1_imag,  in2_r,in2_imag, in3_r,in3_imag, in4_r,in4_imag, in5_r,in5_imag, in6_r,in6_imag, in7_r,in7_imag;
	wire [15:0] out0_r,out0_imag, out1_r,out1_imag, out2_r,out2_imag, out3_r,out3_imag, out4_r,out4_imag, out5_r,out5_imag, out6_r,out6_imag, out7_r,out7_imag;
	wire ready;
	reg [3:0] state;
	reg en_a, en_b;
	event terminate_sim;
  eight_point_fft u_DUT (.CLK(clk),.RST_N(rst),.write(write),.start(start),.ready(ready),.out0_r(out0_r),.out0_imag(out0_imag),.out1_r(out1_r),.out1_imag(out1_imag),.out2_r(out2_r),.out2_imag(out2_imag),.out3_r(out3_r),.out3_imag(out3_imag),.out4_r(out4_r),.out4_imag(out4_imag),.out5_r(out5_r),.out5_imag(out5_imag),.out6_r(out6_r),.out6_imag(out6_imag),.out7_r(out7_r),.out7_imag(out7_imag),.in0_r(in0_r),.in0_imag(in0_imag),.in1_r(in1_r),.in1_imag(in1_imag),.in2_r(in2_r),.in2_imag(in2_imag),.in3_r(in3_r),.in3_imag(in3_imag),.in4_r(in4_r),.in4_imag(in4_imag),.in5_r(in5_r),.in5_imag(in5_imag),.in6_r(in6_r),.in6_imag(in6_imag),.in7_r(in7_r),.in7_imag(in7_imag));
	always @(posedge clk) begin
		if (rst == 1'b1) begin
			if (state == 4'h0) begin
				if (test_count == NUM_TEST) begin
					-> terminate_sim;
				end
				if (test_count == 0) begin                  // Enable the FFT block
					en_a <= 1'b1; en_b <= 1'b1;
					state <= 4'h1;
				end
			end
			if (state == 4'h1) begin                        //Write to the FFT block inputs
				in0_r    = 16'b0000000100000000;
				in0_imag = 16'b0000000000000000;
				in1_r    = 16'b0000000100000000; 
				in1_imag = 16'b0000000000000000;
				in2_r    = 16'b0000001000000000; 
				in2_imag = 16'b0000000000000000;
				in3_r    = 16'b0000001100000000; 
				in3_imag = 16'b0000000000000000;
				in4_r    = 16'b0000010000000000; 
				in4_imag = 16'b0000000000000000; 
				in5_r    = 16'b0000010100000000; 
				in5_imag = 16'b0000000000000000;
				in6_r    = 16'b0000011000000000; 
				in6_imag = 16'b0000000000000000;
				in7_r    = 16'b0000011100000000; 
				in7_imag = 16'b0000000000000000;
				en_a <= 1'b0; en_b <= 1'b0; write <= 1'b1;
				state <= 4'h2;
			end
			if (state == 4'h2) begin                 // Start the FFT computation
				start <= 1'b1; write <= 1'b0;
				state <= 4'h3;
			end
			if (state == 4'h3) begin
				start <= 1'b0;
				if (ready) begin                  
                  if (test_count == NUM_TEST-1 ) begin
					  state <= 4'h0;
                                                                           

					end

					else begin
						en_a <= 1'b1; en_b <= 1'b1;
						state <= 4'h1;
					end
                  test_count <= test_count + 1;
				end
			end
		end
    	end
	// End of simulation
  	initial @(terminate_sim) begin
        	$display("END OF SIMULATION (Time: %g ns)", $time);
        	$display("##################\n");
        	#1  $finish;
    end
 	// Initial conditions
	initial begin
	    clk = 1'b0; rst = 1'b0;
        en_a = 1'b0; en_b = 1'b0;
		state = 4'h0;test_count = 0;
		write = 1'b0; start = 1'b0;
		#CLOCK_PERIOD rst = 1'b1;
		#(CLOCK_PERIOD/2) $display("START OF SIMULATION (Time: %g ns)", $time);
    	end
	// System clock generator
	always begin
		#(CLOCK_PERIOD/2) clk = ~clk;
	end
  initial begin
	   $dumpfile("fft_new_approach.vcd");
		$dumpvars(0, u_DUT);
$monitor("Time: %t \n out0_real = %b , out0_imag = %b \n out1_real = %b , out1_imag = %b \n out2_real = %b , out2_imag = %b \n out3_real = %b , out3_imag = %b \n out4_real = %b , out4_imag = %b \n out5_real = %b , out5_imag = %b \n out6_real = %b , out6_imag = %b \n out7_real = %b , out7_imag = %b \n ready = %b ", $time,out0_r,out0_imag, out1_r,out1_imag, out2_r,out2_imag, out3_r,out3_imag, out4_r,out4_imag, out5_r,out5_imag, out6_r,out6_imag, out7_r,out7_imag, ready);	end
  
endmodule