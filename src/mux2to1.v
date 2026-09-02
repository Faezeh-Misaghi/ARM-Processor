module mux_2to1 #(parameter WIDTH = 32)(
    input  [WIDTH-1:0] input_0,
    input  [WIDTH-1:0] input_1,
    input              select,
    output reg [WIDTH-1:0] out
);

    always @(*) begin
        if (select)
            out = input_1;
        else
            out = input_0;
    end

endmodule
