`include "alu_defs.vh"

module alu_tb;

    reg [7:0] A, B;
    reg [3:0] opcode;

    wire [7:0] result;
    wire carry_out, overflow, zero, negative;
    wire [7:0] ref_result;
    wire ref_carry, ref_overflow, ref_zero, ref_negative;

    alu_ref_model ref (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(ref_result),
        .carry_out(ref_carry),
        .overflow(ref_overflow),
        .zero(ref_zero),
        .negative(ref_negative)
    );
    // DUT
    alu_top uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .carry_out(carry_out),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    // Waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_tb);
    end

    // Testing Task
    task test;
    input [7:0] a_in, b_in;
    input [3:0] op_in;
    begin
        A = a_in;
        B = b_in;
        opcode = op_in;
        #10;

        if (result !== ref_result ||
            carry_out !== ref_carry ||
            overflow !== ref_overflow ||
            zero !== ref_zero ||
            negative !== ref_negative) begin

            $display("Did not Match with Golden Reference: A=%d B=%d OP=%b | DUT=%d REF=%d | C=%b/%b V=%b/%b",
          A, B, opcode,
          result, ref_result,
          carry_out, ref_carry,
          overflow, ref_overflow);

        end 
        else begin
            $display("Matched with Golden Reference: A=%d B=%d OP=%b | RESULT=%d",
                      A, B, opcode, result);
        end
        end
    endtask

    initial begin

        // Arithmetic
        test(8'd10, 8'd5, `OP_ADD);
        test(8'd10, 8'd5, `OP_SUB);
        test(8'd255, 8'd1, `OP_ADD);   // carry case
        test(8'd0, 8'd1, `OP_SUB);     // underflow
        test(8'd127, 8'd1, `OP_ADD);   // overflow
        test(8'd128, 8'd1, `OP_SUB);   // overflow

        // Logical
        test(8'b10101010, 8'b11001100, `OP_AND);
        test(8'b10101010, 8'b11001100, `OP_OR);
        test(8'b10101010, 8'b11001100, `OP_XOR);
        test(8'b10101010, 8'b00000000, `OP_NOT);

        // Shift
        test(8'b00001111, 0, `OP_SLL);
        test(8'b00001111, 0, `OP_SRL);

        // Increment or Decrement
        test(8'd10, 0, `OP_INC);
        test(8'd10, 0, `OP_DEC);

        repeat (50) begin
        test($random, $random, ($random % 10 + 10) % 10);
        end
        #20;
        $finish;

    end

endmodule