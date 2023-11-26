

`timescale 1ns/1ps

module eight_point_fft_tb;

        reg clk, rst_n, start, write;
        reg [15:0] IN0_real, IN0_imag,IN1_real, IN1_imag, IN2_real, IN2_imag, IN3_real, IN3_imag, IN4_real, IN4_imag, IN5_real, IN5_imag, IN6_real, IN6_imag, IN7_real, IN7_imag;
        wire signed [15:0] OUT0_real, OUT0_imag,OUT1_real, OUT1_imag, OUT2_real, OUT2_imag, OUT3_real, OUT3_imag, OUT4_real, OUT4_imag, OUT5_real, OUT5_imag, OUT6_real, OUT6_imag, OUT7_real, OUT7_imag;
        wire ready;

        eight_point_fft u_DUT(.CLK(clk), .RST_N(rst_n),
    .in0_real(IN0_real),.in0_imag(IN0_imag), .in1_real(IN1_real), .in1_imag(IN1_imag), .in2_real(IN2_real), .in2_imag(IN2_imag), .in3_real(IN3_real), .in3_imag(IN3_imag), .in4_real(IN4_real), .in4_imag(IN4_imag), .in5_real(IN5_real), .in5_imag(IN5_imag), .in6_real(IN6_real), .in6_imag(IN6_imag), .in7_real(IN7_real), .in7_imag(IN7_imag),
    .out0_real(OUT0_real),.out0_imag(OUT0_imag),.out1_real(OUT1_real), .out1_imag(OUT1_imag), .out2_real(OUT2_real), .out2_imag(OUT2_imag), .out3_real(OUT3_real), .out3_imag(OUT3_imag), .out4_real(OUT4_real), .out4_imag(OUT4_imag), .out5_real(OUT5_real), .out5_imag(OUT5_imag), .out6_real(OUT6_real), .out6_imag(OUT6_imag), .out7_real(OUT7_real), .out7_imag(OUT7_imag),
    .write(write), .start(start), .ready(ready));

	initial begin
		IN0_real <= 16'b0000000000000000;
		IN0_imag <= 16'b0000000000000000;
		IN1_real <= 16'b0000000100000000;
		IN1_imag <= 16'b0000000000000000;
		IN2_real <= 16'b0000001000000000;
		IN2_imag <= 16'b0000000000000000;
		IN3_real <= 16'b0000001100000000;
		IN3_imag <= 16'b0000000000000000;
		IN4_real <= 16'b0000010000000000;
		IN4_imag <= 16'b0000000000000000;
		IN5_real <= 16'b0000010100000000;
		IN5_imag <= 16'b0000000000000000;
		IN6_real <= 16'b0000011000000000;
		IN6_imag <= 16'b0000000000000000;
		IN7_real <= 16'b0000011100000000;
		IN7_imag <= 16'b0000000000000000;
	
                clk = 0;

                rst_n = 1;
                #20
                rst_n = 0;
                #15 rst_n = 1;
                write = 1'b1;
//              $display("%d",write);

                #5 write = 1'b0;
                #10 start = 1'b1;
//              #5 start = 0;
                #110000 $finish;
        end
        always begin
                #5 clk = ~clk;
        end

        initial begin
                $dumpfile("eight_point_fft_tb.vcd");
                $dumpvars(0, u_DUT);
                $monitor("Time: %t \n out0_real = %b , out0_imag = %b \n out1_real = %b , out1_imag = %b \n out2_real = %b , out2_imag = %b \n out3_real = %b , out3_imag = %b \n out4_real = %b , out4_imag = %b \n out5_real = %b , out5_imag = %b \n out6_real = %b , out6_imag = %b \n out7_real = %b , out7_i = %b \n ready = %b ", $time,OUT0_real,OUT0_imag, OUT1_real, OUT1_imag, OUT2_real, OUT2_imag, OUT3_real, OUT3_imag, OUT4_real, OUT4_imag, OUT5_real, OUT5_imag, OUT6_real, OUT6_imag, OUT7_real, OUT7_imag, ready);
        end

endmodule

   