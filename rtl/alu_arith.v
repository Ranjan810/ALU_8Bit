`include "alu_defs.vh"

module alu_arith(
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
    // 9 bits to store carry

    always @(*) begin

        // Default values
        temp = 9'b0;
        result = 8'b0;
        carry_out = 0;
        overflow = 0;

        case(opcode)

            // Addition
            `OP_ADD: begin
                temp = A + B;
                result = temp[7:0];
                carry_out = temp[8];

                overflow = (~A[7] & ~B[7] & result[7]) |
                           ( A[7] &  B[7] & ~result[7]);
            end

            // Subtraction
            `OP_SUB: begin
                temp = A - B;
                result = temp[7:0];
                carry_out = temp[8];

                overflow = (~A[7] & B[7] & result[7]) |
                           (A[7] & ~B[7] & ~result[7]);
            end

            // Increment
            `OP_INC: begin
                temp = A + 1;
                result = temp[7:0];
                carry_out = temp[8];
            end

            // Decrement
            `OP_DEC: begin
                temp = A - 1;
                result = temp[7:0];
                carry_out = temp[8];
            end

            default: begin
                result = 8'b0;
            end

        endcase

        // Flags
        zero = (result == 8'b0);
        negative = result[7];

    end

endmodule