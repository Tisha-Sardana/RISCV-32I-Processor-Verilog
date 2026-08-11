`timescale 1ns / 1ps

module testbench();
    reg         clk, reset;
    wire [31:0] WriteData, DataAdr;
    wire        MemWrite;

    riscv dut(clk, reset, WriteData, DataAdr, MemWrite);

    initial begin
        clk = 0; forever #5 clk = ~clk;
    end

    initial begin
        reset = 1; #22; reset = 0;
    end
endmodule
