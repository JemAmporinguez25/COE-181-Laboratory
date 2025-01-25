module tb_mux2();
    reg [31:0] in0, in1;
    reg sel;
    wire [31:0] out;

    mux2 uut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        in0 = 32'h12345678; in1 = 32'h87654321; sel = 0;
        #10 sel = 1;
        #10 sel = 0;
        $finish;
    end
endmodule
