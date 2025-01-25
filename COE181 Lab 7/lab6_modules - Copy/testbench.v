`timescale 1ns / 1ps

module testbench;

    reg clock;
    reg reset;

    // Outputs to monitor from the processor
    wire [31:0] pc_out;           // Program Counter
    wire [31:0] instruction_out;  // Fetched instruction
    wire [31:0] alu_a_out;        // ALU input A
    wire [31:0] alu_b_out;        // ALU input B
    wire [31:0] alu_out_internal; // ALU result
    wire [7:0] serial_out;        // Serial output data
    wire serial_wren_out;         // Serial write enable

    // Instantiate processor
    processortest uut (
        .clock(clock),
        .reset(reset),
        .serial_in(8'b0),             // No serial input for this test
        .serial_valid_in(1'b0),       // No valid input for this test
        .serial_ready_in(1'b1),       // Serial is always ready to accept writes
        .serial_out(serial_out),      // Serial output
        .serial_rden_out(),           // Not used in this test
		  .serial_wren_out(serial_wren_out), // Serial write enable
        .pc_out(pc_out),              // Program Counter output
        .instruction_out(instruction_out), // Fetched instruction
        .alu_a_out(alu_a_out),        // ALU input A
        .alu_b_out(alu_b_out),        // ALU input B
        .alu_out_internal(alu_out_internal) // ALU result
    );

    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Toggle clock every 5 ns
    end

    // Reset logic
    initial begin
        reset = 1;
        #20 reset = 0; // Release reset after 20 ns
    end

    // Monitor important signals
    initial begin
        $monitor("Time: %0t | PC: %h | Instr: %h | ALU A: %h | ALU B: %h | ALU Out: %h | Serial Out: %c | Serial WREN: %b",
                 $time, pc_out, instruction_out, alu_a_out, alu_b_out, alu_out_internal, serial_out, serial_wren_out);
    end

    // Monitor serial writes
    always @(posedge clock) begin
        if (serial_wren_out) begin
            $display("Time: %0t | Serial Write: %c (ASCII: %h)", $time, serial_out, serial_out);
        end
    end

    // Simulation end condition
    initial begin
        #5000; // Simulate for 5000 ns
        $stop; // Stop simulation
    end

endmodule
