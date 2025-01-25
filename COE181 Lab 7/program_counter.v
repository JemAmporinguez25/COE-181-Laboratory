module program_counter (
    input clock,
    input reset,
    input [31:0] pc_in,    // External PC input (optional)
    output reg [31:0] pc_out // Program counter output
);
		
    always @(posedge clock ) begin
        if (reset) begin
            pc_out <= 32'h003FFFFC  ; // Reset value
        end else begin
            pc_out <= pc_out + 4; // Increment PC by 4 on every clock cycle
        end
    end
endmodule
