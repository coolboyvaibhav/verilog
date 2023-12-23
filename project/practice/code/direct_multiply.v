// Code your design here
`timescale 1ns/1ps
//`default_nettype none

/******************************************** twos complemement***********/

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
      out = in;
    end
  end

endmodule


/********************************************inverse twos complemement***********/

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

/********************************************to show value in decimal value***********/
// module show_decimal_value(
//     in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag
// );
    
//     input [15:0] in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag;
//     //output [15:0] out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag;
//   reg signed [15:0] out0_real<=in0_real;
//   reg signed [15:0] out1_real<=in1_real;
//   reg signed [15:0] out2_real<=in2_real;
//   reg signed [15:0] out3_real<=in3_real; 
//   reg signed [15:0] out4_real<=in4_real;
//   reg signed [15:0] out5_real<=in5_real;
//   reg signed [15:0] out6_real<=in6_real;
//   reg signed [15:0] out7_real<=in7_real;
							 
//   reg signed [15:0] out0_imag<=in0_imag; 
//   reg signed [15:0] out1_imag<=in1_imag; 
//   reg signed [15:0] out2_imag<=in2_imag; 
//   reg signed [15:0] out3_imag<=in3_imag; 
//   reg signed [15:0] out4_imag<=in4_imag; 
//   reg signed [15:0] out5_imag<=in5_imag; 
//   reg signed [15:0] out6_imag<=in6_imag; 
//   reg signed [15:0] out7_imag<=in7_imag; 



//     initial begin
//      $display("real part =%f and imaginary part=(%f) ",out0_real*2.0**-8,out0_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out1_real*2.0**-8,out1_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out2_real*2.0**-8,out2_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out3_real*2.0**-8,out3_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out4_real*2.0**-8,out4_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out5_real*2.0**-8,out5_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out6_real*2.0**-8,out6_imag*2.0**-8);
// 	 $display("real part =%f and imaginary part=(%f) ",out7_real*2.0**-8,out7_imag*2.0**-8); 
//    end

// endmodule






/**************main code ***********/
module eight_point_fft(CLK, RST_N, in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag, out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag  ,write, start, ready);

input CLK, RST_N, write, start;
input [15:0] in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag;
output [15:0] out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag;
output ready;

reg ready;

wire [15:0] in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag;
reg [15:0] out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag;
wire signed [15:0] t1_r, t2_r, t3_r, t4_r, t5_r, t6_r, t7_r, t8_r, t1_i, t2_i, t3_i, t4_i, t5_i, t6_i, t7_i, t8_i;
wire signed [15:0] y1_r, y2_r, y3_r, y4_r, y5_r, y6_r, y7_r, y8_r, y1_i, y2_i, y3_i, y4_i, y5_i, y6_i, y7_i, y8_i;
wire [15:0] c1_r, c2_r, c3_r, c4_r, c5_r, c6_r, c7_r, c8_r, c1_i, c2_i, c3_i, c4_i, c5_i, c6_i, c7_i, c8_i;
reg signed [15:0] a1_r, a2_r, a3_r, a4_r, a5_r, a6_r, a7_r, a8_r, a1_i, a2_i, a3_i, a4_i, a5_i, a6_i, a7_i, a8_i;
reg signed [15:0] b1_r, b2_r, b3_r, b4_r, b5_r, b6_r, b7_r, b8_r, b1_i, b2_i, b3_i, b4_i, b5_i, b6_i, b7_i, b8_i;

twos_complement two0(in0_real,t1_r);
twos_complement two1(in1_real,t2_r);
twos_complement two2(in2_real,t3_r);
twos_complement two3(in3_real,t4_r);
twos_complement two4(in4_real,t5_r);
twos_complement two5(in5_real,t6_r);
twos_complement two6(in6_real,t7_r);
twos_complement two7(in7_real,t8_r);
twos_complement two8(in0_imag,t1_i);
twos_complement two9(in1_imag,t2_i);
twos_complement two10(in2_imag,t3_i);
twos_complement two11(in3_imag,t4_i);
twos_complement two12(in4_imag,t5_i);
twos_complement two13(in5_imag,t6_i);
twos_complement two14(in6_imag,t7_i);
twos_complement two15(in7_imag,t8_i);


