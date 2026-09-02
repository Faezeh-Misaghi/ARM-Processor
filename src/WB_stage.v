module WB_stage
(
    input [31:0] ALU_Res,
    input [31:0] Mem_out,
    input MEM_R_EN,
    output [31:0] Value
);


mux_2to1 #(.WIDTH(32)) mux_WB (
    .input_0(ALU_Res),
    .input_1(Mem_out),
    .select(MEM_R_EN),
    .out(Value)
);


endmodule