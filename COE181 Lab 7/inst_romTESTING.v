module inst_romTESTING (
    input clock,
    input reset,
    input [31:0] addr_in,
    output reg [31:0] data_out
);
    parameter ADDR_WIDTH = 10;

    // Declare ROM with hardcoded instructions
    reg [31:0] rom [0:2**ADDR_WIDTH-1];
    integer i; // Declare loop variable

    // Initialize ROM with hardcoded values
    initial begin
        rom[0]  = 32'h00400a20;
        rom[1]  = 32'h20504a01;
        rom[2]  = 32'h20504a01;
        rom[3]  = 32'h20504a01;
        rom[4]  = 32'h20504a01;
        rom[5]  = 32'h20504a01;
        rom[6]  = 32'h20504a01;
        rom[7]  = 32'h20504a01;
        rom[8]  = 32'h20504a01;
        rom[9]  = 32'h20504a01;
        rom[10] = 32'h20504a01;
        rom[11] = 32'h20504a01;
        rom[12] = 32'h20504a01;
        rom[13] = 32'h20504a01;
        rom[14] = 32'h20504a01;
        rom[15] = 32'h01000b20;
        rom[16] = 32'h00004bad;
        rom[17] = 32'h20586b01;
        rom[18] = 32'h04004bad;
        rom[19] = 32'h20586b01;
        rom[20] = 32'h08004bad;
        rom[21] = 32'h20586b01;
        rom[22] = 32'h0c004bad;
        rom[23] = 32'h20586b01;
        rom[24] = 32'h10004bad;
        rom[25] = 32'h20586b01;
        rom[26] = 32'h14004bad;
        rom[27] = 32'h20586b01;
       // rom[28] = 32'h18004bad;
       // rom[29] = 32'h20586b01;
        //rom[30] = 32'h1c004bad;
        //rom[31] = 32'h20586b01;
        //rom[32] = 32'h20004bad;
        //rom[33] = 32'h20586b01;
        //rom[34] = 32'h24004bad;
        //rom[35] = 32'h20586b01;
       // rom[36] = 32'h28004bad;
       // rom[37] = 32'h20586b01;
       // rom[38] = 32'h2c004bad;
       // rom[39] = 32'h20586b01;
      ////  rom[40] = 32'h30004bad;
      //  rom[41] = 32'h20586b01;
      ////  rom[42] = 32'h34004bad;
      //  rom[43] = 32'h20586b01;
      //  rom[44] = 32'h38004bad;
      //  rom[45] = 32'h20586b01;
      //  rom[46] = 32'h3c004bad;
      //  rom[47] = 32'h20586b01;
      //  rom[48] = 32'h40004bad;
      //  rom[49] = 32'h20586b01;
      //  rom[50] = 32'h44004bad;
      //  rom[51] = 32'h20586b01;
      //  rom[52] = 32'h48004bad;
      //  rom[53] = 32'h20586b01;
       // rom[54] = 32'h4c004bad;
      //  rom[55] = 32'h20586b01;
      //  rom[56] = 32'h50004bad;
      //  rom[57] = 32'h20586b01;
      //  rom[58] = 32'h54004bad;
       // rom[59] = 32'h20586b01;
      //  rom[60] = 32'h58004bad;
       // rom[61] = 32'h20586b01;
       // rom[62] = 32'h5c004bad;
       // rom[63] = 32'h20586b01;
       // rom[64] = 32'h60004bad;
      //  rom[65] = 32'h20586b01;
       // rom[66] = 32'h64004bad;
      //  rom[67] = 32'h20586b01;
      //  rom[68] = 32'h68004bad;
      //  rom[69] = 32'h20586b01;
      //  rom[70] = 32'h6c004bad;
       // rom[71] = 32'h20586b01;
       // rom[72] = 32'h70004bad;
       // rom[73] = 32'h20586b01;
      //  rom[74] = 32'h74004bad;
       // rom[75] = 32'h20586b01;
       // rom[76] = 32'h78004bad;
       // rom[77] = 32'h70004b8d;
      //  rom[78] = 32'h6c00548d;
      //  rom[79] = 32'h20000000;
       // rom[80] = 32'h25587401;
       // rom[81] = 32'h6400548d;
       // rom[82] = 32'h20000000;
       // rom[83] = 32'h25587401;
      // / rom[84] = 32'h5c00548d;
      //  rom[85] = 32'h20000000;
      //  rom[86] = 32'h25587401;
       // rom[87] = 32'h5400548d;
      //  rom[88] = 32'h20000000;
     //   rom[89] = 32'h25587401;
    //    rom[90] = 32'h5000548d;
   //     rom[91] = 32'h20000000;
   //     rom[92] = 32'h25587401;
   //     rom[93] = 32'h03006b21;
  //      rom[94] = 32'h01000c20;
  //      rom[95] = 32'h22600c00;
        // Add remaining machine codes similarly
		  for (i = 28; i < 2**ADDR_WIDTH; i = i + 1) begin
            rom[i] = 32'h00000000;
        end
    end


    // Fetch instruction with endian correction
    always @(*) begin
        if (reset) begin
            data_out <= 32'h00000000; // Reset output to zero
        end else begin
            // Correct endian swapping to match SPIM's expected order
            data_out <= {
                rom[addr_in[ADDR_WIDTH+1:2]][7:0], 
                rom[addr_in[ADDR_WIDTH+1:2]][15:8], 
                rom[addr_in[ADDR_WIDTH+1:2]][23:16], 
                rom[addr_in[ADDR_WIDTH+1:2]][31:24]
            };
        end
    end
endmodule