/**************comment this block when you want that in two complement ***********/
inv_two invTwo0(b1_r,c1_r);
inv_two invTwo1(b2_r,c2_r);
inv_two invTwo2(b3_r,c3_r);
inv_two invTwo3(b4_r,c4_r);
inv_two invTwo4(b5_r,c5_r);
inv_two invTwo5(b6_r,c6_r);
inv_two invTwo6(b7_r,c7_r);
inv_two invTwo7(b8_r,c8_r);
inv_two invTwo8(b1_i,c1_i);
inv_two invTwo9(b2_i,c2_i);
inv_two invTwo10(b3_i,c3_i);
inv_two invTwo11(b4_i,c4_i);
inv_two invTwo12(b5_i,c5_i);
inv_two invTwo13(b6_i,c6_i);
inv_two invTwo14(b7_i,c7_i);
inv_two invTwo15(b8_i,c8_i);


// X(0) = x(1) +  x(2) + x(3) +  x(4)
// X(0) = x(1) - jx(2) + x(3) + jx(4)
// X(0) = x(1) - x(2) + x(3)  -  x(4)
// X(0) = x(1) - jx(2) + x(3) + jx(4)

//stage all real parts and imaginary added
assign y1_r = a1_r + a3_r + a5_r + a7_r;
assign y1_i = a1_i + a3_i + a5_i + a7_i;

//real part=real of first +imaginary of 2nd -real of 3rd -imaginary of 4th
//imaginary part=real part of 4th +imaginary of first -real of 2nd -imaginary of 3rd
assign y2_r = a1_r + a3_i - a5_r - a7_i;
assign y2_i = a1_i - a3_r - a5_i + a7_r;

//real part=real of first -real of 2nd +real of 3rd -real of 4th
//imaginary part=imaginary of first -imaginary of 2nd +imaginary of 3rd -imaginary of 4th
assign y3_r = a1_r - a3_r + a5_r - a7_r;
assign y3_i = a1_i - a3_i + a5_i - a7_i;


//real part=real of first -imaginary of 2nd -real of 3rd +imaginary of 4th
//imaginary part=imaginary of first +real of 2nd - imaginary of 3rd -real of 4th
assign y4_r = a1_r - a3_i - a5_r + a7_i;
assign y4_i = a1_i + a3_r - a5_i - a7_r;


///////////
//stage all real parts and imaginary added
assign y5_r = a2_r + a4_r + a6_r + a8_r;
assign y5_i = a2_i + a4_i + a6_i + a8_i;

//real part=real of first +imaginary of 2nd -real of 3rd -imaginary of 4th
//imaginary part=real part of 4th +imaginary of first -real of 2nd -imaginary of 3rd
assign y6_r = a2_r + a4_i - a6_r - a8_i;
assign y6_i = a2_i - a4_r - a6_i + a8_r;

//real part=real of first -real of 2nd +real of 3rd -real of 4th
//imaginary part=imaginary of first -imaginary of 2nd +imaginary of 3rd -imaginary of 4th
assign y7_r = a2_r - a4_r + a6_r - a8_r;
assign y7_i = a2_i - a4_i + a6_i - a8_i;


//real part=real of first -imaginary of 2nd -real of 3rd +imaginary of 4th
//imaginary part=imaginary of first +real of 2nd - imaginary of 3rd -real of 4th
assign y8_r = a2_r - a4_i - a6_r + a8_i;
assign y8_i = a2_i + a4_r - a6_i - a8_r;
// ////

always @(posedge CLK) begin
if (~RST_N) begin
        ready <= 1'b0;
end
else begin
        if (write) begin
                a1_r <= t1_r;
                a2_r <= t2_r;
                a3_r <= t3_r;
                a4_r <= t4_r;
                a5_r <= t5_r;
                a6_r <= t6_r;
                a7_r <= t7_r;
                a8_r <= t8_r;

                a1_i <= t1_i;
                a2_i <= t2_i;
                a3_i <= t3_i;
                a4_i <= t4_i;
                a5_i <= t5_i;
                a6_i <= t6_i;
                a7_i <= t7_i;
                a8_i <= t8_i;
        end

        if (start) begin
                b1_r <= y1_r + y5_r;
                b1_i <= y1_i + y5_i;

