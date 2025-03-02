module async_fifo #(
    parameter FW = 8,  // FIFO data width
    parameter FD = 8 // FIFO depth
) (
    input w_clk,
    input r_clk,
    input rst,
    input wr,
    input rd,
    input [FW-1:0] wdata,
    output reg [FW-1:0] rdata,
    output full,
    output empty,
    output reg overflow,
    output reg underflow
);
    
    localparam ADDR_SIZE = $clog2(FD); // Address width
    
    // FIFO memory and pointers
    reg [ADDR_SIZE:0] wptr, rptr;
    reg [FW-1:0] mem[FD-1:0];

    // Gray-coded pointers
    wire [ADDR_SIZE:0] c_wptr, c_rptr;
    reg  [ADDR_SIZE:0] c_wptr_q1, c_wptr_q2;
    reg  [ADDR_SIZE:0] c_rptr_q1, c_rptr_q2;

    // Binary pointers (converted from Gray)
    wire [ADDR_SIZE:0] bin_wptr, bin_rptr;

    // Write Operation
    always @(posedge w_clk or posedge rst) begin
        if (rst)
            wptr <= 0;
        else if (wr && !full) begin
            mem[wptr[ADDR_SIZE-1:0]] <= wdata; // Write data to memory
            wptr <= wptr + 1'b1;
        end
    end

    // Read Operation
    always @(posedge r_clk or posedge rst) begin
        if (rst)
            rptr <= 0;
        else if (rd && !empty) begin
            rdata <= mem[rptr[ADDR_SIZE-1:0]]; // Read data from memory
            rptr <= rptr + 1'b1;
        end
    end

    // Convert Binary Pointers to Gray Code
    assign c_wptr = wptr ^ (wptr >> 1);
    assign c_rptr = rptr ^ (rptr >> 1);

    // Synchronizing Write Pointer to Read Domain
    always @(posedge r_clk or posedge rst) begin
        if (rst) begin
            c_wptr_q1 <= {ADDR_SIZE{1'b0}};
            c_wptr_q2 <= {ADDR_SIZE{1'b0}};
        end else begin
            c_wptr_q1 <= c_wptr;
            c_wptr_q2 <= c_wptr_q1;
        end
    end

    // Synchronizing Read Pointer to Write Domain
    always @(posedge w_clk or posedge rst) begin
        if (rst) begin
            c_rptr_q1 <= {ADDR_SIZE{1'b0}};
            c_rptr_q2 <= {ADDR_SIZE{1'b0}};
        end else begin
            c_rptr_q1 <= c_rptr;
            c_rptr_q2 <= c_rptr_q1;
        end
    end

    // Convert Gray to Binary (at the destination clock domain)
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            assign bin_wptr[i] = ^(c_wptr_q2 >> i);
            assign bin_rptr[i] = ^(c_rptr_q2 >> i);
        end
    endgenerate

    // Empty and Full Conditions
    assign empty = (rptr == bin_wptr);
    assign full = ({~wptr[ADDR_SIZE], wptr[ADDR_SIZE-1:0]} == bin_rptr);

    // Overflow Detection
    always @(posedge w_clk or posedge rst) begin
        if (rst)
            overflow <= 1'b0;
        else if (full && wr)
            overflow <= 1'b1;
        else
            overflow <= 1'b0;
    end

    // Underflow Detection
    always @(posedge r_clk or posedge rst) begin
        if (rst)
            underflow <= 1'b0;
        else if (empty && rd)
            underflow <= 1'b1;
        else
            underflow <= 1'b0;
    end
endmodule
