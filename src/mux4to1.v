module mux_4to1 #(parameter WIDTH = 32)(
    input  [WIDTH-1:0] input_0,
    input  [WIDTH-1:0] input_1,
    input  [WIDTH-1:0] input_2,
    input  [WIDTH-1:0] input_3,
    input  [1:0] select,
    output reg [WIDTH-1:0] out
);

    always @(*) begin
        if (select == 2'b00)
            out = input_0;
        else if(select == 2'b01)
            out = input_1;
        else if(select == 2'b10)
            out = input_2;
        else if(select == 2'b11)
            out = input_3;
    end

endmodule
