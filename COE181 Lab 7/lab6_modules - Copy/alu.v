module alu(
    input [5:0] Func_in,
    input [31:0] A_in,
    input [31:0] B_in,
    output reg [31:0] O_out,      // Declare as reg for procedural assignment
    output reg Branch_out,        // Declare as reg for procedural assignment
    output reg Jump_out           // Declare as reg for procedural assignment
);
    // Internal variables
    reg [31:0] AdderInputB;
    reg [31:0] AdderOut;
    reg [31:0] LogicOut;
    reg [31:0] SltOut;
    reg DoBranch, DoJump;

    always @(*) begin
        // Adder/Subtractor
        AdderInputB = (Func_in[1]) ? ~B_in : B_in; // Negate for subtraction
        AdderOut = A_in + AdderInputB + Func_in[1];

        // Logic Operations
        case (Func_in[1:0])
            2'b00: LogicOut = A_in & B_in;
            2'b01: LogicOut = A_in | B_in;
            2'b10: LogicOut = A_in ^ B_in;
            2'b11: LogicOut = ~(A_in | B_in); // NOR
        endcase

        // Set Less Than
        SltOut = (Func_in[0]) ? (A_in < B_in) : ($signed(A_in) < $signed(B_in));

        // Branch and Jump
        DoBranch = 1'b0;
        DoJump = 1'b0;
        case (Func_in[2:0])
            3'b000: DoBranch = A_in[31];             // BLTZ
            3'b001: DoBranch = ~A_in[31];            // BGEZ
            3'b010, 3'b011: DoJump = 1'b1;           // J/JR
            3'b100: DoBranch = (A_in == B_in);       // BEQ
            3'b101: DoBranch = (A_in != B_in);       // BNE
            3'b110: DoBranch = (A_in[31] || A_in == 0); // BLEZ
            3'b111: DoBranch = (~A_in[31] && A_in != 0); // BGTZ
        endcase

        // Final ALU Result
        O_out = 32'b0;       // Default
        Branch_out = 1'b0;   // Default
        Jump_out = 1'b0;     // Default

        case (Func_in[5:2])
            4'b1000: O_out = AdderOut;  // ADD/SUB
            4'b1001: O_out = LogicOut; // AND/OR/XOR/NOR
            4'b1010: O_out = SltOut;   // Set Less Than
            4'b1110: begin
                O_out = A_in;          // Branch/Jump
                Branch_out = DoBranch;
                Jump_out = DoJump;
            end
        endcase
    end
endmodule
