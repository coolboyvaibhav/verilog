module two_complement(
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