//                 b2_r <= y2_r + ((y6_r>>>1)+(y6_r>>>3)+(y6_r>>>4)+(y6_r>>>6)+(y6_r>>>8)) + ((y6_i>>>1)+(y6_i>>>3)+(y6_i>>>4)+(y6_i>>>6)+(y6_i>>>8));
//                 b2_i <= y2_i + ((y6_i>>>1)+(y6_i>>>3)+(y6_i>>>4)+(y6_i>>>6)+(y6_i>>>8)) - ((y6_r>>>1)+(y6_r>>>3)+(y6_r>>>4)+(y6_r>>>6)+(y6_r>>>8));

          
                b2_r<= y2_r +y6_r*0.707+y6_i*0.707;
                b2_i<= y2_i +y6_i*0.707-y6_r*0.707;
          
          
          
                b3_r <= y3_r + y7_i;
                b3_i <= y3_i - y7_r;

//                 b4_r <= y4_r - ((y8_r>>>1)+(y8_r>>>3)+(y8_r>>>4)+(y8_r>>>6)+(y8_r>>>8)) + ((y8_i>>>1)+(y8_i>>>3)+(y8_i>>>4)+(y8_i>>>6)+(y8_i>>>8));
//                 b4_i <= y4_i - ((y8_i>>>1)+(y8_i>>>3)+(y8_i>>>4)+(y8_i>>>6)+(y8_i>>>8)) - ((y8_r>>>1)+(y8_r>>>3)+(y8_r>>>4)+(y8_r>>>6)+(y8_r>>>8));
           b4_r <= y4_r - y8_r*0.707 +y8_i*0.707;
                b4_i <= y4_i - y8_i*0.707 - y8_r*0.707;
          
          

                b5_r <= y1_r - y5_r;
                b5_i <= y1_i - y5_i;

//                 b6_r <= y2_r - ((y6_r>>>1)+(y6_r>>>3)+(y6_r>>>4)+(y6_r>>>6)+(y6_r>>>8)) - ((y6_i>>>1)+(y6_i>>>3)+(y6_i>>>4)+(y6_i>>>6)+(y6_i>>>8));
//                 b6_i <= y2_i - ((y6_i>>>1)+(y6_i>>>3)+(y6_i>>>4)+(y6_i>>>6)+(y6_i>>>8)) + ((y6_r>>>1)+(y6_r>>>3)+(y6_r>>>4)+(y6_r>>>6)+(y6_r>>>8));
          
          b6_r <= y2_r - y6_r*0.707 - y6_i*0.707;
                b6_i <= y2_i - y6_i*0.707 + y6_r*0.707;

                b7_r <= y3_r - y7_i;
                b7_i <= y3_i + y7_r;

//                 b8_r <= y4_r + ((y8_r>>>1)+(y8_r>>>3)+(y8_r>>>4)+(y8_r>>>6)+(y8_r>>>8)) - ((y8_i>>>1)+(y8_i>>>3)+(y8_i>>>4)+(y8_i>>>6)+(y8_i>>>8));
//                 b8_i <= y4_i + ((y8_i>>>1)+(y8_i>>>3)+(y8_i>>>4)+(y8_i>>>6)+(y8_i>>>8)) + ((y8_r>>>1)+(y8_r>>>3)+(y8_r>>>4)+(y8_r>>>6)+(y8_r>>>8));
           b8_r <= y4_r + y8_r*0.707 - y8_i*0.707;
                b8_i <= y4_i + y8_i*0.707 + y8_r*0.707;

//uncomment for usual sign bit notations  and comment when you want in twos complement form for decimal conversion
                out0_real = c1_r;
                out0_imag = c1_i;
                out1_real = c2_r;
                out1_imag = c2_i;
                out2_real = c3_r;
                out2_imag = c3_i;
                out3_real = c4_r;
                out3_imag = c4_i;
                out4_real = c5_r;
                out4_imag = c5_i;
                out5_real = c6_r;
                out5_imag = c6_i;
                out6_real = c7_r;
                out6_imag = c7_i;
                out7_real = c8_r;
                out7_imag = c8_i;

////uncomment  for getting result in two complment form to convert into decimal form and comment when for usual sign bit notations
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
