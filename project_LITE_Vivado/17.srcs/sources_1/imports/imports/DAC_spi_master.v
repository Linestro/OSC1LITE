`timescale 1ns / 1ps
/*
OSC1 - LITE
Yoon's Lab - U of M
*/

module spi_controller(
	/* Input pins*/
	input  wire			      clk,	// Opal Kelly ti_clk
	input  wire			      rst,	// Opal Kelly reset
	input  wire [2:0]		  mode, // Opal Kelly write bit: 3'b000 for nop, 3'b001 for write, 3'b010 for read, 3'b011 for control, 3'b100 for reset
	input  wire 			  clear_request,	// OK clr DAC pin
	input  wire [15:0]	  	  data_from_user,	// waveform_info



	input  wire 		  	  sdo_bit,		

	/* Output pins*/
	output reg [15:0]		  sdo,
	output wire			      clear,	// DAC input clr
	output reg			      latch,	// DAC input latch
	output wire			      sclk,		// DAC input sclk
	output reg			      din		// DAC input din
    );

wire [7:0] 	address_byte;
wire [23:0] full_command;

reg  [4:0] 	counter;				// 0 - 23 to clock in the command. 24 - 29 to relax latch HIGH. t5 min = 40ns on Page 9.
wire [4:0]	shift_counter_helper;	// Shifting bit from full_command to din

reg  [15:0] raw_sdo;
reg         update_sdo;

assign shift_counter_helper = ~counter + 5'd24;  // (0 -> 23, 1 -> 22, etc.)

assign clear = clear_request; 								// assign OK clr DAC pin control to clr DAC register. 
assign sclk = clk;											// assign spi input clk equal to Opal Kelly ti_clk
assign address_byte = (mode == 3'b001) ? 8'b00000001 		// See Manual Page 32, 33
		    : (mode == 3'b010) ? 8'b00000010 
		    : (mode == 3'b011) ? 8'b01010101 
		    : (mode == 3'b100) ? 8'b01010110 
		    : 8'b0;			
															
assign full_command = (mode == 3'b010) ?  {address_byte, 16'b0000000000000010} // if read, set read DAC data register
					: (mode == 3'b100) ?  {address_byte, 16'b0000000000000001}
					: {address_byte, data_from_user};			// if write or NOP, {address_byte -> [23:16], data_from_user -> [15:0]}

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		counter <= 0;
		raw_sdo	<= 0;
	end else begin
		counter <= counter + 1;
		raw_sdo	<= {raw_sdo[14:0], sdo_bit};
	end
end

always @ (posedge latch) begin
	if(rst) begin
		sdo   <= 0;
	end else begin
		sdo	  <= raw_sdo;
	end
end

always @ (*) begin

	if(counter >= 5'd23) begin
		if(counter < 5'd24) begin
			latch = 1'b1;
			din = (full_command >> shift_counter_helper) & 1'b1;
//			sdo = raw_sdo;
		end else if(counter < 5'd29) begin
			latch = 1'b1;
			din = 1'b0;
		end else begin
			latch = 1'b0;
			din = 1'b0;
		end
	end else begin
		latch = 1'b0;
		din = (full_command >> shift_counter_helper) & 1'b1;
	end
end
		
endmodule
