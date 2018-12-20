`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:25 02/05/2016 
// Design Name: 
// Module Name:    pipe_in 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spi_master(
	input  wire				  clk,
	input  wire				  rst,
	input  wire [359:0]	  data_out,
	output reg				  in_clk,
	output reg				  in_scan_in,
	output reg				  in_latch,
	output reg	[9:0]		  counter,
	output wire				  spi_pipe_clk
    );

reg [479:0]			in_scan_in_shift;

//---------- end of defitinitions, start defining module functionality

assign spi_pipe_clk = (counter == 10'd980);

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		counter <= 0;
	end else begin
		counter <= counter + 1;
	end
end


always @ (*) begin

	in_scan_in = in_scan_in_shift[479];

	//synchronizing code
	if(counter[9:0] >= 10'd960) begin
		if(counter[9:0] < 10'd970)
			in_latch = 1;
		else if(counter[9:0] < 10'd980)
			in_latch = 0;
		else
			in_latch = 1;
		in_scan_in_shift = 16'd0;
		in_clk = 1'b0;
	end else begin
		in_latch = 1'b0;
		in_scan_in_shift = {120'd0,data_out} << counter[9:1];
		in_clk = counter[0];
	end
end
		
endmodule
