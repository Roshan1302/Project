`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Roshan Ekre 
// 
// Create Date: 16.12.2024 21:52:22
// Design Name: Traffic light controller 
// Module Name: Traffic_light_controller_v_2
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



module Traffic_light_controller_v_2(
 input clk,
 input rst,
 input C,   // car 
 output reg HG,HY,HR,
 output reg FG,FY,FR    );
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;
    reg [3:0] reg_cnt ;
    reg [1:0] ps; // present state 
    reg [1:0] ns; // next state 
     always @(posedge clk )
              begin
                if(rst)
                 begin
                   reg_cnt <= 4'b0000;
                   ps <= S0 ;
                 end
               else
                 begin
                   ps <= ns ;
                   if(reg_cnt == 4'b1111)
                       reg_cnt <= 4'b0000;
                   else 
                       reg_cnt <= reg_cnt + 1;
                 end
              end
              
     always@(*)
      begin
       case(ps)   
       S0: begin  // from 0 to 15  (for green signal 16 count )
            {HG ,HY ,HR,FR ,FG ,FY} = 6'b100100;
             if(reg_cnt != 4'b1111  && ~C)
               ns = S0;
             else if(reg_cnt == 4'b1111 && C)
               begin 
                 ns = S1;
               end 
           end
       
      S1: begin  // from 0 to 7 ( for yello signal 8 count )
             {HG ,HY ,HR,FR ,FG ,FY} = 6'b010100;
             if( reg_cnt != 4'b0111)
                ns = S1;
             else if( reg_cnt == 4'b0111)
               begin 
                 ns = S2;
               end 
            end
       S2: begin // from 7 to 7 ( for green signal 16 count )
            {HG ,HY ,HR,FR ,FG ,FY} = 6'b001010;
            if(reg_cnt != 4'b0111)
                 ns = S2;
            else if( reg_cnt == 4'b0111)
               begin 
                 ns = S3;
               end   
       end
       S3: begin // from 7 to 15 (( for green signal 8 count ))
        { HG ,HY ,HR,FR ,FG ,FY} = 6'b001001;            
           if(reg_cnt != 4'b1111 )
               ns = S3;
           else if( reg_cnt == 4'b1111)
             begin 
               ns = S0;
             end   
       end
       default : { HG ,HY ,HR,FR ,FG ,FY} = 6'b100100;
       endcase
      end
endmodule