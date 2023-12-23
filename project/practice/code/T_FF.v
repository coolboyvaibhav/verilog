module T_FF (
    q,clk,reset
);
    output q;
    input clk,reset;
    wire  d;
    
    //instantiating D FF
    D_FF dff0(q,d,clk,reset);
    not n1(d,q);//not is a verilog provided primitive case sensitive

endmodule