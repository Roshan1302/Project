//`define MAX_CNT 3
//  module downsizer  #(parameter INP_DATA_WIDTH = 128,
//                              DATA_OUT_WIDTH= 32,
//                              VALID_CNT_WIDTH = 3)(
//    input [INP_DATA_WIDTH*8-1:0] inp_data,
//    input clk, rstn, 
//    input valid_in , 
//    output [DATA_OUT_WIDTH*8-1:0] data_out,
//    output reg out_en ,ready 
//  );
//  reg [VALID_CNT_WIDTH-1:0] valid_cnt ;
//  reg [`MAX_CNT:0] [DATA_OUT_WIDTH*8-1 :0] inp_reg;
//     // distributed input signals 
//     always @(posedge clk ,posedge rstn )
//           begin 
//             if(!rstn )
//               begin 
//                 valid_cnt <= 'b0;  
//                 ready <= 'b0;
//                 out_en <= 'b0;
//               end 
//             else 
//               begin 
//                 if(valid_cnt > 'b0 )
//                   begin 
//                     valid_cnt <= valid_cnt -1'b1;
//                     out_en <= 1'b1 ;
//                   end 
//                 else 
//                   begin 
//                     if(valid_in)
//                       begin  
//                         valid_cnt <= `MAX_CNT;
//                         out_en = 1'b1 ;
//                         inp_reg <= inp_data ;
//                       end   
//                   end  
//              end
//         end      
//         assign data_out = inp_reg[valid_cnt] ;
// endmodule

///////////////////////////////////other version ///////////////////////////////

`define MAX_CNT 3
  module downsizer  #(parameter INP_DATA_WIDTH = 128,
                              DATA_OUT_WIDTH= 32,
                              VALID_CNT_WIDTH = 2)(
    input [INP_DATA_WIDTH*8-1:0] inp_data,
    input clk, rstn, 
    input valid_in , 
    output reg [DATA_OUT_WIDTH*8-1:0] data_out,
    output reg out_en  
  );
  reg [VALID_CNT_WIDTH-1:0] valid_cnt ;
  reg [0:`MAX_CNT] [DATA_OUT_WIDTH*8-1 :0] inp_reg;
     // distributed input signals 
     always @(posedge clk ,posedge rstn )
           begin 
             if(!rstn )
               begin 
                 valid_cnt <= 'b0;  
                 out_en <= 'b0;
               end 
             else 
               begin 
                 out_en <= 1'b0 ;
                 if(valid_cnt > 'b0 )
                   begin 
                     valid_cnt <= valid_cnt -1'b1;
                     out_en <= 1'b1 ;
                   end 
                 else 
                   begin 
                     if(valid_in)
                       begin  
                         valid_cnt <= `MAX_CNT;
                         out_en <= 1'b1 ;
                         inp_reg <= inp_data ;
                       end  
                   end  
              end
         end      
         assign data_out = inp_reg[valid_cnt];
          endmodule
