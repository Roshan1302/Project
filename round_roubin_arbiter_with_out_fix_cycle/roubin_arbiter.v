module round_robin_arb (
input clk ,rst ,
input [3:0]req ,
output reg [3:0]grant // one hot output 
);
reg [2:0]cs ,ns;
parameter IDLE = 3'b000,
			 S0   = 3'b001,
			 S1   = 3'b010,
			 S2   = 3'b011,
			 S3   = 3'b100;
always @(posedge clk )
	begin 
	   if (rst)
      	cs <= IDLE ;
		else 
			cs <= ns ;	   
	end 			  
	always  @*
		begin 
		 ns = IDLE;
         grant = 4'b0;
			case (cs)
            	IDLE :begin
                        if(req==4'b0)
                            ns= IDLE;
                        else if(req[0])
                            ns = S0;
                        else if(req[1])
                            ns = S1;
                        else if (req[2])
                            ns = S2;
                        else if(req[3])
                            ns = S3 ;	  
                      end 
            	S0 :begin 
                        grant = 4'b0001;
                        if(req[0])
                            ns = S0;
                        else if(req[1])
                            ns = S1;
                        else if (req[2])
                            ns = S2;
                        else if(req[3])
                            ns = S3 ;	  
                      end 
            	S1 :begin 
                        grant = 4'b0010;
                        if(req[1])
                            ns = S1;
                        else if(req[2])
                            ns = S2;
                        else if(req[3])
                            ns = S3	;  
                        else if(req[0])
                            ns = S0;
                      end 
            	S2 :begin
                        grant = 4'b0100;
                        if(req[2])
                            ns = S2;
                        else if(req[3])
                            ns = S3;
                        else if(req[0])
                            ns = S0;
                        else if (req[1])
                            ns = S1;	  
                      end 
            	S3 :begin
                        grant = 4'b1000;
                        if(req[3])
                            ns = S3;
                        else if(req[0])
                            ns = S0;
                        else if(req[1])
                            ns = S1;
                        else if (req[2])
                            ns = S2;	  
                        
                      end
				endcase			 
		end
		endmodule
		
