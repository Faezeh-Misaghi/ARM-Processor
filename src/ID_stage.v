module ID_Stage
(
    input  clk, rst, hazard,
    input [31:0] PC_in, instruction,
    input [3:0] SR,
    input [3:0] WB_Dest,
    input [31:0] WB_Value,
    input WB_WB_EN,
    output [31:0] PC,
    output WB_EN, MEM_R_EN, MEM_W_EN, S_out, B, Two_src, 
    output [3:0] EXE_CMD, Src1, Src2,
    output [31:0] Val_Rn,
    output [31:0] Val_Rm,
    output [23:0] Signed_imm_24,
    output imm,
    output [3:0] Dest,
    output [11:0] Shift_operand

);

assign PC = PC_in;

wire [3:0] Cond, OPcode, Rn, Rm;
wire S;
wire [1:0] Mode;

assign Cond = instruction[31:28];
assign Mode = instruction[27:26];
assign imm = instruction[25];
assign OPcode = instruction[24:21];
assign S = instruction[20];
assign Rn = instruction[19:16];
assign Dest = instruction[15:12];
assign Shift_operand = instruction[11:0];
assign Rm = instruction[3:0];
assign Signed_imm_24 = instruction[23:0];
assign Src1 = Rn;

wire uncond_WB_EN, uncond_MEM_R_EN, uncond_MEM_W_EN, uncond_S, uncond_B;
wire [3:0] uncond_EXE_COM;

control_unit control_unit_inst(
  .OPCode(OPcode),
  .Mode(Mode),
  .S(S),
  .out({uncond_WB_EN, uncond_MEM_R_EN, uncond_MEM_W_EN, uncond_EXE_COM, uncond_S, uncond_B})
);

wire cond_sel;
mux_2to1 #(.WIDTH(9)) mux_cond (
    .input_0({uncond_WB_EN, uncond_MEM_R_EN, uncond_MEM_W_EN, uncond_EXE_COM, uncond_S, uncond_B}),
    .input_1(9'b0),
    .select(cond_sel),
    .out({WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, S_out, B})
);

wire cond_flag;
condition_check cond_check_inst
(
  .Cond(Cond),
  .SR(SR),
  .out(cond_flag)
);

assign cond_sel = hazard || ~ cond_flag;
assign Two_src = ~(imm || uncond_MEM_R_EN);

mux_2to1 #(.WIDTH(4)) mux_src2 (
    .input_0(Rm),
    .input_1(Dest),
    .select(uncond_MEM_W_EN),
    .out(Src2)
);

register_file reg_file
(
  .clk(clk),
  .rst(rst),
  .src1(Src1),
  .src2(Src2),
  .Dest_WB(WB_Dest),
  .Result_WB(WB_Value),
  .writeBackEN(WB_WB_EN),
  .reg_out_1(Val_Rn),
  .reg_out_2(Val_Rm)
);

endmodule