module fifo (
    input clk, reset, push_i, pop_i,
    input [7:0] data_in,
    output reg [7:0] data_out
);
    reg [7:0] stack [3:0];
    reg [1:0] wr_ptr, rd_ptr;
    reg full, empty;
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1)
            stack[i] <= 8'b0;
            data_out <= 8'b0;
            wr_ptr <= 0;
            rd_ptr <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            if (push_i && !full) begin
                stack[wr_ptr] <= data_in;
                wr_ptr <= (wr_ptr + 1) % 4;
            end
            if (pop_i && !empty) begin
                data_out <= stack[rd_ptr];
                stack[rd_ptr]<=0;
                rd_ptr <= (rd_ptr + 1) % 4;
            end
            if(pop_i && !empty & push_i && !full) begin
            stack[wr_ptr] <= data_in;
                wr_ptr <= (wr_ptr + 1) % 4;
             data_out <= stack[rd_ptr];
                stack[rd_ptr]<=0;
                rd_ptr <= (rd_ptr + 1) % 4;
            end
            full <= (wr_ptr + 1) % 4 == rd_ptr;
            empty <= wr_ptr == rd_ptr;
        end
    end
endmodule
