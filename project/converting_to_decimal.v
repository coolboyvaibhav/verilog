module to_decimal;
  reg signed [15:0] x0r=16'b0001110000000000;
  reg signed [15:0] x0i=16'b0001110000000000;
   
   initial begin
     $display("real part =%f and imaginary part=(%f) ",x0r*2.0**-8,x0i*2.0**-8);
   end

 endmodule