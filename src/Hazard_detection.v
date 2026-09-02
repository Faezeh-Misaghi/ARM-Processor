module hazard_detection
(
    input [3:0] MEM_Dest,
    input MEM_WB_EN,
    input [3:0] EXE_Dest,
    input EXE_WB_EN,
    input [3:0] src1,
    input [3:0] src2,
    input Two_src,
    input forwarding_en,
    input EXE_MEM_R_EN,
    output reg hazard
);

always @(*)begin

    if(forwarding_en == 1'b0) 
    begin 
        if((src1 == EXE_Dest) && (EXE_WB_EN))
            hazard = 1'b1;
        else if((src2 == EXE_Dest) && (EXE_WB_EN) && (Two_src))
            hazard = 1'b1;
        else if((src1 == MEM_Dest) && (MEM_WB_EN))
            hazard = 1'b1;
        else if((src2 == MEM_Dest) && (MEM_WB_EN) && (Two_src))
            hazard = 1'b1;
        else
            hazard = 1'b0;
    end

    else
    begin
        if((src1 == EXE_Dest) && (EXE_WB_EN) && (EXE_MEM_R_EN))
            hazard = 1'b1;
        else if((src2 == EXE_Dest) && (EXE_WB_EN) && (Two_src) && (EXE_MEM_R_EN))
            hazard = 1'b1;
        else
            hazard = 1'b0;
    end
end


endmodule