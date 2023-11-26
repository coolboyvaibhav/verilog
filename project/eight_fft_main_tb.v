`timescale 1ns/1ps

module eight_point_fft_tb;
	
	reg clk, rst_n, start, write;
	reg [15:0] IN1_real, IN1_imag, IN2_real, IN2_imag, IN3_real, IN3_imag, IN4_real, IN4_imag, IN5_real, IN5_imag, IN6_real, IN6_imag, IN7_real, IN7_imag, IN8_real, IN8_imag;
	wire signed [15:0] OUT1_real, OUT1_imag, OUT2_real, OUT2_imag, OUT3_real, OUT3_imag, OUT4_real, OUT4_imag, OUT5_real, OUT5_imag, OUT6_real, OUT6_imag, OUT7_real, OUT7_imag, OUT8_real, OUT8_imag;
	wire ready;

	eight_point_fft u_DUT(.CLK(clk), .RST_N(rst_n),
    .in0_real(in0_real),.in0_imag(in0_imag), .in1_real(in1_real), .in1_imag(in1_imag), .in2_real(in2_real), .in2_imag(in2_imag), .in3_real(in3_real), .in3_imag(in3_imag), .in4_real(in4_real), .in4_imag(in4_imag), .in5_real(in5_real), .in5_imag(in5_imag), .in6_real(in6_real), .in6_imag(in6_imag), .in7_real(in7_real), .in7_imag(in7_imag), 
    .out0_real(out0_real),.out0_imag(out0_imag),.out1_real(out1_real), .out1_imag(out1_imag), .out2_real(out2_real), .out2_imag(out2_imag), .out3_real(out3_real), .out3_imag(out3_imag), .out4_real(out4_real), .out4_imag(out4_imag), .out5_real(out5_real), .out5_imag(out5_imag), .out6_real(out6_real), .out6_imag(out6_imag), .out7_real(out7_real), .out7_imag(out7_imag),
    .write(write), .start(start), .ready(ready));

	initial begin
		in0_real <= 16'b0000000000000000;
		in0_imag <= 16'b0000000000000000;
		in1_real <= 16'b0000000100000000;
		in1_imag <= 16'b0000000000000000;
		in2_real <= 16'b0000001000000000;
		in2_imag <= 16'b0000000000000000;
		in3_real <= 16'b0000001100000000;
		in3_imag <= 16'b0000000000000000;
		in4_real <= 16'b0000010000000000;
		in4_imag <= 16'b0000000000000000;
		in5_real <= 16'b0000010100000000;
		in5_imag <= 16'b0000000000000000;
		in6_real <= 16'b0000011000000000;
		in6_imag <= 16'b0000000000000000;
		in7_real <= 16'b0000011100000000;
		in7_imag <= 16'b0000000000000000;
	
		clk = 0;

		rst_n = 1;
		#20
		rst_n = 0;
		#15 rst_n = 1;
		write = 1'b1;
//		$display("%d",write);
		
		#5 write = 1'b0;
		#10 start = 1'b1;
//		#5 start = 0;
		#110000 $finish;
	end
	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		$dumpfile("eight_point_fft_tb.vcd");
		$dumpvars(0, u_DUT);
//		$display("%b",clk);
//		$display("%b",rst_n);
//		$display("%b",ready);
//		$display("%d,%d",IN1_real,IN1_imag);
//		$display("%d,%d",OUT2_real,OUT2_imag);
//		$display("%d,%d",OUT3_real,OUT3_imag);
//		$display("%d,%d",OUT4_real,OUT4_imag);
//		$display("%d,%d",OUT5_real,OUT5_imag);
//		$display("%d,%d",OUT6_real,OUT6_imag);
//		$display("%d,%d",OUT7_real,OUT7_imag);
//		$display("%d,%d",OUT8_real,OUT8_imag);
		// $monitor("Time: %t \n out1_r = %b , out1_i = %b \n out2_r = %b , out2_i = %b \n out3_r = %b , out3_i = %b \n out4_r = %b , out4_i = %b \n out5_r = %b , out5_i = %b \n out6_r = %b , out6_i = %b \n out7_r = %b , out7_i = %b \n out8_r = %b , out8_i = %b \n ready = %b ", $time, OUT1_real, OUT1_imag, OUT2_real, OUT2_imag, OUT3_real, OUT3_imag, OUT4_real, OUT4_imag, OUT5_real, OUT5_imag, OUT6_real, OUT6_imag, OUT7_real, OUT7_imag, OUT8_real, OUT8_imag, ready);
        
		$monitor("Time: %t \n out0_real = %b , out0_imag = %b \n out1_real = %b , out1_imag = %b \n out2_real = %b , out2_imag = %b \n out3_real = %b , out3_imag = %b \n out4_real = %b , out4_imag = %b \n out5_real = %b , out5_imag = %b \n out6_real = %b , out6_imag = %b \n out7_real = %b , out8_i = %b \n ready = %b ", $time, out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag, ready);
	end
	
endmodule
 
