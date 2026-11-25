`timescale 1ns/1ps
module tb_alu;
    reg [7:0] A, B;
    reg [2:0] Sel;
    wire [7:0] Result;
    wire CarryOut, Zero;

    alu uut(.A(A), .B(B), .Sel(Sel), .Result(Result),
            .CarryOut(CarryOut), .Zero(Zero));

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);
        $monitor("t=%0t Sel=%b A=%b B=%b -> Result=%b (%0d) Cout=%b Zero=%b",
                 $time, Sel, A, B, Result, Result, CarryOut, Zero);

        A = 8'd15;  B = 8'd10;  Sel = 3'b000; #10;  // add: 25
        A = 8'd20;  B = 8'd5;   Sel = 3'b001; #10;  // sub: 15
        A = 8'hCC;  B = 8'hAA;  Sel = 3'b010; #10;  // and: 10001000
        A = 8'hCC;  B = 8'hAA;  Sel = 3'b011; #10;  // or:  11101110
        A = 8'hCC;  B = 8'hAA;  Sel = 3'b100; #10;  // xor: 01100110
        A = 8'd0;   B = 8'd0;   Sel = 3'b000; #10;  // zero flag
        A = 8'd200; B = 8'd100; Sel = 3'b000; #10;  // add overflow: 44, Cout=1
        A = 8'd5;   B = 8'd20;  Sel = 3'b001; #10;  // sub borrow: 241, Cout=1
        A = 8'd10;  B = 8'd10;  Sel = 3'b001; #10;  // sub to zero
        A = 8'd7;   B = 8'd9;   Sel = 3'b111; #10;  // unused Sel: 0
        $finish;
    end
endmodule