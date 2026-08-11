module riscv(
    input         clk, reset,
    output [31:0] WriteData, DataAdr,
    output        MemWrite
);
    wire [31:0] PC, Instr, ReadData, ALUResult;
    wire        ALUSrc, RegWrite, Jump, Zero, PCSrc;
    wire [1:0]  ResultSrc, ImmSrc;
    wire [2:0]  ALUControl;

    controller c(Instr[6:0], Instr[14:12], Instr[30], Zero,
                 MemWrite, RegWrite, ALUSrc, ResultSrc, PCSrc, ImmSrc, ALUControl);

    datapath dp(clk, reset, ResultSrc, PCSrc, ALUSrc, RegWrite,
                ImmSrc, ALUControl, Zero, PC, Instr,
                ALUResult, WriteData, ReadData);
                
    assign DataAdr = ALUResult;

    imem imem(PC[7:2], Instr);
    dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
