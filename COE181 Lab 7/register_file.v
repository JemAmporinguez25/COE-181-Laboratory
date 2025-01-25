`timescale 1ns / 1ps

module register_file (
    input clock,
    input reset,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input write_enable,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    // 32 registers of 32-bit width
    reg [31:0] registers [31:0];
    integer i;

    // Reset and write logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (write_enable && write_reg != 0) begin
            // Write to the register only if write_enable is high and write_reg is non-zero
            registers[write_reg] <= write_data;
        end
    end

    // Continuous assignment for asynchronous reads
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

endmodule
