module mux2 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input select,
    output [WIDTH-1:0] out
);

    assign out = (select) ? in1 : in0;
endmodule
