`timescale 1ns / 1ps
`default_nettype none

module OSC1_LITE_Control(
	input  wire [7:0]  hi_in,
	output wire [1:0]  hi_out,
	inout  wire [15:0] hi_inout,
	inout  wire        hi_aa,

	output wire        hi_muxsel,
	

	input  wire		   clk,

	output wire [7:0]  led,



	/* Output pins*/
	/*
	output wire		clear5,
	output wire		latch5,
	output wire		sclk5,
	output wire		din5,
	input wire 		sdo_bit5,
	*/
	
	output wire [11:0] clear,
    output wire [11:0] latch,
    output wire [11:0] sclk,
    output wire [11:0] din,
    input wire [11:0] sdo_bit
	
	
	);

// Target interface bus:
wire         ti_clk;
wire [30:0]  ok1;
wire [16:0]  ok2;

wire [13:0]  sys_ctrl_pad1;
wire [12:0]  sys_ctrl_pad2;
wire [14:0]  sys_ctrl_pad3;

// reg [6:0] 	 clk_counter;



//input wire 		sdo_bit;
wire 		rst;
wire        pipe;	
wire [2:0]	mode;
wire 		clear_request;

wire [191:0] data_from_user;
//wire [15:0]	data_from_user5;

//wire [15:0] current_to_dac_chip;

//wire [15:0] sdo;



wire pipe_in_write_enable;
wire pipe_out_read_enable;

wire [15:0]  pipe_in_write_data;
wire [15:0]  pipe_out_read_data;

wire [15:0]  period;
wire [15:0]  num_of_pulses;

wire [11:0]	 spi_pipe_clk;

assign hi_muxsel = 1'b0;
//assign current_to_dac_chip = pipe ? {pipe_out_read_data[1:0],pipe_out_read_data[15:8]} : data_from_user;
assign led = rst ? 8'b10101010 : {5'b11111,~mode};

spi_controller dac_spi0 [11:0](
	.clk(clk), //(clk_counter[1]),	// Opal Kelly ti_clk
	.rst(rst),	// Opal Kelly reset
	.mode(mode), // Opal Kelly write bit: 2'b00 for nop, 2'b01 for write, 2'b10 for read
	.clear_request(clear_request),		// OK clr DAC pin

	.pipe(pipe),
	.data_from_memory({pipe_out_read_data[7:0],pipe_out_read_data[15:8]}),
	.data_from_user(data_from_user),	// waveform_info


	.sdo_bit(sdo_bit),		

	.clear(clear),	// DAC input clr
	.latch(latch),	// DAC input latch
	.sclk(sclk),	// DAC input sclk
	.din(din),
	.spi_pipe_clk(spi_pipe_clk)
    );

/*
spi_controller dac_spi(
	.clk(clk), //(clk_counter[1]),	// Opal Kelly ti_clk
	.rst(rst),	// Opal Kelly reset
	.mode(mode), // Opal Kelly write bit: 2'b00 for nop, 2'b01 for write, 2'b10 for read
	.clear_request(clear_request),		// OK clr DAC pin

	.pipe(pipe),
	.data_from_memory({pipe_out_read_data[7:0],pipe_out_read_data[15:8]}),
	.data_from_user(data_from_user5),	// waveform_info


	.sdo_bit(sdo_bit5),		

	//.sdo(sdo),

	// .sdo(sdo),		// DAC output sdo[15:0]. Should contain read data only when read from register
					// For non-feedback control purpose, this variable should not be affecting functionality. See Manual Page 10.

	.clear(clear5),	// DAC input clr
	.latch(latch5),	// DAC input latch
	.sclk(sclk5),	// DAC input sclk
	.din(din5),		// DAC input din
	.spi_pipe_clk(spi_pipe_clk)
    );

*/


