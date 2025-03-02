`timescale 1ns / 1ps

module tb_async_fifo();
      
       reg w_clk;
       reg r_clk;
       reg r_rst ,w_rst ,wr ,rd;
       reg [7:0]wdata ;
       
       wire[7:0]rdata;
       wire full,empty;
       wire  overflow ,underflow; 
       integer i ;
       async_fifo DUT (.w_clk(w_clk),
       .r_clk(r_clk),
       .rst(w_rst) ,
       .rst(r_rst) ,
       .wr(wr) ,
       .rd(rd),
       .wdata(wdata),
       .rdata(rdata),
       .full(full),
       .empty(empty),
       .overflow(overflow),
       .underflow(underflow)
       );
       always #7 r_clk = ~ r_clk ;
       always #5 w_clk = ~ w_clk ;
       initial 
        begin 
         r_clk = 1;
         w_clk = 0;
         {wr,rd,rst} = 3'b001;
         #23
         {wr,rd,rst} = 3'b100;
         for (i = 0 ; i < 8 ; i = i + 1)
            begin
                wdata = i;
                #10;
            end
            #14
            {wr,rd,rst} = 3'b010;
            #17
            {wr,rd,rst} = 3'b010;
             #150
             $finish;
              end 
endmodule
