# Table of Contents

- [Table of Contents](#table-of-contents)
  - [RISC-V_27](#risc-v_27)
  - [Features](#features)
  - [Microarchitecture](#microarchitecture)
  - [Tools Used](#tools-used)
  - [Design Steps](#design-steps)
  - [Critical Path](#critical-path)
  - [Calculation of Max. Frequency](#calculation-of-max-frequency)
  - [Hazard Handling](#hazard-handling)
  - [RTL View](#rtl-view)
  - [References](#references)

## RISC-V_27

This repository contains the files of a 32-bit RISC - V Core. This is done as part of the excerise given in Harris and Harris Computer Architecture textbook.

## Features

- 32-bit Instruction Format
- Implemented 27 Instructions of the RV32I Core
- 5 Stage Pipeline Design
- Hazard Handling

## Microarchitecture

Diagram was created using draw.io software.
<img src = "https://github.com/NAvi349/riscv-proc/blob/main/images/Microarchitecture.png">

## Tools Used

- Intel Quartus Prime Lite
- VS Code
- Online RISC - V Assembler - <a href = "https://riscvasm.lucasteske.dev/#"> Link </a>

## Design Steps

- Implement Load Word Instruction first
- Then Store Word Instruction
- Modify datapath and decoder to include R - type
- Add branch and store instructions (MUX for PC)
- Debug and Verify
- Pipeline the data path and the controller
- Design Hazard Unit
- Debug and verify

## Critical Path

<img src = "https://github.com/NAvi349/riscv-proc/blob/main/images/critical%20path.png">

## Calculation of Max. Frequency

<img src = "https://user-images.githubusercontent.com/66086031/168416273-65580b88-323b-408d-be84-459795672e54.png">

## Hazard Handling

Occurs when an instruction depends on the results of the previous instruction which is not yet completed.

- **Data Hazards**

  - **Forwarding** - Forward the result from the Memory Stage and the WriteBack stage to the Execute stage.

  - **Stalling** ( for load word ) - Data read from memory is available only at the end of clock cycle. So, we stall the next instructions and forward the memory data from WriteBack stage.

- **Control Hazards**

  - Flushing - Whenever the decision is made to take a branch in Execute stage, flush the next two instructions (Decode and Fetch Stages).

## RTL View

  <img src = "https://github.com/NAvi349/riscv-proc/blob/main/images/RTL%20View.png">

## References

[1] Digital Design and Computer Architecture RISC-V Edition by Sarah Harris, David Harris
</br>
[2] Computer Organization and Design The Hardware Software Interface [RISC-V Edition] by David A. Patterson, John L. Hennessy
