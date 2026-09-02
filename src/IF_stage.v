module IF_Stage
(
    input  clk, rst, freeze, Branch_taken,
    input [31:0] Branch_Address,
    output [31:0] PC, Instruction
);
    wire [31:0] pc_in, pc_out, pc_plus_1;
    wire co; 
    assign PC = pc_plus_1;

    pc pc_reg(.clk(clk), .reset(rst), .freeze(freeze), .in(pc_in), .out(pc_out));
    adder pc_adder ( .a(32'd1), .b(pc_out), .carry_out(co), .sum(pc_plus_1));
    instruction_mem inst_mem ( .addr(pc_out), .instruction(Instruction));
    mux_2to1 #(.WIDTH(32)) pc_mux(.input_0(pc_plus_1), .input_1(Branch_Address), .select(Branch_taken), .out(pc_in));


endmodule