module Val2Genrate (
    input [31:0] Val_Rm,
    input [11:0] shift_operand,
    input imm, or_res,
    output reg [31:0] Val2 
);

    wire [3:0] rotate_imm = shift_operand[11:8];
    wire [7:0] immed_8 = shift_operand[7:0];
    wire [4:0] shift_imm = shift_operand[11:7];
    wire [1:0] shift_type = shift_operand[6:5];

    wire [31:0] base_val = {24'b0, immed_8};
    wire [4:0] rotate_amount = rotate_imm * 2;

    always @(*) begin
        if (or_res) begin
            
            Val2 = {{20{shift_operand[11]}}, shift_operand};
        end else begin
            if (imm) begin
                Val2 = (base_val >> rotate_amount) | (base_val << (32 - rotate_amount));
            end else begin
                case (shift_type)
                    // Logical Shift Left
                    2'b00: Val2 = Val_Rm << shift_imm;
                    
                    // Logical Shift Right
                    2'b01: Val2 = Val_Rm >> shift_imm;
                    
                    // Arithmetic Shift Right
                    2'b10: Val2 = $signed(Val_Rm) >>> shift_imm;
                    
                    // Rotate Right
                    2'b11: Val2 = (Val_Rm >> shift_imm) | (Val_Rm << (32 - shift_imm));

                    default: Val2 = Val_Rm; 
                endcase
            end
        end
    end
    
endmodule
