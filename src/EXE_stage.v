module EXE_Stage (
    input WB_EN, MEM_R_EN, MEM_W_EN, imm, carry,
    input [3:0]  EXE_CMD,
    input [31:0] PC, Val_Rn, Val_Rm,
    input [11:0] shift_operand,
    input [23:0] Signed_imm_24,
    input [3:0]  Dest,
    input [1:0] sel_src1,
    input [1:0] sel_src2,

    input [31:0] ALU_Res_MEM,
    input [31:0] WB_Value,


    output WB_EN_out, MEM_R_EN_out, MEM_W_EN_out,
    output [31:0] ALU_Res, Val_Rm_out, Branch_Address,
    output [3:0] Dest_out, Status_bits 
);


wire [31:0] val1;

mux_4to1 #(.WIDTH(32)) mux_src1 (
    .input_0(Val_Rn),
    .input_1(ALU_Res_MEM),
    .input_2(WB_Value),
    .input_3(32'b0),
    .select(sel_src1),
    .out(val1)
);


wire [31:0] val_rm_selected;

mux_4to1 #(.WIDTH(32)) mux_src2 (
    .input_0(Val_Rm),
    .input_1(ALU_Res_MEM),
    .input_2(WB_Value),
    .input_3(32'b0),
    .select(sel_src2),
    .out(val_rm_selected)
);













    wire or_res, co;
    wire [31:0] val2, extended_imm;

    assign or_res = MEM_R_EN || MEM_W_EN;

    Val2Genrate val2G (
    .Val_Rm(val_rm_selected),
    .shift_operand(shift_operand),
    .imm(imm), 
    .or_res(or_res),
    .Val2(val2));

    alu Alu (
    .EXE_CMD(EXE_CMD),
    .in1(val1), 
    .in2(val2),
    .c_in(carry),
    .Satus_bits(Status_bits),
    .out(ALU_Res));

    assign extended_imm = {{8{Signed_imm_24[23]}}, Signed_imm_24};

    adder branch_adder(
    .a(PC), 
    .b(extended_imm),
    .carry_out(co),
    .sum(Branch_Address));

    assign WB_EN_out = WB_EN;
    assign MEM_R_EN_out = MEM_R_EN;
    assign MEM_W_EN_out = MEM_W_EN;
    assign Val_Rm_out = val_rm_selected;
    assign Dest_out = Dest;

endmodule