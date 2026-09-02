module ARM
(
    input clk,
    input rst,
    input forwading_en
);

//***************IF stage*******************//

wire [31:0] Instruction_IF, Instruction_ID;
wire [31:0] PC_IF, PC_ID, PC_ID_out, PC_EXE, Branch_Address_EXE;
wire  B_EXE;
wire hazard;

IF_Stage if_stage
(
    .clk(clk),
    .rst(rst),
    .freeze(hazard),
    .Branch_taken(B_EXE),
    .Branch_Address(Branch_Address_EXE),
    .PC(PC_IF),
    .Instruction(Instruction_IF)
);

IF_Stage_Reg if_stage_reg
(
    .clk(clk),
    .rst(rst),
    .freeze(hazard),
    .flush(B_EXE),
    .PC_in(PC_IF),  
    .Instruction_in(Instruction_IF),
    .PC(PC_ID),
    .Instruction(Instruction_ID)
);

//***************ID stage*******************//

wire WB_EN_ID, MEM_R_EN_ID, MEM_W_EN_ID, B_ID, S_ID, Two_src_ID, imm_ID;
wire [3:0]  EXE_CMD_ID, Src1_ID, Src2_ID;
wire [31:0] Val_Rn_ID, Val_Rm_ID;
wire [11:0] shift_operand_ID;
wire [23:0] Signed_imm_24_ID;
wire [3:0]  Dest_ID;
wire [3:0] status_bits_out;

wire [31:0] WB_Value;
wire [3:0] WB_Dest;
wire WB_WB_EN;

ID_Stage id_stage
(
    .clk(clk), 
    .rst(rst), 
    .hazard(hazard),
    .PC_in(PC_ID),
    .instruction(Instruction_ID),
    .SR(status_bits_out),
    .WB_Dest(WB_Dest),
    .WB_Value(WB_Value),
    .WB_WB_EN(WB_WB_EN),
    .PC(PC_ID_out),
    .WB_EN(WB_EN_ID), 
    .MEM_R_EN(MEM_R_EN_ID), 
    .MEM_W_EN(MEM_W_EN_ID), 
    .S_out(S_ID), 
    .B(B_ID), 
    .Two_src(Two_src_ID), 
    .EXE_CMD(EXE_CMD_ID), 
    .Src1(Src1_ID), 
    .Src2(Src2_ID),
    .Val_Rn(Val_Rn_ID),
    .Val_Rm(Val_Rm_ID),
    .Signed_imm_24(Signed_imm_24_ID),
    .imm(imm_ID),
    .Dest(Dest_ID),
    .Shift_operand(shift_operand_ID)

);


wire WB_EN_EXE, MEM_R_EN_EXE, MEM_W_EN_EXE, S_EXE, imm_EXE, carry_EXE;
wire [3:0]  EXE_CMD_EXE;
wire [31:0] Val_Rn_EXE, Val_Rm_EXE;
wire [11:0] shift_operand_EXE;
wire [23:0] Signed_imm_24_EXE;
wire [3:0]  Dest_EXE;
wire [3:0]  Src1_EXE, Src2_EXE;


ID_Stage_Reg id_stage_reg
(
    .clk(clk),
    .rst(rst),
    .flush(B_EXE),
    .WB_EN_in(WB_EN_ID), 
    .MEM_R_EN_in(MEM_R_EN_ID), 
    .MEM_W_EN_in(MEM_W_EN_ID),
    .B_in(B_ID),
    .S_in(S_ID),
    .imm_in(imm_ID),
    .carry_in(status_bits_out[1]),
    .EXE_CMD_in(EXE_CMD_ID),
    .PC_in(PC_ID_out),
    .Val_Rn_in(Val_Rn_ID), 
    .Val_Rm_in(Val_Rm_ID),
    .shift_operand_in(shift_operand_ID), 
    .Signed_imm_24_in(Signed_imm_24_ID), 
    .Dest_in(Dest_ID),

    .src1_in(Src1_ID),
    .src2_in(Src2_ID),


    .WB_EN(WB_EN_EXE),
    .MEM_R_EN(MEM_R_EN_EXE),
    .MEM_W_EN(MEM_W_EN_EXE),
    .B(B_EXE),
    .S(S_EXE),
    .imm(imm_EXE),
    .carry(carry_EXE),
    .EXE_CMD(EXE_CMD_EXE),
    .PC(PC_EXE),
    .Val_Rn(Val_Rn_EXE), 
    .Val_Rm(Val_Rm_EXE),
    .shift_operand(shift_operand_EXE), 
    .Signed_imm_24(Signed_imm_24_EXE), 
    .Dest(Dest_EXE),
    .src1(Src1_EXE),
    .src2(Src2_EXE)
);

//***************EXE stage*******************//

wire WB_EN_EXE_out, MEM_R_EN_EXE_out, MEM_W_EN_EXE_out;
wire [31:0] ALU_Res_EXE, Val_Rm_EXE_out;
wire [3:0] Dest_EXE_out, status_bits_in;


