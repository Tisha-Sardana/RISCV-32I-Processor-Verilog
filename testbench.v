`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2026 00:56:41
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
