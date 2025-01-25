module sign_extender (
    input [15:0] in,
    output [31:0] out
);

    assign out = {{16{in[15]}}, in}; // Sign-extend the 16-bit input
endmodule
