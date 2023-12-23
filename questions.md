# Division by Repeated Subtraction
It is required to design an 8-bit divider by implementing  the data path and control path separately. The operation will take as inputs divisor p and dividend n, and provides outputs quotient q and remainder r such that n = p x q + r. At the beginning two registers P and N will be loaded with p and n respectively. At each iteration p will be subtracted from N, storing the result back in N, as long as p <= N, and also increment a counter Q that is initialized to 0. At the end, Q will contain the quotient (q), and N will contain the remainder (r).



The data path will consist of two 8-bit registers N and  P, an 8-bit counter Q,  an 8-bit subtractor,  and an 8-bit comparator. The comparator takes two numbers N and P as inputs and outputs PgtN = 0, if P > N; otherwise it will give PgtN = 1. The control path will generate the following active-high control signals in synchronism with the positive edge of the clock, and also implement the following FSM with states S0 to S4.

| Signal | Description                                        |
|--------|----------------------------------------------------|
| LoadN  | Load input data in register N at the +ve clock edge.  |
| LoadS  | Load N with the subtraction result at the +ve clock edge. |
| LoadP  | Load input data in register P at the +ve clock edge.  |
| Clear  | Clear registers/counters to 0 at the +ve clock edge.  |
| IncQ   | Increment counter Q at the +ve clock edge.  |
| Stop   | Stop computing if comparator output PgtN is 0.  |

<!-- ![Alt text](C:\iverilog\bin\iverilog_test\control_flow3.png "a title") -->

An external signal Start will start the division operation, and registers N and P are loaded with inputs provided through common data input, Data_in. Write Verilog modules to implement all the component hardware units and use them as building blocks to design data path and control path as per the following template:
                    module div_datapath (PgtN, LoadN, LoadS, LoadP, Clear, IncQ, Data_in, Clk);
                    module div_ctrlpath (LoadN, LoadP, Clear, IncQ, Stop, Clk, PgtN, Start);

 Important Note: Please use variables Nw and Qw as the output interface of registers N and Q respectively inside div_datapath module. This is essential for the verification of your design using the configured testbench.