module practi_que_1_tb;
	reg [127:0]inp;	// 4 32-bit input 
	reg clk ;
	reg rst;
  reg [3:0]valid; // validalid signal
	reg [2:0]cnt_in;
	reg [1:0]sel;
	wire [31:0]out ;

practi_que_1 DUT(.inp(inp),
							 .clk(clk),
							 .valid(valid),
							 .cnt_in(cnt_in),
							 .sel(sel),
							 .rst(rst),
							 .out(out));
 always #5 clk = ~clk ;
initial 
	begin 
		$dumpfile("practi_que_1_tb.vcd");
		$dumpvars(0);
	end
initial 
	begin 
		clk = 1;
    rst = 1;
		valid= 4'b0100;
		#10 
		rst = 0;
		inp = 128'h0000008800870090;
		cnt_in  = 4;
		sel = 2'b10;
		#20
		sel= 2'b00;
    valid = 4'b0010;
    cnt_in = 5;
		#70
		sel =2'b01;
		#70
		$finish ; 		
	end 
endmodule
