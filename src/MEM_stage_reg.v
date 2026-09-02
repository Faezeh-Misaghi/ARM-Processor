module MEM_Stage_Reg 
(
    input clk, rst, WB_EN_in, MEM_R_EN_in,
    input [31:0] ALU_Res_in, Mem_out_in,
    input [3:0] Dest_in,          

    output reg WB_EN, MEM_R_EN,
    output reg [31:0] ALU_Res, Mem_out,
    output reg [3:0] Dest
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            WB_EN <= 1'b0;
            MEM_R_EN <= 1'b0;
            ALU_Res <= 32'b0;
            Mem_out <= 32'b0;
            Dest <= 4'b0;
        end
        else begin
            WB_EN <= WB_EN_in;
            MEM_R_EN <= MEM_R_EN_in;
            ALU_Res <= ALU_Res_in;
            Mem_out <= Mem_out_in;
            Dest <= Dest_in;
        end
    end
    
endmodule
