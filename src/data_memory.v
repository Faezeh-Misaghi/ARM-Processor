module data_memory (
    input clk, rst, MEM_R_EN, MEM_W_EN,
    input [31:0] ALU_Res, Val_Rm,
    output reg [31:0] mem_out 
);

    reg [31:0] memory [0:2047];
    
    wire [31:0] address = ALU_Res;

    always @(posedge clk) begin
        if (MEM_W_EN) begin
            memory[address] <= Val_Rm;
        end
    end

    always @(*) begin
        if (MEM_R_EN) begin
            mem_out = memory[address]; 
        end else begin
            mem_out = 32'd0;
        end
    end

endmodule