module adder
(
    input [31:0] a, b,
    output carry_out,
    output [31:0] sum
);

    assign {carry_out,sum} = a + b;

endmodule