wire [1:0] sel_src1, sel_src2;
wire [31:0] ALU_Res_MEM;

EXE_Stage exe_stage
(   
    .WB_EN(WB_EN_EXE), 
    .MEM_R_EN(MEM_R_EN_EXE), 
    .MEM_W_EN(MEM_W_EN_EXE),  
    .imm(imm_EXE), 
    .carry(carry_EXE),
    .EXE_CMD(EXE_CMD_EXE),
    .PC(PC_EXE), 
    .Val_Rn(Val_Rn_EXE), 
    .Val_Rm(Val_Rm_EXE),
    .shift_operand(shift_operand_EXE),
    .Signed_imm_24(Signed_imm_24_EXE),
    .Dest(Dest_EXE),
    .sel_src1(sel_src1),
    .sel_src2(sel_src2),
    .ALU_Res_MEM(ALU_Res_MEM),
    .WB_Value(WB_Value),

    .WB_EN_out(WB_EN_EXE_out), 
    .MEM_R_EN_out(MEM_R_EN_EXE_out), 
    .MEM_W_EN_out(MEM_W_EN_EXE_out), 
    .ALU_Res(ALU_Res_EXE), 
    .Val_Rm_out(Val_Rm_EXE_out), 
    .Branch_Address(Branch_Address_EXE),
    .Dest_out(Dest_EXE_out), 
    .Status_bits(status_bits_in) 
);

wire WB_EN_MEM, MEM_R_EN_MEM, MEM_W_EN_MEM;
wire [31:0] Val_Rm_MEM;
wire [3:0] Dest_MEM;

EXE_Stage_Reg exe_stage_reg
(
    .clk(clk), 
    .rst(rst), 
    .WB_EN_in(WB_EN_EXE_out), 
    .MEM_R_EN_in(MEM_R_EN_EXE_out), 
    .MEM_W_EN_in(MEM_W_EN_EXE_out),
    .ALU_Res_in(ALU_Res_EXE), 
    .Val_Rm_in(Val_Rm_EXE_out),
    .Dest_in(Dest_EXE_out),
    
    .WB_EN(WB_EN_MEM), 
    .MEM_R_EN(MEM_R_EN_MEM), 
    .MEM_W_EN(MEM_W_EN_MEM),
    .ALU_Res(ALU_Res_MEM), 
    .Val_Rm(Val_Rm_MEM), 
    .Dest(Dest_MEM)
);

//***************Status Register***************//


reg4bit Status_bits(
    .clk(clk), 
    .rst(rst), 
    .ld(S_EXE),                              
    .in(status_bits_in),  
    .out(status_bits_out)
);



//***************Memory Stage***************//

wire MEM_R_EN_WB;
wire [31:0] ALU_Res_WB, Mem_out_WB, Mem_out_MEM;


MEM_Stage mem_stage
(
    .clk(clk),
    .rst(rst),
    .MEM_R_EN(MEM_R_EN_MEM),
    .MEM_W_EN(MEM_W_EN_MEM),
    .ALU_Res(ALU_Res_MEM),
    .Val_Rm(Val_Rm_MEM),
    .out(Mem_out_MEM)
);


MEM_Stage_Reg mem_stage_reg
(
    .clk(clk),
    .rst(rst),
    .WB_EN_in(WB_EN_MEM),
    .MEM_R_EN_in(MEM_R_EN_MEM),
    .ALU_Res_in(ALU_Res_MEM),
    .Mem_out_in(Mem_out_MEM),
    .Dest_in(Dest_MEM),


    .WB_EN(WB_WB_EN),
    .MEM_R_EN(MEM_R_EN_WB),
    .ALU_Res(ALU_Res_WB),
    .Mem_out(Mem_out_WB),
    .Dest(WB_Dest)
);


//***************Write Back Stage***************//

WB_stage wb_stage
(
    .ALU_Res(ALU_Res_WB),
    .Mem_out(Mem_out_WB),
    .MEM_R_EN(MEM_R_EN_WB),
    .Value(WB_Value)
);

//***************Hazard Detection Unit***************//


hazard_detection hazard_detection_unit
(
    .MEM_Dest(Dest_MEM),
    .MEM_WB_EN(WB_EN_MEM),
    .EXE_Dest(Dest_EXE),
    .EXE_WB_EN(WB_EN_EXE),
    .src1(Src1_ID),
    .src2(Src2_ID),
    .Two_src(Two_src_ID),
    .forwarding_en(forwading_en),
    .EXE_MEM_R_EN(MEM_R_EN_EXE),
    .hazard(hazard)
);

//***************Forwarding Unit***************//


forwarding_unit forwading_unit_inst(
    .src1(Src1_EXE),
    .src2(Src2_EXE),
    .MEM_Dest(Dest_MEM),
    .WB_Dest(WB_Dest),
    .MEM_WB_EN(WB_EN_MEM),
    .WB_WB_EN(WB_WB_EN),
    .sel_src1(sel_src1),
    .sel_src2(sel_src2)
);


endmodule