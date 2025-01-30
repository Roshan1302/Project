module APB_master_tb;
				reg [7:0]trf_addr;
				reg [7:0]trf_wdata,prdata;
				reg prstn,pclk,trf_valid,pready;
				reg [1:0]trf_enc;// trf_enc:transfer_encod 2'b10 -read ;2'b01wr
				wire  penable ;
				wire [7:0] paddr;
				wire  pwrite ;
				wire  [7:0]pwdata,trf_rdata;
				wire  trf_rdata_valid;
				 APB_master DUT(
						 .trf_addr(trf_addr),
						 .trf_wdata(trf_wdata),
						 .prdata(prdata),
						 .prstn(prstn) ,
						 .pclk(pclk),
						 .trf_valid(trf_valid),
						 .pready(pready),
						 .psel(psel),
						 .trf_enc(trf_enc),// trf_enc:transfer_encod 2'b10 -read ,2'b01wr
						 .penable(penable) ,
						 .paddr(paddr),
						 .pwrite (pwrite),
						 .pwdata(pwdata),
						 .trf_rdata(trf_rdata),
						 .trf_rdata_valid(trf_rdata_valid)
						);
	always #5 pclk = ~pclk ;
	initial 
		begin 
      	$dumpfile ("APB_master_tb.vcd");
			$dumpvars (0);
		end
   initial 
		begin 
			pclk = 0 ;
			prstn = 0;
			trf_valid = 0 ;
			trf_wdata= 8'b00000001;
			trf_addr= 8'b0;
#10
			prstn = 1 ;
			trf_valid = 1 ;
			trf_enc = 2'b01 ;
			
#10
			trf_wdata= 8'b00000010 ;
			trf_addr = 8'b00000001;
#5
			pready = 1 ;
#10
			pready = 1;
			trf_valid = 0;
#5
            trf_valid = 1;
            trf_enc = 2'b01;
#2
        	trf_wdata = 8'b00000011;
			trf_addr  = 8'b00000010;
#20
		   trf_wdata = 8'b00000100;
			trf_addr  = 8'b00000100;
			//trf_valid = 1'b0 ;
#7 		
			trf_valid = 1'b1 ;
			trf_wdata = 8'b00000101;
			trf_addr =  8'b00000101;
#25
	 $finish ;
		end 
endmodule