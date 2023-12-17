module D_FF (
    q,d,clk,reset
);
output q;
input d,clk,reset;
//need regiseters because need to store its values
reg q;


always @(posedge reset or negedge clk) begin
    
    if (reset) begin
        q=1'b0;
    end
    else begin
        q=d;
    end

end
    
endmodule


