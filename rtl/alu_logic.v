`include "alu_defs.vh"

module alu_logic(
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] opcode,

    output reg [7:0] result,
    output reg zero,
    output reg negative
);

    always @(*) begin

        // Default value
        result = 8'b0;

        case(opcode)

            `OP_AND: result = A & B;

            `OP_OR:  result = A | B;

            `OP_XOR: result = A ^ B;

            `OP_NOT: result = ~A;

            default: result = 8'b0;

        endcase

        // Flags
        zero = (result == 8'b0);
        negative = result[7];

    end

endmodule