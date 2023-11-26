

`timescale 1ns/1ps


module eight_point_fft_tb ();
//read about parameter
	parameter CLOCK_PERIOD = 100; // 10 MHz clock//100ns =10MHz
	parameter NUM_TEST = 1000; // Number of tests

	reg sys_clk, sys_rst_n;//clk
	// reg [3:0] state;//
	// reg en_a, en_b;//enable 
	reg write, start;//store and ..
	reg [9:0] test_err;
	reg [9:0] test_count;

	
	reg signed [15:0] in0_real  ; // Input 16-bit real part of 𝑥0
	reg signed [15:0] in0_imag  ; // Input 16-bit imaginary part of 𝑥0
	reg signed [15:0] in1_real  ; // Input 16-bit real part of 𝑥1
	reg signed [15:0] in1_imag  ; // Input 16-bit imaginary part of 𝑥1
	reg signed [15:0] in2_real  ; // Input 16-bit real part of 𝑥2
	reg signed [15:0] in2_imag  ; // Input 16-bit imaginary part of 𝑥2
	reg signed [15:0] in3_real  ; // Input 16-bit real part of 𝑥3
	reg signed [15:0] in3_imag  ; // Input 16-bit imaginary part of 𝑥3
	reg signed [15:0] in4_real  ; // Input 16-bit real part of 𝑥4
	reg signed [15:0] in4_imag  ; // Input 16-bit imaginary part of 𝑥4
	reg signed [15:0] in5_real  ; // Input 16-bit real part of 𝑥5
	reg signed [15:0] in5_imag  ; // Input 16-bit imaginary part of 𝑥5
	reg signed [15:0] in6_real  ; // Input 16-bit real part of 𝑥6
	reg signed [15:0] in6_imag  ; // Input 16-bit imaginary part of 𝑥6
	reg signed [15:0] in7_real  ; // Input 16-bit real part of 𝑥7
	reg signed [15:0] in7_imag  ; // Input 16-bit imaginary part of 𝑥7

//declared 
wire signed [15:0] out0_real; //16-bit//Output  real part of 𝑋0
wire signed [15:0] out0_imag; // Output 16-bit imaginary part of 𝑋0
wire signed [15:0] out1_real; // Output 16-bit real part of 𝑋1
wire signed [15:0] out1_imag; // Output 16-bit imaginary part of 𝑋1
wire signed [15:0] out2_real; // Output 16-bit real part of 𝑋2
wire signed [15:0] out2_imag; // Output 16-bit imaginary part of 𝑋2
wire signed [15:0] out3_real; // Output 16-bit real part of 𝑋3
wire signed [15:0] out3_imag; // Output 16-bit imaginary part of 𝑋3
wire signed [15:0] out4_real; // Output 16-bit real part of 𝑋4
wire signed [15:0] out4_imag; // Output 16-bit imaginary part of 𝑋4
wire signed [15:0] out5_real; // Output 16-bit real part of 𝑋5
wire signed [15:0] out5_imag; // Output 16-bit imaginary part of 𝑋5
wire signed [15:0] out6_real; // Output 16-bit real part of 𝑋6
wire signed [15:0] out6_imag; // Output 16-bit imaginary part of 𝑋6
wire signed [15:0] out7_real; // Output 16-bit real part of 𝑋7
wire signed [15:0] out7_imag; // Output 16-bit imaginary part of 𝑋7
//expected values

 wire signed [15:0] out0_real_e; //16-bit//Output  real part of 𝑋0
 wire signed [15:0] out0_imag_e; // Output 16-bit imaginary part of 𝑋0
 wire signed [15:0] out1_real_e; // Output 16-bit real part of 𝑋1
 wire signed [15:0] out1_imag_e; // Output 16-bit imaginary part of 𝑋1
 wire signed [15:0] out2_real_e; // Output 16-bit real part of 𝑋2
 wire signed [15:0] out2_imag_e; // Output 16-bit imaginary part of 𝑋2
 wire signed [15:0] out3_real_e; // Output 16-bit real part of 𝑋3
 wire signed [15:0] out3_imag_e; // Output 16-bit imaginary part of 𝑋3
 wire signed [15:0] out4_real_e; // Output 16-bit real part of 𝑋4
 wire signed [15:0] out4_imag_e; // Output 16-bit imaginary part of 𝑋4
 wire signed [15:0] out5_real_e; // Output 16-bit real part of 𝑋5
 wire signed [15:0] out5_imag_e; // Output 16-bit imaginary part of 𝑋5
 wire signed [15:0] out6_real_e; // Output 16-bit real part of 𝑋6
 wire signed [15:0] out6_imag_e; // Output 16-bit imaginary part of 𝑋6
 wire signed [15:0] out7_real_e; // Output 16-bit real part of 𝑋7
 wire signed [15:0] out7_imag_e; // Output 16-bit imaginary part of 𝑋7
 

	initial begin
		sys_clk=1'b0;
	end
	
	// System clock generator
	always begin
		#(CLOCK_PERIOD/2) sys_clk = ~sys_clk;
	end


	initial begin
	    	sys_clk = 1'b0; sys_rst_n = 1'b0;
        	// en_a = 1'b0; en_b = 1'b0;
		// state = 4'h0;
		write = 1'b0; start = 1'b0;
        	test_err = 0; test_count = 0;
		#CLOCK_PERIOD sys_rst_n = 1'b1;
		#(CLOCK_PERIOD/2) $display("START OF SIMULATION (Time: %g ns)", $time);

		
	//assigning input values
	in0_real =16'd0000 ; // Input 16-bit real part of 𝑥0
    in0_imag =16'd0000; // Input 16-bit imaginary part of 𝑥0
    in1_real =16'd0001; // Input 16-bit real part of 𝑥1
    in1_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥1
    in2_real =16'd0002 ; // Input 16-bit real part of 𝑥2
    in2_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥2
   in3_real =16'd0003 ; // Input 16-bit real part of 𝑥3
in3_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥3
in4_real =16'd0004 ; // Input 16-bit real part of 𝑥4
in4_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥4
in5_real =16'd0005 ; // Input 16-bit real part of 𝑥5
in5_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥5
in6_real =16'd0006 ; // Input 16-bit real part of 𝑥6
in6_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥6
in7_real =16'd0007 ; // Input 16-bit real part of 𝑥7
in7_imag =16'd0000 ; // Input 16-bit imaginary part of 𝑥7


///SECOND 



    	end



	// wire [256:0] s_out, s_golden;
	wire ready;
// 
	event terminate_sim;
 eight_point_fft u_DUT (
	.CLK(sys_clk),
    .RST_N(sys_rst_n),
   .write(write), 
   .start(start), 
   .ready(ready),
   .in0_real(in0_real),
   .in0_imag(in0_imag),
   .in1_real(in1_real),
   .in1_imag(in1_imag),-
   .in2_real(in2_real),
   .in2_imag(in2_imag),
   .in3_real(in3_real),
   .in3_imag(in3_imag),
   .in4_real(in4_real),
   .in4_imag(in4_imag),
   .in5_real(in5_real),
   .in5_imag(in5_imag),
   .in6_real(in6_real),
   .in6_imag(in6_imag),
   .in7_real(in7_real),.in7_imag(in7_imag),
.out0_real(out0_real),.out0_imag(out0_imag),.out1_real(out1_real),.out1_imag(out1_imag),.out2_real(out2_real),.out2_imag(out2_imag),.out3_real(out3_real),.out3_imag(out3_imag),.out4_real(out4_real),.out4_imag(out4_imag),.out5_real(out5_real),.out5_imag(out5_imag),.out6_real(out6_real),.out6_imag(out6_imag),.out7_real(out7_real),.out7_imag(out7_imag)
 );
	// assign s_golden = {1'b0, a} + {1'b0, b};

	


	// VCD dump
	initial begin
		$dumpfile("eight_point_fft_test.vcd");//for first one 
		//$dumpfile("mpadd2.vcd");
		$dumpvars(0, u_DUT);
	end


endmodule
