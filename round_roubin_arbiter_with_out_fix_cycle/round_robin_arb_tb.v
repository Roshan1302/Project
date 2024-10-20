 module round_robin_arb_tb;
           reg clk ,rst;
           reg[3:0]req;
           wire[3:0]grant ;
           integer i ;
           round_robin_arb DUT(.clk(clk),.rst(rst),.req(req),.grant(grant));
           
           always#5 clk = ~clk ;
           initial 
               begin 
                   $dumpfile("round_robin_arb_tb.vcd");
                   $dumpvars (0);
               end 
           
           initial 
               begin 
                   clk = 0 ;
                   rst = 1 ;
           #10 
                   rst = 0 ;
                   for(i = 16 ;i >=8 ;i = i-1)
                       begin 
                           req = i ;
           #10;
                       end
           #10
                       req = 4'b1111;
           #10$finish ;
               end 
           endmodule 
   