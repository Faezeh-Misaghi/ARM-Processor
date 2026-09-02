module alu (
    input [3:0] EXE_CMD,
    input [31:0] in1, in2,
    input c_in,
    output [3:0] Satus_bits,
    output [31:0] out
);

    reg [31:0] alu_res;
    reg n_flag, z_flag, c_flag, v_flag;

    always @(*) begin

        alu_res = 32'd0;
        n_flag = 1'b0;
        z_flag = 1'b0;
        c_flag = 1'b0;
        v_flag = 1'b0;

        case (EXE_CMD)

            4'b0001: begin
                alu_res = in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
            end


            4'b1001: begin
                alu_res = ~in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
            end

            4'b0010: begin
                {c_flag, alu_res} = in1 + in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
                v_flag = (in1[31] == in2[31]) && (alu_res[31] != in1[31]);
            end

            4'b0011: begin
                {c_flag, alu_res} = in1 + in2 + c_in;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
                v_flag = (in1[31] == in2[31]) && (alu_res[31] != in1[31]);
            end

            4'b0100: begin
                alu_res = in1 - in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
                c_flag = (in1 >= in2);
                v_flag = (in1[31] != in2[31]) && (alu_res[31] == in2[31]);
            end


            4'b0101: begin
                {c_flag,alu_res} = (c_in) ? (in1 - in2) : (in1 - in2 - 32'd1) ;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
                v_flag = (in1[31] != in2[31]) && (alu_res[31] == in2[31]);
            end

            4'b0110: begin
                alu_res = in1 & in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
            end

            4'b0111: begin
                alu_res = in1 | in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
            end

            4'b1000: begin
                alu_res = in1 ^ in2;
                n_flag = alu_res[31];
                z_flag = (alu_res == 32'd0);
            end
            
            default: begin
                alu_res = 32'd0;
                n_flag = 1'b0;
                z_flag = 1'b1; 
                c_flag = 1'b0;
                v_flag = 1'b0;
            end
        endcase
    end

    assign out = alu_res;
    assign Satus_bits = {n_flag, z_flag, c_flag, v_flag};
 
endmodule