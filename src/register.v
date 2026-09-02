module reg4bit (
    input clk, rst, ld,                              
    input [3:0] in,  
    output reg [3:0] out
);

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            out <= 4'b0000;
        end else begin
            if (ld) begin
                out <= in;
            end
        end
    end

endmodule