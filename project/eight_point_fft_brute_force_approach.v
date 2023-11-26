




///working for stage 3 

`timescale 1ns/1ps

module eight_point_fft (CLK, RST_N,
in0_real,in0_imag,in1_real,in1_imag,in2_real,in2_imag,in3_real,in3_imag,in4_real,in4_imag,in5_real,in5_imag,in6_real,in6_imag,in7_real,in7_imag,
write, start, ready,
out0_real,out0_imag,out1_real,out1_imag,out2_real,out2_imag,out3_real,out3_imag,out4_real,out4_imag,out5_real,out5_imag,out6_real,out6_imag,out7_real,out7_imag);
//CLK Input Clock signal
// RST_N Input Active-low reset signal
// write Input Input write signal
// start Input FFT computation start signal
// ready Output FFT computation done signal

 input CLK, RST_N;//input for clk and rst
 
 //input [15:0] in0_real,in0_imag,in1_real,in1_imag,in2_real,in2_imag,in3_real,in3_imag,in4_real,in4_imag,in5_real,in5_imag,in6_real,in6_imag,in7_real,in7_imag;//256 bits inputs

 input write, start;//write for storing value in registers a and b ; start=addition operation start
 //output [15:0] out0_real,out0_imag,out1_real,out1_imag,out2_real,out2_imag,out3_real,out3_imag,out4_real,out4_imag,out5_real,out5_imag,out6_real,out6_imag,out7_real,out7_imag;//for output storage 257 bits
 output ready;// result  is available at output
 
 
 
input wire signed [15:0] in0_real  ; // Input 16-bit real part of 𝑥0
input wire signed [15:0] in0_imag  ; // Input 16-bit imaginary part of 𝑥0
input wire signed [15:0] in1_real  ; // Input 16-bit real part of 𝑥1
input wire signed [15:0] in1_imag  ; // Input 16-bit imaginary part of 𝑥1
input wire signed [15:0] in2_real  ; // Input 16-bit real part of 𝑥2
input wire signed [15:0] in2_imag  ; // Input 16-bit imaginary part of 𝑥2
input wire signed [15:0] in3_real  ; // Input 16-bit real part of 𝑥3
input wire signed [15:0] in3_imag  ; // Input 16-bit imaginary part of 𝑥3
input wire signed [15:0] in4_real  ; // Input 16-bit real part of 𝑥4
input wire signed [15:0] in4_imag  ; // Input 16-bit imaginary part of 𝑥4
input wire signed [15:0] in5_real  ; // Input 16-bit real part of 𝑥5
input wire signed [15:0] in5_imag  ; // Input 16-bit imaginary part of 𝑥5
input wire signed [15:0] in6_real  ; // Input 16-bit real part of 𝑥6
input wire signed [15:0] in6_imag  ; // Input 16-bit imaginary part of 𝑥6
input wire signed [15:0] in7_real  ; // Input 16-bit real part of 𝑥7
input wire signed [15:0] in7_imag  ; // Input 16-bit imaginary part of 𝑥7

output signed [15:0] out0_real; //16-bit//Output  real part of 𝑋0
output signed [15:0] out0_imag; // Output 16-bit imaginary part of 𝑋0
output signed [15:0] out1_real; // Output 16-bit real part of 𝑋1
output signed [15:0] out1_imag; // Output 16-bit imaginary part of 𝑋1
output signed [15:0] out2_real; // Output 16-bit real part of 𝑋2
output signed [15:0] out2_imag; // Output 16-bit imaginary part of 𝑋2
output signed [15:0] out3_real; // Output 16-bit real part of 𝑋3
output signed [15:0] out3_imag; // Output 16-bit imaginary part of 𝑋3
output signed [15:0] out4_real; // Output 16-bit real part of 𝑋4
output signed [15:0] out4_imag; // Output 16-bit imaginary part of 𝑋4
output signed [15:0] out5_real; // Output 16-bit real part of 𝑋5
output signed [15:0] out5_imag; // Output 16-bit imaginary part of 𝑋5
output signed [15:0] out6_real; // Output 16-bit real part of 𝑋6
output signed [15:0] out6_imag; // Output 16-bit imaginary part of 𝑋6
output signed [15:0] out7_real; // Output 16-bit real part of 𝑋7
output signed [15:0] out7_imag; // Output 16-bit imaginary part of 𝑋7


//registers
reg ready;


//for inputs store in  registers

reg signed[15:0] in0_real_reg; 
reg signed[15:0] in0_imag_reg; 
reg signed[15:0] in1_real_reg; 
reg signed[15:0] in1_imag_reg; 
reg signed[15:0] in2_real_reg; 
reg signed[15:0] in2_imag_reg; 
reg signed[15:0] in3_real_reg; 
reg signed[15:0] in3_imag_reg; 
reg signed[15:0] in4_real_reg; 
reg signed[15:0] in4_imag_reg; 
reg signed[15:0] in5_real_reg; 
reg signed[15:0] in5_imag_reg; 
reg signed[15:0] in6_real_reg; 
reg signed[15:0] in6_imag_reg; 
reg signed[15:0] in7_real_reg; 
reg signed[15:0] in7_imag_reg; 

//for output
reg signed[15:0] out0_real_reg1,out0_real_reg2,out0_real_reg; 
reg signed[15:0] out0_imag_reg1,out0_imag_reg2,out0_imag_reg; 
reg signed[15:0] out1_real_reg1,out1_real_reg2,out1_real_reg; 
reg signed[15:0] out1_imag_reg1,out1_imag_reg2,out1_imag_reg; 
reg signed[15:0] out2_real_reg1,out2_real_reg2,out2_real_reg; 
reg signed[15:0] out2_imag_reg1,out2_imag_reg2,out2_imag_reg; 
reg signed[15:0] out3_real_reg1,out3_real_reg2,out3_real_reg; 
reg signed[15:0] out3_imag_reg1,out3_imag_reg2,out3_imag_reg; 
reg signed[15:0] out4_real_reg1,out4_real_reg2,out4_real_reg; 
reg signed[15:0] out4_imag_reg1,out4_imag_reg2,out4_imag_reg; 
reg signed[15:0] out5_real_reg1,out5_real_reg2,out5_real_reg; 
reg signed[15:0] out5_imag_reg1,out5_imag_reg2,out5_imag_reg; 
reg signed[15:0] out6_real_reg1,out6_real_reg2,out6_real_reg; 
reg signed[15:0] out6_imag_reg1,out6_imag_reg2,out6_imag_reg; 
reg signed[15:0] out7_real_reg1,out7_real_reg2,out7_real_reg; 
reg signed[15:0] out7_imag_reg1,out7_imag_reg2,out7_imag_reg; 



assign out0_real =out0_real_reg;
assign out0_imag =out0_imag_reg;
assign out1_real =out1_real_reg;
assign out1_imag =out1_imag_reg;
assign out2_real =out2_real_reg;
assign out2_imag =out2_imag_reg;
assign out3_real =out3_real_reg;
assign out3_imag =out3_imag_reg;
assign out4_real =out4_real_reg;
assign out4_imag =out4_imag_reg;
assign out5_real =out5_real_reg;
assign out5_imag =out5_imag_reg;
assign out6_real =out6_real_reg;
assign out6_imag =out6_imag_reg;
assign out7_real =out7_real_reg;
assign out7_imag =out7_imag_reg;

//twiddle factors

//stage 1
localparam w02_stage1=1;

//stage 2
localparam w04_stage2=1;
localparam w14_stage2=-1;//imz

//stage 3
localparam w08_stage3=1;

localparam w18_stage3_1=0.707;
localparam w18_stage3_2=-0.707;//imz

localparam w28_stage3=-1;//imz

localparam w38_stage3_1=-0.707;
localparam w38_stage3_2=-0.707;//imz

always @(posedge CLK) begin
                if (~RST_N) begin//reset is active low if rst=0 =>ready =1
                        ready <= 1'b0;
                end
		else begin//rst value 1
			if(start) begin
//stage 1
				
				out0_real_reg1<=in0_real_reg+in4_real_reg;
				out0_imag_reg1<=in0_imag_reg+in4_imag_reg;
				out1_real_reg1<=in0_real_reg-in4_real_reg;
				out1_imag_reg1<=in0_imag_reg-in4_imag_reg;
							 
				out2_real_reg1<=in2_real_reg+in6_real_reg;
				out2_imag_reg1<=in2_imag_reg+in6_imag_reg;
				out3_real_reg1<=in2_real_reg-in6_real_reg;
				out3_imag_reg1<=in2_imag_reg-in6_imag_reg;
							 
				out4_real_reg1<=in1_real_reg+in5_real_reg;
				out4_imag_reg1<=in1_imag_reg+in5_imag_reg;
				out5_real_reg1<=in1_real_reg-in5_real_reg;
				out5_imag_reg1<=in1_imag_reg-in5_imag_reg;
							 
				out6_real_reg1<=in3_real_reg+in7_real_reg;
 	            out6_imag_reg1<=in3_imag_reg+in7_imag_reg;
  			    out7_real_reg1<=in3_real_reg-in7_real_reg;
                out7_imag_reg1<=in3_imag_reg-in7_imag_reg;
				
				
				//stage 2
				
				
					
				out0_real_reg2<=out0_real_reg1+out2_real_reg1;
				out0_imag_reg2<=out0_imag_reg1+out2_imag_reg1;
														   
				out1_real_reg2<=out1_real_reg1+out3_imag_reg1;
				out1_imag_reg2<=out1_imag_reg1-out3_real_reg1;
														   
				out2_real_reg2<=out0_real_reg1-out2_real_reg1;
				out2_imag_reg2<=out0_imag_reg1-out2_imag_reg1;
														   
				out3_real_reg2<=out1_real_reg1-out3_real_reg1;
				out3_imag_reg2<=out1_imag_reg1-out3_imag_reg1;				
													   
				out4_real_reg2<=out4_real_reg1+out6_real_reg1;
				out4_imag_reg2<=out4_imag_reg1+out6_imag_reg1;
													   
				out5_real_reg2<=out5_real_reg1+out7_imag_reg1;
				out5_imag_reg2<=out5_imag_reg1-out7_real_reg1;
														   
				out6_real_reg2<=out4_real_reg1-out6_real_reg1;
				out6_imag_reg2<=out4_imag_reg1-out6_imag_reg1;
														   
				out7_real_reg2<=out5_real_reg1-out7_real_reg1;
				out7_imag_reg2<=out5_imag_reg1-out7_imag_reg1;	
////////////////////////////////stage 3
				out0_real_reg<=out0_real_reg2+w08_stage3*out4_real_reg2;
				out0_imag_reg<=out0_imag_reg2+w08_stage3*out4_imag_reg2;
											
				out1_real_reg<=out1_real_reg2+w18_stage3_1*out5_real_reg-w18_stage3_2*out5_imag_reg2;
				out1_imag_reg<=out1_imag_reg2+w18_stage3_1*out5_imag_reg+w18_stage3_2*out5_real_reg2;
											
				out2_real_reg<=out2_real_reg2+out6_imag_reg2;
				out2_imag_reg<=out2_imag_reg2-out6_real_reg2;
											
				out3_real_reg<=out3_real_reg2+w38_stage3_1*out7_real_reg-w38_stage3_2*out7_imag_reg2;
				out3_imag_reg<=out3_imag_reg2+w38_stage3_1*out7_real_reg+w38_stage3_2*out7_imag_reg2;				
											
				out4_real_reg<=out0_real_reg2-w08_stage3*out4_real_reg2;
				out4_imag_reg<=out0_imag_reg2-w08_stage3*out4_imag_reg2;
											
				out5_real_reg<=out1_real_reg2-w18_stage3_1*out5_real_reg+w18_stage3_2*out5_imag_reg2;
				out5_imag_reg<=out1_imag_reg2-w18_stage3_1*out5_imag_reg-w18_stage3_2*out5_real_reg2;
											
				out6_real_reg<=out2_real_reg2-out6_imag_reg2;
				out6_imag_reg<=out2_imag_reg2+out6_real_reg2;
											
				out7_real_reg<=out3_real_reg2-w38_stage3_1*out7_real_reg+w38_stage3_2*out7_imag_reg2;
				out7_imag_reg<=out3_imag_reg2-w38_stage3_1*out7_real_reg-w38_stage3_2*out7_imag_reg2;							 
								
				
				ready<=1'b1;//output is availble
				//
			end
			else begin
				if (write) begin//to store the values when write is given
					in0_real_reg<=in0_real; 
			        in0_imag_reg<=in0_imag; 
				    in1_real_reg<=in1_real; 
				    in1_imag_reg<=in1_imag; 
				    in2_real_reg<=in2_real; 
				    in2_imag_reg<=in2_imag; 
                    in3_real_reg<=in3_real; 
                    in3_imag_reg<=in3_imag; 
                    in4_real_reg<=in4_real; 
                    in4_imag_reg<=in4_imag; 
                    in5_real_reg<=in5_real; 
                    in5_imag_reg<=in5_imag; 
                    in6_real_reg<=in6_real; 
     	            in6_imag_reg<=in6_imag; 
                    in7_real_reg<=in7_real; 
                    in7_imag_reg<=in7_imag; 
				end
				else
					ready<=1'b0;//not having output
							
			end
		end
	end
endmodule
								
								
								
								




