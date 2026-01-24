module imem(
    input  [5:0]  a,
    output [31:0] rd
);
    reg [31:0] RAM[63:0];

    initial begin
        // We initialize the memory manually here
        RAM[0] = 32'h200093; // addi x1, x0, 5  (x1 = 5)
        RAM[1] = 32'h200113; // addi x2, x0, 5  (x2 = 5)
        RAM[2] = 32'h002081b3; // add x3, x1, x2 (x3 = 10)
        RAM[3] = 32'h20202223; // sw x3, 32(x0)  (Write 10 to address 32)
    end

    assign rd = RAM[a]; 
endmodule