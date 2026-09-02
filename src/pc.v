module pc
(
    input clk, reset, freeze,
    input [31:0] in,
    output reg [31:0] out
);

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            out <= 32'b0;
        else if(~freeze)
            out <= in;
    end

endmodule