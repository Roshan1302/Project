 module tb_downsizer;

   reg [1023:0] inp;
   reg clk, rst,valid_in;
   wire [255:0] out;
   wire out_en; 


   downsizer DUT (
     .inp_data(inp),
     .clk(clk),
     .rstn(rst),
     .valid_in(valid_in),
//     .ready(ready),
     .data_out(out),
     .out_en(out_en) 
   );


   always #5 clk = ~clk;

   initial begin
     $dumpfile("testbench.vcd"); 
     $dumpvars(0, tb_downsizer);
     clk = 0;
     rst = 0;
     valid_in = 0;
     
     #10 rst = 1; 
     valid_in = 1'b1 ;
     inp = 1023'ha8bcc5167e6450a4332ab2e27a2e87f96f74a4eb5602e3ed6b9b26b6d80e49ca55bc91380c52c5b367148584825eff12def5b395a610b7662efcc0c8014bce5a20dba2786e36a5d18c14a15918a16668873ab8b75296ee64e2475bade58e56ecb936a5d18c14a15918a16668873ab84f0e410513ad815997c4310260abcc516;
     #10;
     inp = 1023'h732465e92a2dc67b6604ad5f0e41630bdc8a953a8d6bb76f13fa0fd181294527da7e631df57c3dee10d2f447f483fa9d1dba8ff21753185e199b5a026b8745d925e0c738952ef40d852e1bca5ba1b04f0fdb896a8f1751070f336204f0e410513ad815997c4310260a846ac32791e4332ab2e27a2e87f96f74a846ac32791ea;
     valid_in = 0;
     #45;
     valid_in = 1;
     inp = 1023'haabb65e92a2dc67b6604ad5f0e41630bdc8a953a8d6bb76f13fa0fd181294527da7e631df57c3dee10d2f447f483fa9d1dba8ff21753185e199b5a026b8745d925e0c738952ef40d852e1bca5ba1b04f0fdb896a8f17510700b7662efcc0c8014bce5a20dba2786eb75296ee64e2420dba2786eb75296ee64e246eb75296ee6;
     #45;
     inp = 1023'hbbcc2a2dc67b6604ad5f0e41630bdc8a953a8d6bb76f13fa0fd181294527da7e631df57c3dee10d2f447f483fa9d1dba8ff21753185e199b5a026b8745d925e0c738952ef40d852e1bca5ba1b04f0fdb896a8f1751070f336204f0e410513ad815997c4310260abcc5167e6450a4332ab2e27a2e87f96f74a846ac32791e;     
     #90
     $finish;
   end

  
 
 endmodule
