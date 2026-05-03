# 8-bit ALU (Verilog)

## Overview
This project implements an 8-bit ALU using Verilog.

Operations supported:
- ADD, SUB, INC, DEC
- AND, OR, XOR, NOT
- Shift Left, Shift Right

The design is modular and consists of arithmetic, logic, and shift units.

---

## Design
The ALU is divided into:
- Arithmetic unit → Performs add/sub/inc/dec
- Logic unit → AND, OR, XOR, NOT
- Shift unit → Left and right shift
- Top module → Selects output using opcode

The design is fully combinational (no flip-flops).

---

## Verification
- Testbench created using Verilog
- Reference model used for checking outputs
- Tested with:
  - Fixed test cases
  - Random test cases (~50)
- All valid cases passed

---

## Synthesis (Yosys)

Tool used: Yosys

### Total Cells: 484

### Cell Breakdown
- ANDNOT: 236  
- AND: 18  
- OR: 92  
- ORNOT: 32  
- XOR: 33  
- XNOR: 16  
- NAND: 19  
- NOR: 24  
- NOT: 12  
- MUX: 2  

---

## Arithmetic Unit Stats
- Cells: 247  
- Major contributors:
  - ANDNOT: 104  
  - OR: 51  
  - XOR: 32  

---

## Observations
- Arithmetic unit uses most hardware
- Logic operations are simple and small
- Shift operations require very little hardware
- No latches were generated
- Design is purely combinational

---

## Conclusion
The ALU works correctly for all tested inputs.  
Arithmetic operations dominate area and delay compared to logic and shift operations.

---