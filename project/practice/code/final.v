`timescale 1ns/1ps

/*********************************** twos complement of signed 16-bit numbers******************************************************/

module twos_complement(in,out);
  input [15:0] in;
  output [15:0] out;
  reg signed [15:0] out;
  reg signed [14:0] y;

  always @* begin
    if(in[15]==1'b1) begin
      y = ~(in)+1'b1;
      out = {1'b1,y};
    end
    else begin
      out <= in;
    end
  end

endmodule


/********************************inverse twos complement of signed 16-bit numbers***************************************************/

module inv_two(in ,out);
input [15:0] in;
output [15:0] out;
wire signed [15:0] in;
reg [14:0] y;
  reg [15:0] out;
  
  always @* begin
  if (in[15]==1) begin
    y = in-1;
    out = {1'b1,~y};
  end
  else begin
    out = in;
  end
  end

endmodule


/********************************************to show value in decimal value ,run in sep***********/
// module to_decimal;
  
//   reg signed [15:0] out0_real=16'b0001110000000000;
//   reg signed [15:0] out1_real=16'b1000010000000000;
//   reg signed [15:0] out2_real=16'b1000010000000000;
//   reg signed [15:0] out3_real=16'b1000010000000000; 
//   reg signed [15:0] out4_real=16'b1000010000000000;
//   reg signed [15:0] out5_real=16'b1000010000000000;
//   reg signed [15:0] out6_real=16'b1000010000000000;
//   reg signed [15:0] out7_real=16'b1000010000000000;
  
//   reg signed [15:0] out0_imag=16'b0000000000000000; 
//   reg signed [15:0] out1_imag=16'b0000100110101000; 
//   reg signed [15:0] out2_imag=16'b0000010000000000; 
//   reg signed [15:0] out3_imag=16'b0000000110101000; 
//   reg signed [15:0] out4_imag=16'b0000000000000000; 
//   reg signed [15:0] out5_imag=16'b1000000110101000; 
//   reg signed [15:0] out6_imag=16'b1000010000000000; 
//   reg signed [15:0] out7_imag=16'b1000100110101000; 



//   initial begin
//   $display("real part =%f and imaginary part=(%f) ",out0_real*2.0**-8,out0_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out1_real*2.0**-8,out1_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out2_real*2.0**-8,out2_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out3_real*2.0**-8,out3_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out4_real*2.0**-8,out4_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out5_real*2.0**-8,out5_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out6_real*2.0**-8,out6_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out7_real*2.0**-8,out7_imag*2.0**-8);
	 
	 
//    end

//  endmodule




/***********************************main code******************************************************/

module eight_point_fft(CLK, RST_N, in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag, out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag  ,write, start, ready);

input CLK, RST_N, write, start;
input [15:0] in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag;
output [15:0] out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag;
output ready;

reg ready;

wire [15:0] in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag;
reg [15:0] out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag;
wire signed [15:0] in0_r, in1_r, in2_r, in3_r, in4_r, in5_r, in6_r, in7_r, in0_i, in1_i, in2_i, in3_i, in4_i, in5_i, in6_i, in7_i;
reg signed [15:0] x0_r, x1_r, x2_r, x3_r, x4_r, x5_r, x6_r, x7_r, x0_i, x1_i, x2_i, x3_i, x4_i, x5_i, x6_i, x7_i;
wire signed [15:0] e0_r, e1_r, e2_r, e3_r, e4_r, e5_r, e6_r, e7_r, e0_i, e1_i, e2_i, e3_i, e4_i, e5_i, e6_i, e7_i;
reg signed [15:0] X0_r, X1_r, X2_r, X3_r, X4_r, X5_r, X6_r, X7_r, X0_i, X1_i, X2_i, X3_i, X4_i, X5_i, X6_i, X7_i;
wire [15:0] out0_r, out1_r, out2_r, out3_r, out4_r, out5_r, out6_r, out7_r, out0_i, out1_i, out2_i, out3_i, out4_i, out5_i, out6_i, out7_i;
wire [15:0] twiddle_factor;
// We need to convert the signed 16-bit fixed point quantity inputs into their 2's complement

twos_complement two0(in0_real,in0_r);
twos_complement two1(in1_real,in1_r);
twos_complement two2(in2_real,in2_r);
twos_complement two3(in3_real,in3_r);
twos_complement two4(in4_real,in4_r);
twos_complement two5(in5_real,in5_r);
twos_complement two6(in6_real,in6_r);
twos_complement two7(in7_real,in7_r);
twos_complement two8(in0_imag,in0_i);
twos_complement two9(in1_imag,in1_i);
twos_complement two10(in2_imag,in2_i);
twos_complement two11(in3_imag,in3_i);
twos_complement two12(in4_imag,in4_i);
twos_complement two13(in5_imag,in5_i);
twos_complement two14(in6_imag,in6_i);
twos_complement two15(in7_imag,in7_i);

// We need to convert the  2's complement output values  into their signed 16-bit fixed point quantity 
/**************comment this block when you want that in two complement ***********/
inv_two invTwo0(X0_r,out0_r);
inv_two invTwo1(X1_r,out1_r);
inv_two invTwo2(X2_r,out2_r);
inv_two invTwo3(X3_r,out3_r);
inv_two invTwo4(X4_r,out4_r);
inv_two invTwo5(X5_r,out5_r);
inv_two invTwo6(X6_r,out6_r);
inv_two invTwo7(X7_r,out7_r);
inv_two invTwo8(X0_i,out0_i);
inv_two invTwo9(X1_i,out1_i);
inv_two invTwo10(X2_i,out2_i);
inv_two invTwo11(X3_i,out3_i);
inv_two invTwo12(X4_i,out4_i);
inv_two invTwo13(X5_i,out5_i);
inv_two invTwo14(X6_i,out6_i);
inv_two invTwo15(X7_i,out7_i);


// twos_complement invTwo0(X0_r,out0_r);
// twos_complement invTwo1(X1_r,out1_r);
// twos_complement invTwo2(X2_r,out2_r);
// twos_complement invTwo3(X3_r,out3_r);
// twos_complement invTwo4(X4_r,out4_r);
// twos_complement invTwo5(X5_r,out5_r);
// twos_complement invTwo6(X6_r,out6_r);
// twos_complement invTwo7(X7_r,out7_r);
// twos_complement invTwo8(X0_i,out0_i);
// twos_complement invTwo9(X1_i,out1_i);
// twos_complement invTwo10(X2_i,out2_i);
// twos_complement invTwo11(X3_i,out3_i);
// twos_complement invTwo12(X4_i,out4_i);
// twos_complement invTwo13(X5_i,out5_i);
// twos_complement invTwo14(X6_i,out6_i);
// twos_complement invTwo15(X7_i,out7_i);

// DIVIDE AND CONQUER APPROACH
// We will calculate  8-point FFT using 2 radix 4-point DFT  of even sequences and odd sequences and proceed

// 4-POINT DFT IS GIVEN AS :

// X(0) = x(0) +  x(1) + x(2) +  x(3)
// X(1) = x(0) - jx(1) + x(2) + jx(3)
// X(2) = x(0) - x(1)  + x(2) -  x(3)
// X(3) = x(0) - jx(1) + x(2) + jx(3)

// 4-POINT DFT OF x[0], x[2], x[4] & x[6] WILL BE :

assign e0_r = x0_r + x2_r + x4_r + x6_r;
assign e0_i = x0_i + x2_i + x4_i + x6_i;

assign e1_r = x0_r + x2_i - x4_r - x6_i;
assign e1_i = x0_i - x2_r - x4_i + x6_r;

assign e2_r = x0_r - x2_r + x4_r - x6_r;
assign e2_i = x0_i - x2_i + x4_i - x6_i;

assign e3_r = x0_r - x2_i - x4_r + x6_i;
assign e3_i = x0_i + x2_r - x4_i - x6_r;


// 4-POINT DFT OF x[1], x[3], x[5] & x[7] WILL BE :

assign e4_r = x1_r + x3_r + x5_r + x7_r;
assign e4_i = x1_i + x3_i + x5_i + x7_i;

assign e5_r = x1_r + x3_i - x5_r - x7_i;
assign e5_i = x1_i - x3_r - x5_i + x7_r;

assign e6_r = x1_r - x3_r + x5_r - x7_r;
assign e6_i = x1_i - x3_i + x5_i - x7_i;

assign e7_r = x1_r - x3_i - x5_r + x7_i;
assign e7_i = x1_i + x3_r - x5_i - x7_r;

// localparam w18_stage3_1=16'b0000000101001010;
// reg signed [15:0] w18_stage3_1=0.707;
// 0000000010110100

// twos_complement twiddle(w18_stage3_1,twiddle_factor);

always @(posedge CLK) begin
if (~RST_N) begin
	ready <= 1'b0;
end
else begin
	if (write) begin

    // 2's complement of the inputs are given to x
		x0_r <= in0_r;
		x1_r <= in1_r;
		x2_r <= in2_r;
		x3_r <= in3_r;
		x4_r <= in4_r;
		x5_r <= in5_r;
		x6_r <= in6_r;
		x7_r <= in7_r;
		
		x0_i <= in0_i;
		x1_i <= in1_i;
		x2_i <= in2_i;
		x3_i <= in3_i;
		x4_i <= in4_i;
		x5_i <= in5_i;
		x6_i <= in6_i;
		x7_i <= in7_i;
	end
	
	if (start) begin
                
                // The outputs from radix4-point DFT in stage 1 are given as inputs in 2nd stage 

		            X0_r <= e0_r + e4_r;
                X0_i <= e0_i + e4_i;

                 X1_r <= e1_r + ((e5_r>>>1)+(e5_r>>>3)+(e5_r>>>4)+(e5_r>>>6)+(e5_r>>>8)) + ((e5_i>>>1)+(e5_i>>>3)+(e5_i>>>4)+(e5_i>>>6)+(e5_i>>>8));
                 X1_i <= e1_i + ((e5_i>>>1)+(e5_i>>>3)+(e5_i>>>4)+(e5_i>>>6)+(e5_i>>>8)) - ((e5_r>>>1)+(e5_r>>>3)+(e5_r>>>4)+(e5_r>>>6)+(e5_r>>>8));
				
		            // X1_r <= e1_r +(e5_r)*(w18_stage3_1) +(e5_i)*(w18_stage3_1);
                // X1_i <= e1_i + (e5_i*w18_stage3_1)  - (e5_r*w18_stage3_1);
                // $monitor("X1_i = %b \n w18_stage3_1 = %b ", X1_i,w18_stage3_1);
                // $monitor("twiddle_factor = %b \n w18_stage3_1 = %b ", twiddle_factor,w18_stage3_1);

                X2_r <= e2_r + e6_i;
                X2_i <= e2_i - e6_r;

                X3_r <= e3_r - ((e7_r>>>1)+(e7_r>>>3)+(e7_r>>>4)+(e7_r>>>6)+(e7_r>>>8)) + ((e7_i>>>1)+(e7_i>>>3)+(e7_i>>>4)+(e7_i>>>6)+(e7_i>>>8));
                X3_i <= e3_i - ((e7_i>>>1)+(e7_i>>>3)+(e7_i>>>4)+(e7_i>>>6)+(e7_i>>>8)) - ((e7_r>>>1)+(e7_r>>>3)+(e7_r>>>4)+(e7_r>>>6)+(e7_r>>>8));
				
                // X3_r <= e3_r - (e7_r*w18_stage3_1) + (e7_i*w18_stage3_1);
                // X3_i <= e3_i - (e7_i*w18_stage3_1) - (e7_r*w18_stage3_1);

                X4_r <= e0_r - e4_r;
                X4_i <= e0_i - e4_i;

                X5_r <= e1_r - ((e5_r>>>1)+(e5_r>>>3)+(e5_r>>>4)+(e5_r>>>6)+(e5_r>>>8)) - ((e5_i>>>1)+(e5_i>>>3)+(e5_i>>>4)+(e5_i>>>6)+(e5_i>>>8));
                X5_i <= e1_i - ((e5_i>>>1)+(e5_i>>>3)+(e5_i>>>4)+(e5_i>>>6)+(e5_i>>>8)) + ((e5_r>>>1)+(e5_r>>>3)+(e5_r>>>4)+(e5_r>>>6)+(e5_r>>>8));

                // X5_r <= e1_r - (e5_r*w18_stage3_1) - (e5_i*w18_stage3_1);
                // X5_i <= e1_i - (e5_i*w18_stage3_1) + (e5_r*w18_stage3_1);

                X6_r <= e2_r - e6_i;
                X6_i <= e2_i + e6_r;

                X7_r <= e3_r + ((e7_r>>>1)+(e7_r>>>3)+(e7_r>>>4)+(e7_r>>>6)+(e7_r>>>8)) - ((e7_i>>>1)+(e7_i>>>3)+(e7_i>>>4)+(e7_i>>>6)+(e7_i>>>8));
                X7_i <= e3_i + ((e7_i>>>1)+(e7_i>>>3)+(e7_i>>>4)+(e7_i>>>6)+(e7_i>>>8)) + ((e7_r>>>1)+(e7_r>>>3)+(e7_r>>>4)+(e7_r>>>6)+(e7_r>>>8));

                // X7_r <= e3_r + (e7_r*w18_stage3_1) - (e7_i*w18_stage3_1);
                // X7_i <= e3_i + (e7_i*w18_stage3_1) + (e7_i*w18_stage3_1);

		// inverse 2's complement of the outputs X of FFT are given to output
/***uncomment for usual sign bit notations  and comment when you want in twos complement form for decimal conversion****************************************/
    out0_real = out0_r;
		out0_imag = out0_i;
		out1_real = out1_r;
		out1_imag = out1_i;
		out2_real = out2_r;
		out2_imag = out2_i;
		out3_real = out3_r;
		out3_imag = out3_i;
		out4_real = out4_r;
		out4_imag = out4_i;
		out5_real = out5_r;
		out5_imag = out5_i;
		out6_real = out6_r;
		out6_imag = out6_i;
		out7_real = out7_r;
		out7_imag = out7_i;

/**uncomment  for getting result in two complment form to convert into decimal form and comment when for usual sign bit notations***/
                // out0_real = b1_r;
                // out0_imag = b1_i;
                // out1_real = b2_r;
                // out1_imag = b2_i;
                // out2_real = b3_r;
                // out2_imag = b3_i;
                // out3_real = b4_r;
                // out3_imag = b4_i;
                // out4_real = b5_r;
                // out4_imag = b5_i;
                // out5_real = b6_r;
                // out5_imag = b6_i;
                // out6_real = b7_r;
                // out6_imag = b7_i;
                // out7_real = b8_r;
                // out7_imag = b8_i;  

		ready = 1'b1;
	end
end
end
endmodule
	


/***********************************test bench starting ****************************************/

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

                //1st sample 0,1,2,3,4,5,6,7
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
	
        //2nd input sample 1,2,3,4,5,6,7,8
           	// IN0_real <= 16'b0000000100000000;
		// IN0_imag <= 16'b0000000000000000;
		// IN1_real <= 16'b0000001000000000;
		// IN1_imag <= 16'b0000000000000000;
		// IN2_real <= 16'b0000001100000000;
		// IN2_imag <= 16'b0000000000000000;
		// IN3_real <= 16'b0000010000000000;
		// IN3_imag <= 16'b0000000000000000;
		// IN4_real <= 16'b0000010100000000;
		// IN4_imag <= 16'b0000000000000000;
		// IN5_real <= 16'b0000011000000000;
		// IN5_imag <= 16'b0000000000000000;
		// IN6_real <= 16'b0000011100000000;
		// IN6_imag <= 16'b0000000000000000;
		// IN7_real <= 16'b0000100000000000;
		// IN7_imag <= 16'b0000000000000000;
        //3rd input sample 1+1j,2+2j,3+3j,4+4j,5+5j,6+6J,7+7J,8+8J
  	// IN0_real <= 16'b0000000100000000;
		// IN0_imag <= 16'b0000000100000000;
		// IN1_real <= 16'b0000001000000000;
		// IN1_imag <= 16'b0000001000000000;
		// IN2_real <= 16'b0000001100000000;
		// IN2_imag <= 16'b0000001100000000;
		// IN3_real <= 16'b0000010000000000;
		// IN3_imag <= 16'b0000010000000000;
		// IN4_real <= 16'b0000010100000000;
		// IN4_imag <= 16'b0000010100000000;
		// IN5_real <= 16'b0000011000000000;
		// IN5_imag <= 16'b0000011000000000;
		// IN6_real <= 16'b0000011100000000;
		// IN6_imag <= 16'b0000011100000000;
		// IN7_real <= 16'b0000100000000000;
		// IN7_imag <= 16'b0000100000000000;


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
                $dumpfile("eight_point_fft_tb1.vcd");
                $dumpvars(0, u_DUT);
                $monitor("Time: %t \n out0_real = %b , out0_imag = %b \n out1_real = %b , out1_imag = %b \n out2_real = %b , out2_imag = %b \n out3_real = %b , out3_imag = %b \n out4_real = %b , out4_imag = %b \n out5_real = %b , out5_imag = %b \n out6_real = %b , out6_imag = %b \n out7_real = %b , out7_imag = %b \n ready = %b ", $time,OUT0_real,OUT0_imag, OUT1_real, OUT1_imag, OUT2_real, OUT2_imag, OUT3_real, OUT3_imag, OUT4_real, OUT4_imag, OUT5_real, OUT5_imag, OUT6_real, OUT6_imag, OUT7_real, OUT7_imag, ready);
        end

endmodule

                                 
