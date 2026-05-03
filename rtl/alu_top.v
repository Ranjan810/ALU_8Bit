`include "alu_defs.vh"

module alu_top(
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] opcode,

    output reg [7:0] result,
    output reg carry_out,
    output reg overflow,
    output reg zero,
    output reg negative
);

    // Outputs from submodules
    wire [7:0] arith_result;
    wire       arith_carry;
    wire       arith_overflow;
    wire       arith_zero;
    wire       arith_negative;

    wire [7:0] logic_result;
    wire       logic_zero;
    wire       logic_negative;

    wire [7:0] shift_result;
    wire       shift_zero;
    wire       shift_negative;

    // Instantiation

    alu_arith u_arith (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(arith_result),
        .carry_out(arith_carry),
        .overflow(arith_overflow),
        .zero(arith_zero),
        .negative(arith_negative)
    );

    alu_logic u_logic (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(logic_result),
        .zero(logic_zero),
        .negative(logic_negative)
    );

    alu_shift u_shift (
        .A(A),
        .opcode(opcode),
        .result(shift_result),
        .zero(shift_zero),
        .negative(shift_negative)
    );

    // Output (Mux) 

    always @(*) begin

        // Default
        result     = 8'b0;
        carry_out  = 0;
        overflow   = 0;
        zero       = 0;
        negative   = 0;

        case(opcode)

            // Arithmetic
            `OP_ADD,
            `OP_SUB,
            `OP_INC,
            `OP_DEC: begin
                result     = arith_result;
                carry_out  = arith_carry;
                overflow   = arith_overflow;
                zero       = arith_zero;
                negative   = arith_negative;
            end

            // Logical
            `OP_AND,
            `OP_OR,
            `OP_XOR,
            `OP_NOT: begin
                result     = logic_result;
                zero       = logic_zero;
                negative   = logic_negative;
            end

            // Shift
            `OP_SLL,
            `OP_SRL: begin
                result     = shift_result;
                zero       = shift_zero;
                negative   = shift_negative;
            end

            default: begin
                result = 8'b0;
            end

        endcase
    end

endmodule