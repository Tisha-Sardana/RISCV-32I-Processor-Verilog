`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 11:37:00
// Design Name: 
// Module Name: controller
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

module controller(
    input  [6:0] op,
    input  [2:0] funct3,
    input        funct7b5,
    input        Zero,
    output       MemWrite,
    output       RegWrite,
    output       ALUSrc,
    output [1:0] ResultSrc,
    output       PCSrc,
    output [1:0] ImmSrc,    // Added this output
    output [2:0] ALUControl
);
    wire [1:0] ALUOp;
    wire       Branch;

    maindec md(op, ResultSrc, MemWrite, Branch, ALUSrc, RegWrite, ALUOp, ImmSrc);
    aludec  ad(op[5], funct3, funct7b5, ALUOp, ALUControl);

    assign PCSrc = Branch & Zero;
endmodule

module maindec(
    input  [6:0] op,
    output reg [1:0] ResultSrc,
    output reg       MemWrite,
    output reg       Branch, 
    output reg       ALUSrc,
    output reg       RegWrite,
    output reg [1:0] ALUOp,
    output reg [1:0] ImmSrc
);
    always @(*) begin
        case(op)
            7'b0000011: begin // LW
                RegWrite=1; ALUSrc=1; MemWrite=0; ResultSrc=2'b01; Branch=0; ALUOp=2'b00; ImmSrc=2'b00;
            end
            7'b0100011: begin // SW
                RegWrite=0; ALUSrc=1; MemWrite=1; ResultSrc=2'b00; Branch=0; ALUOp=2'b00; ImmSrc=2'b01;
            end
            7'b0110011: begin // R-Type
                RegWrite=1; ALUSrc=0; MemWrite=0; ResultSrc=2'b00; Branch=0; ALUOp=2'b10; ImmSrc=2'bxx;
            end
            7'b1100011: begin // BEQ
                RegWrite=0; ALUSrc=0; MemWrite=0; ResultSrc=2'b00; Branch=1; ALUOp=2'b01; ImmSrc=2'b10;
            end
            7'b0010011: begin // ADDI
                RegWrite=1; ALUSrc=1; MemWrite=0; ResultSrc=2'b00; Branch=0; ALUOp=2'b10; ImmSrc=2'b00;
            end
            default: begin 
                RegWrite=0; ALUSrc=0; MemWrite=0; ResultSrc=2'b00; Branch=0; ALUOp=2'b00; ImmSrc=2'b00;
            end
        endcase
    end
endmodule

module aludec(
    input        opb5,
    input  [2:0] funct3,
    input        funct7b5, 
    input  [1:0] ALUOp,
    output reg [2:0] ALUControl
);
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControl = 3'b000; // ADD
            2'b01: ALUControl = 3'b001; // SUB
            default: case(funct3) 
                3'b000: if (funct7b5 & opb5) ALUControl = 3'b001; // SUB
                        else                 ALUControl = 3'b000; // ADD
                3'b010: ALUControl = 3'b101; // SLT
                3'b110: ALUControl = 3'b011; // OR
                3'b111: ALUControl = 3'b010; // AND
                default: ALUControl = 3'b000;
            endcase
        endcase
    end
endmodule
