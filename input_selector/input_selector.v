module practi_que_1 #(parameter width = 128)(
	input [width -1 :0] inp,	// 4 32-bit input 
	input clk , rst ,
	input [3:0]valid,         // validalid signal
	input  [2:0]cnt_in,       //input cntr 
	input[1:0]sel, 
	output reg [31:0]out   
   );

reg [31:0]in[3:0];
reg [2:0]cnt;
reg out_en;
integer i;
always @*
begin 
for (i = 0;i<4'b100;i=i+1)  // seperating output in 32-bit 
	begin 
		in[i] = inp[width-i*32-1-:32];
  end 
end 
	always @(posedge clk )
  	begin
			if (rst )
				begin 
					cnt <= 3'b000;
					out <= 32'b0;
					out_en <= 1'b0;
				end 
		  else
   		  begin 
          if(cnt > 3'b000) 
              begin 
                cnt <= cnt - 1;	
                out_en <= 1'b1;
              end 
          else 
             begin 
                   if(valid[sel])
                     begin 
                       cnt <= cnt_in ;
                       out_en <= 1'b1;
                       out <= in[sel];
                     end 
                   else 
                     begin 
                       out_en<=1'b0;
                       out <= 32'b0;
                     end 
             end 
       end          
end 
endmodule