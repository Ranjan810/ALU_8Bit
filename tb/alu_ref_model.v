`include "alu_defs.vh"

module alu_ref_model(
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] opcode,

    output reg [7:0] result,
    output reg carry_out,
    output reg overflow,
    output reg zero,
    output reg negative
);

    reg [8:0] temp;

    always @(*) begin

        // Default values
        temp = 9'd0;
        result = 8'd0;
        carry_out = 0;
        overflow = 0;

        case(opcode)

            // Arithmetic
            `OP_ADD: begin
                temp = A + B;
                result = temp[7:0];
                carry_out = temp[8];

                overflow = (~A[7] & ~B[7] & result[7]) |
                           ( A[7] &  B[7] & ~result[7]);
            end

            `OP_SUB: begin
                temp = A - B;
                result = temp[7:0];
                carry_out = temp[8];

                overflow = (~A[7] & B[7] & result[7]) |
                           ( A[7] & ~B[7] & ~result[7]);
            end

            `OP_INC: begin
                temp = A + 1;
                result = temp[7:0];
                carry_out = temp[8];
            end

            `OP_DEC: begin
                temp = A - 1;
                result = temp[7:0];
                carry_out = temp[8];
            end

            // Logical
            `OP_AND: result = A & B;
            `OP_OR:  result = A | B;
            `OP_XOR: result = A ^ B;
            `OP_NOT: result = ~A;

            // Shift
            `OP_SLL: result = A << 1;
            `OP_SRL: result = A >> 1;

            default: result = 8'd0;

        endcase

        // Flags
        zero = (result == 8'd0);
        negative = result[7];

    end

endmodule