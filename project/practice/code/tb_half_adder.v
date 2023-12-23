`timescale 1ns/1ps

// `include "half_adder.v"
// `default_nettype none
module half_adder  (
    s,c,a,b 
);
output s,c;
input a,b;
xor x1(s,a,b);
and a1(c,a,b);
endmodule


module tb_half_adder;

reg a,b;
wire s,c;

//instantiation of lower level module 
half_adder dut(.s(s),.c(c),.a(a),.b(b));


initial begin
    $dumpfile("tb_half_adder.vcd");
    $dumpvars(0, tb_half_adder);
end



initial begin
    a=0;b=0;
    #10
    b = 0; b = 1;
    #10
    a = 1; b = 0;
    #10
    b = 1; b = 1;
    #10
$finish();
end

endmodule
// `default_nettype wire