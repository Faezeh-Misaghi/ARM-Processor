module EXE_Stage_Reg 
(
    input clk, rst, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in,
    input [31:0] ALU_Res_in, Val_Rm_in,
    input [3:0] Dest_in,
    
    output reg WB_EN, MEM_R_EN, MEM_W_EN,
    output reg [31:0] ALU_Res, Val_Rm, 
    output reg [3:0] Dest
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            WB_EN <= 1'b0;
            MEM_R_EN <= 1'b0;
            MEM_W_EN <= 1'b0;
            ALU_Res <= 32'b0;
            Val_Rm <= 32'b0;
            Dest <= 4'b0;
        end
        else begin
            WB_EN <= WB_EN_in;
            MEM_R_EN <= MEM_R_EN_in;
            MEM_W_EN <= MEM_W_EN_in;
            ALU_Res <= ALU_Res_in;
            Val_Rm <= Val_Rm_in;
            Dest <= Dest_in;
        end
    end
   
endmodule
