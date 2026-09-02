module forwarding_unit (
    input [3:0] src1,
    input [3:0] src2,
    input [3:0] MEM_Dest,
    input [3:0] WB_Dest,
    input MEM_WB_EN,
    input WB_WB_EN,
    output reg [1:0] sel_src1, 
    output reg [1:0] sel_src2 
);

    always @(*) begin
        sel_src1 = 2'b00; 
        
        if (MEM_WB_EN  && (MEM_Dest == src1)) begin
            sel_src1 = 2'b01;
        end
        else if (WB_WB_EN && (WB_Dest == src1)) begin
            sel_src1 = 2'b10;
        end
    end

    always @(*) begin
        sel_src2 = 2'b00; 
        
        if (MEM_WB_EN && (MEM_Dest == src2)) begin
            sel_src2 = 2'b01;
        end
        else if (WB_WB_EN && (WB_Dest == src2)) begin
            sel_src2 = 2'b10;
        end
    end

endmodule