module data_memory(
    input clock,
    input reset,
    input [31:0] addr_in,
    input [31:0] writedata_in,
    input re_in, we_in,
    input [1:0] size_in,
    output reg [31:0] readdata_out,
    input [7:0] serial_in,
    input serial_ready_in, serial_valid_in,
    output [7:0] serial_out,
    output serial_rden_out, serial_wren_out
);

    parameter INIT_PROGRAM0 = "C:/intelFPGA_lite/18.1/lab7_tests/nbhelloworld.data_ram0.memh";
    parameter INIT_PROGRAM1 = "C:/intelFPGA_lite/18.1/lab7_tests/nbhelloworld.data_ram1.memh";
    parameter INIT_PROGRAM2 = "C:/intelFPGA_lite/18.1/lab7_tests/nbhelloworld.data_ram2.memh";
    parameter INIT_PROGRAM3 = "C:/intelFPGA_lite/18.1/lab7_tests/nbhelloworld.data_ram3.memh";

    wire [31:0] data_readdata_serial, data_readdata_data, data_readdata_stack;

    // Select the correct memory segment based on the address
    always @(*) begin
        case (addr_in[31:16])
            16'h1000: readdata_out <= data_readdata_data;
            16'h7fff: readdata_out <= data_readdata_stack;
            16'hffff: readdata_out <= data_readdata_serial;
            default:  readdata_out <= 32'b0;
        endcase
    end

    // Data Segment
    async_memory #(
        .MEM_ADDR(16'h1000),
        .DO_INIT(1),
        .INIT_PROGRAM0(INIT_PROGRAM0),
        .INIT_PROGRAM1(INIT_PROGRAM1),
        .INIT_PROGRAM2(INIT_PROGRAM2),
        .INIT_PROGRAM3(INIT_PROGRAM3)
    ) data_seg (
        .clock(clock),
        .reset(reset),
        .addr_in(addr_in),
        .size_in(size_in),
        .data_out(data_readdata_data),
        .re_in(re_in),
        .data_in(writedata_in),
        .we_in(we_in)
    );

    // Stack Segment
    async_memory #(
        .MEM_ADDR(16'h7fff)
    ) stack_seg (
        .clock(clock),
        .reset(reset),
        .addr_in(addr_in),
        .size_in(size_in),
        .data_out(data_readdata_stack),
        .re_in(re_in),
        .data_in(writedata_in),
        .we_in(we_in)
    );

    // Serial MMIO
    serial_buffer #(
        .MEM_ADDR(16'hffff)
    ) ser (
        .clock(clock),
        .reset(reset),
        .addr_in(addr_in),
        .data_out(data_readdata_serial),
        .re_in(re_in),
        .data_in(writedata_in),
        .we_in(we_in),
        .s_data_valid_in(serial_valid_in),
        .s_data_ready_in(serial_ready_in),
        .s_data_in(serial_in),
        .s_rden_out(serial_rden_out),
        .s_data_out(serial_out),
        .s_wren_out(serial_wren_out)
    );
endmodule
