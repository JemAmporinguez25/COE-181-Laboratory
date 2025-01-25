module inst_rom (
    input clock,
    input reset,
    input [31:0] addr_in,
    output reg [31:0] data_out
);

    parameter ADDR_WIDTH = 5;
    parameter INIT_PROGRAM = "C:/intelFPGA_lite/18.1/lab7_tests/lab7-test.inst_rom.memh";
//"C:\intelFPGA_lite\18.1\testhex.mem"
//
    reg [31:0] rom [0:(2**ADDR_WIDTH)-1];

    // Initialize ROM with data from the file
    initial begin
        $readmemh(INIT_PROGRAM, rom);
    end

    // Fetch instruction with optional endian correction
    always @(*) begin
        if (reset) begin
            data_out = 32'h00000000; // Reset output to zero
        end else begin
            // Correct endian swapping to match SPIM's expected order
            data_out = {
                rom[addr_in[ADDR_WIDTH+1:2]][7:0], 
                rom[addr_in[ADDR_WIDTH+1:2]][15:8], 
                rom[addr_in[ADDR_WIDTH+1:2]][23:16], 
                rom[addr_in[ADDR_WIDTH+1:2]][31:24]
            };
        end
    end
endmodule
