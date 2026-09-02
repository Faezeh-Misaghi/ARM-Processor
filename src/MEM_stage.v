module MEM_Stage
(
    input clk, rst, MEM_R_EN, MEM_W_EN,
    input [31:0] ALU_Res,
    input [31:0] Val_Rm,
    output [31:0] out
    
);

data_memory data_memory_MEM
(
    .clk(clk),
    .rst(rst),
    .MEM_R_EN(MEM_R_EN),
    .MEM_W_EN(MEM_W_EN),
    .ALU_Res(ALU_Res),
    .Val_Rm(Val_Rm),
    .mem_out(out)
);


endmodule