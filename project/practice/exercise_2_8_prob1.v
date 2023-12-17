//bottom up approach
module MEM ;
   initial
         begin
                   $display("Memory block");
                    $finish;
        end 

endmodule

module SC;
initial
         begin
                   $display("System Controller");
                    $finish;
        end
endmodule

module Xbar;
initial
         begin
                   $display("data crossbar");
                    $finish;
        end
endmodule

module IS;

MEM mem1();
SC sc1();
Xbar xbar1();



endmodule


module stimulus;
IS is1();


endmodule