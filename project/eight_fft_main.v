// `include "dftf.v"
// `include "twos_complement.v"
// `include "inv_twos_complement.v"

/////////////////////////twos_complement

module twos_complement(
  input [15:0] in,
  output [15:0] out
);

  reg signed [14:0] x;

  always @* begin
    if (in[15] == 1'b1) begin
      x = ~(in) + 1'b1;
      out <= {1'b1, x};
    end
    else begin
      out <= in;
    end
  end

endmodule


////////////inverse twos complement

module inv_two(
  input [15:0] in,
  output [15:0] out
);

  reg [14:0] x;
  reg [15:0] out;

  always @* begin
    if (in[15] == 1) begin
      x = in - 1;
      out <= {1'b1, ~x};
    end
    else begin
      out <= in;
    end
  end

endmodule








//////////////////////////main code
module eight_point_fft(CLK,F RST_N, in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag, in8_real, in8_imag, out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag, out8_real, out8_imag,  write, start, ready);

input CLK, RST_N, write, start;
input [15:0] in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag, in8_real, in8_imag;
output [15:0] out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag, out8_real, out8_imag;
output ready;

reg ready;

wire [15:0] in1_real, in1_imag, in2_real, in2_imag, in3_real, in3_imag, in4_real, in4_imag, in5_real, in5_imag, in6_real, in6_imag, in7_real, in7_imag, in8_real, in8_imag;
reg [15:0] out1_real, out1_imag, out2_real, out2_imag, out3_real, out3_imag, out4_real, out4_imag, out5_real, out5_imag, out6_real, out6_imag, out7_real, out7_imag, out8_real, out8_imag;
wire signed [15:0] t1_r, t2_r, t3_r, t4_r, t5_r, t6_r, t7_r, t8_r, t1_i, t2_i, t3_i, t4_i, t5_i, t6_i, t7_i, t8_i;
wire signed [15:0] y1_r, y2_r, y3_r, y4_r, y5_r, y6_r, y7_r, y8_r, y1_i, y2_i, y3_i, y4_i, y5_i, y6_i, y7_i, y8_i;
wire [15:0] c1_r, c2_r, c3_r, c4_r, c5_r, c6_r, c7_r, c8_r, c1_i, c2_i, c3_i, c4_i, c5_i, c6_i, c7_i, c8_i;
reg signed [15:0] a1_r, a2_r, a3_r, a4_r, a5_r, a6_r, a7_r, a8_r, a1_i, a2_i, a3_i, a4_i, a5_i, a6_i, a7_i, a8_i;
reg signed [15:0] b1_r, b2_r, b3_r, b4_r, b5_r, b6_r, b7_r, b8_r, b1_i, b2_i, b3_i, b4_i, b5_i, b6_i, b7_i, b8_i;

two_complement p0(in1_real,t1_r);
two_complement p1(in2_real,t2_r);
two_complement p2(in3_real,t3_r);
two_complement p3(in4_real,t4_r);
two_complement p4(in5_real,t5_r);
two_complement p5(in6_real,t6_r);
two_complement p6(in7_real,t7_r);
two_complement p7(in8_real,t8_r);
two_complement p8(in1_imag,t1_i);
two_complement p9(in2_imag,t2_i);
two_complement p10(in3_imag,t3_i);
two_complement p11(in4_imag,t4_i);
two_complement p12(in5_imag,t5_i);
two_complement p13(in6_imag,t6_i);
two_complement p14(in7_imag,t7_i);
two_complement p15(in8_imag,t8_i);

inv_two po0(b1_r,c1_r);
inv_two po1(b2_r,c2_r);
inv_two po2(b3_r,c3_r);
inv_two po3(b4_r,c4_r);
inv_two po4(b5_r,c5_r);
inv_two po5(b6_r,c6_r);
inv_two po6(b7_r,c7_r);
inv_two po7(b8_r,c8_r);
inv_two po8(b1_i,c1_i);
inv_two po9(b2_i,c2_i);
inv_two po10(b3_i,c3_i);
inv_two po11(b4_i,c4_i);
inv_two po12(b5_i,c5_i);
inv_two po13(b6_i,c6_i);
inv_two po14(b7_i,c7_i);
inv_two po15(b8_i,c8_i);

dftf d0(a1_r,a1_i,a3_r,a3_i,a5_r,a5_i,a7_r,a7_i,y1_r,y1_i,y2_r,y2_i,y3_r,y3_i,y4_r,y4_i);
dftf d1(a2_r,a2_i,a4_r,a4_i,a6_r,a6_i,a8_r,a8_i,y5_r,y5_i,y6_r,y6_i,y7_r,y7_i,y8_r,y8_i);

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
					
		b2_r <= y2_r + ((y6_r>>>1)+(y6_r>>>2)-(y6_r>>>4)+(y6_r>>>5)-(y6_r>>>6)+(y6_r>>>7)-(y6_r>>>8)) + ((y6_i>>>1)+(y6_i>>>2)-(y6_i>>>4)+(y6_i>>>5)-(y6_i>>>6)+(y6_i>>>7)-(y6_i>>>8));
		b2_i <= y2_i + ((y6_i>>>1)+(y6_i>>>2)-(y6_i>>>4)+(y6_i>>>5)-(y6_i>>>6)+(y6_i>>>7)-(y6_i>>>8)) - ((y6_r>>>1)+(y6_r>>>2)-(y6_r>>>4)+(y6_r>>>5)-(y6_r>>>6)+(y6_r>>>7)-(y6_r>>>8));

		b3_r <= y3_r + y7_i;
		b3_i <= y3_i - y7_r;

		b4_r <= y4_r - ((y8_r>>>1)+(y8_r>>>2)-(y8_r>>>4)+(y8_r>>>5)-(y8_r>>>6)+(y8_r>>>7)-(y8_r>>>8)) + ((y8_i>>>1)+(y8_i>>>2)-(y8_i>>>4)+(y8_i>>>5)-(y8_i>>>6)+(y8_i>>>7)-(y8_i>>>8));
		b4_i <= y4_i - ((y8_i>>>1)+(y8_i>>>2)-(y8_i>>>4)+(y8_i>>>5)-(y8_i>>>6)+(y8_i>>>7)-(y8_i>>>8)) - ((y8_r>>>1)+(y8_r>>>2)-(y8_r>>>4)+(y8_r>>>5)-(y8_r>>>6)+(y8_r>>>7)-(y8_r>>>8));
				
		b5_r <= y1_r - y5_r;
		b5_i <= y1_i - y5_i;
					
		b6_r <= y2_r - ((y6_r>>>1)+(y6_r>>>2)-(y6_r>>>4)+(y6_r>>>5)-(y6_r>>>6)+(y6_r>>>7)-(y6_r>>>8)) - ((y6_i>>>1)+(y6_i>>>2)-(y6_i>>>4)+(y6_i>>>5)-(y6_i>>>6)+(y6_i>>>7)-(y6_i>>>8));
		b6_i <= y2_i - ((y6_i>>>1)+(y6_i>>>2)-(y6_i>>>4)+(y6_i>>>5)-(y6_i>>>6)+(y6_i>>>7)-(y6_i>>>8)) + ((y6_r>>>1)+(y6_r>>>2)-(y6_r>>>4)+(y6_r>>>5)-(y6_r>>>6)+(y6_r>>>7)-(y6_r>>>8));

		b7_r <= y3_r - y7_i;
		b7_i <= y3_i + y7_r;

		b8_r <= y4_r + ((y8_r>>>1)+(y8_r>>>2)-(y8_r>>>4)+(y8_r>>>5)-(y8_r>>>6)+(y8_r>>>7)-(y8_r>>>8)) - ((y8_i>>>1)+(y8_i>>>2)-(y8_i>>>4)+(y8_i>>>5)-(y8_i>>>6)+(y8_i>>>7)-(y8_i>>>8));
		b8_i <= y4_i + ((y8_i>>>1)+(y8_i>>>2)-(y8_i>>>4)+(y8_i>>>5)-(y8_i>>>6)+(y8_i>>>7)-(y8_i>>>8)) + ((y8_r>>>1)+(y8_r>>>2)-(y8_r>>>4)+(y8_r>>>5)-(y8_r>>>6)+(y8_r>>>7)-(y8_r>>>8));

		out1_real = c1_r;
		out1_imag = c1_i;
		out2_real = c2_r;
		out2_imag = c2_i;
		out3_real = c3_r;
		out3_imag = c3_i;
		out4_real = c4_r;
		out4_imag = c4_i;
		out5_real = c5_r;
		out5_imag = c5_i;
		out6_real = c6_r;
		out6_imag = c6_i;
		out7_real = c7_r;
		out7_imag = c7_i;
		out8_real = c8_r;
		out8_imag = c8_i;
		
		ready = 1'b1;
	end
end
end
endmodule
	
		
		
