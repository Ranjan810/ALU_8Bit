`include "alu_defs.vh"

module alu_shift(
    input  [7:0] A,
    input  [3:0] opcode,

    output reg [7:0] result,
    output reg zero,
    output reg negative
);

    always @(*) begin

        // Default value
        result = 8'b0;

        case(opcode)

            // Logical shift left 
            `OP_SLL: result = A << 1;

            // Logical shift right 
            `OP_SRL: result = A >> 1;

            default: result = 8'b0;

        endcase

        // Flags
        zero = (result == 8'b0);
        negative = result[7];

    end

endmodule