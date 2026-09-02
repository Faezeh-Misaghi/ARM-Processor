module ID_Stage_Reg 
(
    input clk, rst, flush, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in, B_in, S_in, imm_in, carry_in,
    input [3:0]  EXE_CMD_in,
    input [31:0] PC_in, Val_Rn_in, Val_Rm_in,
    input [11:0] shift_operand_in, 
    input [23:0] Signed_imm_24_in, 
    input [3:0] Dest_in,          
    input [3:0] src1_in,
    input [3:0] src2_in,
    
    output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S, imm, carry,
    output reg [3:0]  EXE_CMD,
    output reg [31:0] PC, Val_Rn, Val_Rm,
    output reg [11:0] shift_operand,
    output reg [23:0] Signed_imm_24,
    output reg [3:0]  Dest,
    output reg [3:0] src1,
    output reg [3:0] src2
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            WB_EN <= 1'b0;
            MEM_R_EN <= 1'b0;
            MEM_W_EN <= 1'b0;
            EXE_CMD <= 4'b0;
            B <= 1'b0;
            S <= 1'b0;
            imm <= 1'b0;
            carry <= 1'b0;
            PC <= 32'b0;
            Val_Rn <= 32'b0;
            Val_Rm <= 32'b0;
            shift_operand <= 12'b0;
            Signed_imm_24 <= 24'b0;
            Dest <= 4'b0;
            src1 <= 4'b0;
            src2 <= 4'b0;
        end
        else if (flush) begin
            WB_EN <= 1'b0;
            MEM_R_EN <= 1'b0;
            MEM_W_EN <= 1'b0;
            EXE_CMD <= 4'b0;
            B <= 1'b0;
            S <= 1'b0;
            imm <= 1'b0;
            carry <= 1'b0;
            PC <= 32'b0;
            Val_Rn <= 32'b0;
            Val_Rm <= 32'b0;
            shift_operand <= 12'b0;
            Signed_imm_24 <= 24'b0;
            Dest <= 4'b0;
            src1 <= 4'b0;
            src2 <= 4'b0;
        end
        else begin
            WB_EN <= WB_EN_in;
            MEM_R_EN <= MEM_R_EN_in;
            MEM_W_EN <= MEM_W_EN_in;
            EXE_CMD <= EXE_CMD_in;
            B <= B_in;
            S <= S_in;
            imm <= imm_in;
            carry <= carry_in;
            PC <= PC_in;
            Val_Rn <= Val_Rn_in;
            Val_Rm <= Val_Rm_in;
            shift_operand <= shift_operand_in;
            Signed_imm_24 <= Signed_imm_24_in;
            Dest <= Dest_in;
            src1 <= src1_in;
            src2 <= src2_in;
        end
    end
    
endmodule
