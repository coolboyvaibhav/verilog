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
