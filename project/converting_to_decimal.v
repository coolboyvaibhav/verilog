module show_decimal_value(
    in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag
    //, out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag  
);
    
    input [15:0] in0_real, in0_imag, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag;
    //output [15:0] out0_real, out0_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag;
  reg signed [15:0] out0_real=in0_real;
  reg signed [15:0] out1_real=in1_real;
  reg signed [15:0] out2_real=in2_real;
  reg signed [15:0] out3_real=in3_real; 
  reg signed [15:0] out4_real=in4_real;
  reg signed [15:0] out5_real=in5_real;
  reg signed [15:0] out6_real=in6_real;
  reg signed [15:0] out7_real=in7_real;
  
  reg signed [15:0] out0_imag=in0_imag; 
  reg signed [15:0] out1_imag=in1_imag; 
  reg signed [15:0] out2_imag=in2_imag; 
  reg signed [15:0] out3_imag=in3_imag; 
  reg signed [15:0] out4_imag=in4_imag; 
  reg signed [15:0] out5_imag=in5_imag; 
  reg signed [15:0] out6_imag=in6_imag; 
  reg signed [15:0] out7_imag=in7_imag; 


    initial begin
     $display("real part =%f and imaginary part=(%f) ",out0_real*2.0**-8,out0_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out1_real*2.0**-8,out1_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out2_real*2.0**-8,out2_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out3_real*2.0**-8,out3_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out4_real*2.0**-8,out4_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out5_real*2.0**-8,out5_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out6_real*2.0**-8,out6_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out7_real*2.0**-8,out7_imag*2.0**-8); 
   end

endmodule

 



 module to_decimal;
  
  reg signed [15:0] out0_real=16'b0001110000000000;
  reg signed [15:0] out1_real=16'b1000010000000000;
  reg signed [15:0] out2_real=16'b1000010000000000;
  reg signed [15:0] out3_real=16'b1000010000000000; 
  reg signed [15:0] out4_real=16'b1000010000000000;
  reg signed [15:0] out5_real=16'b1000010000000000;
  reg signed [15:0] out6_real=16'b1000010000000000;
  reg signed [15:0] out7_real=16'b1000010000000000;
  
  reg signed [15:0] out0_imag=16'b0000000000000000; 
  reg signed [15:0] out1_imag=16'b0000100110101000; 
  reg signed [15:0] out2_imag=16'b0000010000000000; 
  reg signed [15:0] out3_imag=16'b0000000110101000; 
  reg signed [15:0] out4_imag=16'b0000000000000000; 
  reg signed [15:0] out5_imag=16'b1000000110101000; 
  reg signed [15:0] out6_imag=16'b1000010000000000; 
  reg signed [15:0] out7_imag=16'b1000100110101000; 



  initial begin
     $display("real part =%f and imaginary part=(%f) ",out0_real*2.0**-8,out0_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out1_real*2.0**-8,out1_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out2_real*2.0**-8,out2_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out3_real*2.0**-8,out3_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out4_real*2.0**-8,out4_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out5_real*2.0**-8,out5_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out6_real*2.0**-8,out6_imag*2.0**-8);
	 $display("real part =%f and imaginary part=(%f) ",out7_real*2.0**-8,out7_imag*2.0**-8);
	 
	 
   end

 endmodule

   
   