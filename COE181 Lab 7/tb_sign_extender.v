module tb_sign_extender();
    reg [15:0] in;
    wire [31:0] out;

    sign_extender uut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 16'h7FFF; // Positive value
        #10 in = 16'h8000; // Negative value
        #10 in = 16'h1234; // Small positive value
        $finish;
    end
endmodule
