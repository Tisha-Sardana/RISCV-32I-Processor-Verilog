module imem(
    input  [5:0]  a,
    output [31:0] rd
);
    reg [31:0] RAM[63:0];

    initial begin
        
        RAM[0] = 32'h200093; // addi x1, x0, 2  (x1 = 2)
        RAM[1] = 32'h200113; // addi x2, x0, 2  (x2 = 2)
        RAM[2] = 32'h002081b3; // add x3, x1, x2 (x3 = 4)
        RAM[3] = 32'h20202223; // sw x3, 32(x0)  (Write 4 to address 32)
    end

    assign rd = RAM[a]; 
endmodule