amp_pipe my_amp_pipe(
	.ti_clk(ti_clk),
	.reset(rst),
	.clk(spi_pipe_clk[0]),
	.period(period),
	.num_of_pulses(num_of_pulses),
	
	.pipe_in_write_trigger(pipe_in_write_enable),
	.pipe_in_write_data(pipe_in_write_data),
	
	.pipe_out_read_trigger(pipe_out_read_enable),
	.pipe_out_read_data(pipe_out_read_data)
	
);


okHost okHI(
	.hi_in(hi_in), .hi_out(hi_out), .hi_inout(hi_inout), .hi_aa(hi_aa), .ti_clk(ti_clk),
	.ok1(ok1), .ok2(ok2));

wire [17*2-1:0]  ok2x;
okWireOR # (.N(2)) wireOR (ok2, ok2x);
okWireIn     wi00 (.ok1(ok1),                           .ep_addr(8'h00), .ep_dataout({sys_ctrl_pad1, pipe, rst}));
okWireIn     wi01 (.ok1(ok1),                           .ep_addr(8'h01), .ep_dataout({sys_ctrl_pad2, mode}));
okWireIn     wi02 (.ok1(ok1),                           .ep_addr(8'h02), .ep_dataout({sys_ctrl_pad3,clear_request}));
okWireIn     wi03 (.ok1(ok1),                           .ep_addr(8'h03), .ep_dataout(data_from_user[15:0]));
okWireIn     wi04 (.ok1(ok1),                           .ep_addr(8'h04), .ep_dataout(data_from_user[31:16]));
okWireIn     wi05 (.ok1(ok1),                           .ep_addr(8'h05), .ep_dataout(data_from_user[47:32]));
okWireIn     wi06 (.ok1(ok1),                           .ep_addr(8'h06), .ep_dataout(data_from_user[63:48]));
okWireIn     wi07 (.ok1(ok1),                           .ep_addr(8'h07), .ep_dataout(data_from_user[79:64]));
okWireIn     wi08 (.ok1(ok1),                           .ep_addr(8'h08), .ep_dataout(data_from_user[95:80]));


okWireIn     wi09 (.ok1(ok1),                           .ep_addr(8'h09), .ep_dataout(data_from_user[111:96]));
okWireIn     wi0a (.ok1(ok1),                           .ep_addr(8'h0A), .ep_dataout(data_from_user[127:112]));
okWireIn     wi0b (.ok1(ok1),                           .ep_addr(8'h0B), .ep_dataout(data_from_user[143:128]));
okWireIn     wi0c (.ok1(ok1),                           .ep_addr(8'h0C), .ep_dataout(data_from_user[159:144]));
okWireIn     wi0d (.ok1(ok1),                           .ep_addr(8'h0D), .ep_dataout(data_from_user[175:160]));
okWireIn     wi0e (.ok1(ok1),                           .ep_addr(8'h0E), .ep_dataout(data_from_user[191:176]));

okWireIn     wi15 (.ok1(ok1),                           .ep_addr(8'h15), .ep_dataout(period[15:0]));
okWireIn     wi16 (.ok1(ok1),                           .ep_addr(8'h16), .ep_dataout(num_of_pulses[15:0]));

//okWireOut    wo21 (.ok1(ok1), .ok2(ok2x[ 0*17 +: 17 ]), .ep_addr(8'h21), .ep_datain(sdo));
//okWireOut    wo22 (.ok1(ok1), .ok2(ok2x[ 1*17 +: 17 ]), .ep_addr(8'h22), .ep_datain({15'b0,pipe}));

okPipeIn	pi80 ( .ok1(ok1), .ok2(ok2x[ 0*17 +: 17 ]), .ep_addr(8'h80), .ep_write(pipe_in_write_enable), .ep_dataout(pipe_in_write_data));
okPipeOut poa0 ( .ok1(ok1), .ok2(ok2x[ 1*17 +: 17 ]), .ep_addr(8'hA0), .ep_read(pipe_out_read_enable), .ep_datain(pipe_out_read_data));

/*
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		clk_counter <= 0;
	end else begin
		clk_counter <= clk_counter + 1;
	end
end
*/

endmodule