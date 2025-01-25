module data_memory(

	input clock,

	input reset,



	input [31:0] addr_in,	//Read/Write address

	input [31:0] writedata_in, //Data to write to memory

	input re_in, //Read Enable - set high when reading from memory

	input we_in, //Write Enable - set high when writing to memory

	output [31:0] readdata_out, //Data output for reads from memory

	input [1:0] size_in, //Not used yet - hardwire to 2'b11



	//these are used to let your processor print things to a serial port (e.g. "Hello World")

	//wire them up to the same ports in your processor module so they can talk to the test bench

	input [7:0] serial_in,

	input serial_ready_in,

	input serial_valid_in,

	output [7:0] serial_out,

	output serial_rden_out,

	output serial_wren_out

);

parameter INIT_PROGRAM0; //we will use these 4 parameters to preload data into RAM

parameter INIT_PROGRAM1;

parameter INIT_PROGRAM2;

parameter INIT_PROGRAM3;
endmodule

