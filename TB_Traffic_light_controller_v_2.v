`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 21:58:00
// Design Name: 
// Module Name: TB_Traffic_light_controller_v_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module Traffic_light_controller_v_2_tb;

  // Testbench signals
  reg clk;
  reg rst;
  reg C; 
  wire HG, HY, HR;
  wire FG, FY, FR;

  // Instantiate the DUT (Device Under Test)
  Traffic_light_controller_v_2 dut (
    .clk(clk),
    .rst(rst),
    .C(C),
    .HG(HG),
    .HY(HY),
    .HR(HR),
    .FG(FG),
    .FY(FY),
    .FR(FR)
  );

  always #5 clk = ~clk;   
  integer i;
  initial
    begin
     rst = 1'b1;
     clk = 1'b0;
     C = 1'b0;
     #10
     rst = 1'b0;
     C =1'b0 ;
     #10
     C = 1'b1;
    #10
     C = 1'b0;
     #70
     C = 1'b0;
     #100

     for(i=0;i<512;i=i+1)
       begin
        C = $urandom_range(0,1);
        @(negedge clk);
       end
       #120
     $finish;
    end
  endmodule