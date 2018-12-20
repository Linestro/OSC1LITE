`timescale 1ns / 1ps
`default_nettype none

module OSC1_LITE_Control(
	input  wire [7:0]  hi_in,
	output wire [1:0]  hi_out,
	inout  wire [15:0] hi_inout,
	inout  wire        hi_aa,

	output wire        hi_muxsel,
	

	input  wire			clk,

	output wire [7:0]  led,

	/* Output pins*/
	output wire		clear,
	output wire		latch,
	output wire		sclk,
	output wire		din
	);

// Target interface bus:
wire         ti_clk;
wire [30:0]  ok1;
wire [16:0]  ok2;

wire [14:0]  sys_ctrl_pad1;
wire [13:0]  sys_ctrl_pad2;
wire [14:0]  sys_ctrl_pad3;


assign hi_muxsel = 1'b0;

wire 		rst;	
wire [1:0]	mode;
wire 		clear_request;
wire [15:0]	data_from_user;
wire [15:0]	sdo;

assign led = rst ? 8'b10000001 : 8'b10101010;

spi_controller dac_spi(
	.clk(clk),	// Opal Kelly ti_clk
	.rst(rst),	// Opal Kelly reset
	.mode(mode), // Opal Kelly write bit: 2'b00 for nop, 2'b01 for write, 2'b10 for read
	.clear_request(clear_request),		// OK clr DAC pin
	.data_from_user(data_from_user),	// waveform_info



	.sdo(sdo),		// DAC output sdo[15:0]. Should contain read data only when read from register
					// For non-feedback control purpose, this variable should not be affecting functionality. See Manual Page 10.

	/* Output pins*/
	.clear(clear),	// DAC input clr
	.latch(latch),	// DAC input latch
	.sclk(sclk),	// DAC input sclk
	.din(din)		// DAC input din
    );



okHost okHI(
	.hi_in(hi_in), .hi_out(hi_out), .hi_inout(hi_inout), .hi_aa(hi_aa), .ti_clk(ti_clk),
	.ok1(ok1), .ok2(ok2));

wire [17*1-1:0]  ok2x;
okWireOR # (.N(1)) wireOR (ok2, ok2x);
okWireIn     wi00 (.ok1(ok1),                           .ep_addr(8'h00), .ep_dataout({sys_ctrl_pad1,rst}));
okWireIn     wi01 (.ok1(ok1),                           .ep_addr(8'h01), .ep_dataout({sys_ctrl_pad2,mode}));
okWireIn     wi02 (.ok1(ok1),                           .ep_addr(8'h00), .ep_dataout({sys_ctrl_pad3,clear_request}));
okWireIn     wi03 (.ok1(ok1),                           .ep_addr(8'h01), .ep_dataout(data_from_user));

okWireOut    wo21 (.ok1(ok1), .ok2(ok2x[ 0*17 +: 17 ]), .ep_addr(8'h21), .ep_datain(sdo));

endmodule