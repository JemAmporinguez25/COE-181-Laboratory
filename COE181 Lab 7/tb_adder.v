module tb_adder();
    reg [31:0] a, b;
    wire [31:0] sum;

    adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        a = 32'h1; b = 32'h1;
        #10 a = 32'h10; b = 32'h20;
        #10 a = 32'hFFFFFFFF; b = 32'h1; // Overflow case
        $finish;
    end
endmodule
