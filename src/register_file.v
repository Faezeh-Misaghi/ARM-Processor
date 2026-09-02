module register_file
(
    input clk,
    input rst,
    input [3:0] src1,
    input [3:0] src2,
    input [3:0] Dest_WB,
    input [31:0] Result_WB,
    input writeBackEN,
    output [31:0] reg_out_1,
    output [31:0] reg_out_2
);


reg [31:0] registers[0:14];

integer i;

always @(negedge clk or posedge rst)
begin
    if (rst)
    begin
        for (i = 0; i < 15; i = i + 1)
            registers[i] <= i;  
        // registers[9] <= 32'h80000000;
        // registers[10] <= 32'h80000000; 
    end 
    
    else
    
    begin
        if (writeBackEN)
            registers[Dest_WB] <= Result_WB;
    end
end

assign reg_out_1 = registers[src1];
assign reg_out_2 = registers[src2];


endmodule




