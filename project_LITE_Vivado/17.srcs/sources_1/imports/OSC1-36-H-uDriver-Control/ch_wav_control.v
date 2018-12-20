`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:03 04/07/2018 
// Design Name: 
// Module Name:    ch_wav_control 
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
module ch_wav_control(
	input wire				clk,
	input wire				rst,
	input wire [9:0]		spi_counter,
	input wire [31:0]		wave1params,
	input wire [31:0]		wave2params,
	input wire [31:0]		wave3params,
	input wire [31:0]		wave4params,
	input wire [3:0] 		chparams,
	input wire				cont_trig,
	input wire				pctrig,
	input wire				extrigin,


	input wire [9:0]		read_data_from_pipe,
	
	output reg [9:0]		data_out,
	
	output wire flag,
	output reg  trigout
		

);

assign flag = trigged;
		

//Doing trigout


wire next_trigout;

assign next_trigout = (spi_counter[9:0] == 10'd980) ? |data_out : trigout;
	
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		trigout <= 0;
	end else begin
		trigout <= next_trigout;
	end
end

//----- Trigger Code-----
//trigger[0] is external trigger
//trigger[1] is PC trigger
//trigger[2] is continuous PC trigger
wire trig;
reg trig_latched;
reg old_trig_latched;
reg trig_flag;
reg next_trig_flag;
wire [2:0] trigger;

assign trigger = {cont_trig,pctrig,extrigin};
//selecting trigger(chparams[2] == 0 --> use PC trigger; chparams[2] == 1 --> use ext trigger)
assign trig = chparams[2] ? trigger[0] : trigger[1];


//latching the trigger onto the clock
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		trig_latched <= 0;
		old_trig_latched <= 0;
		trig_flag <= 0;
	end else begin
		trig_latched <= trig;
		old_trig_latched <= trig_latched;
		trig_flag <= next_trig_flag;
	end
end

//trig flag extends for a full SPI input cycle
always @ (*) begin
	if({old_trig_latched,trig_latched} == 2'b01)  
		next_trig_flag = 1'b1;
	else if(spi_counter == 10'b1111111111)
		next_trig_flag = 0;
	else
		next_trig_flag = trig_flag;
end

//------Defining Waveform Parameters-------------------------------

reg [7:0] period;
reg [7:0] pulse_width;
reg [9:0] amplitude;
reg [5:0] num_pulses;

always @ (*) begin
	case(chparams[1:0])
		2'b01: begin
					period = wave2params[7:0];
					pulse_width = wave2params[15:8];
					amplitude = wave2params[25:16];
					num_pulses = wave2params[31:26];	
				end
		2'b10: begin
					period = wave3params[7:0];
					pulse_width = wave3params[15:8];
					amplitude = wave3params[25:16];
					num_pulses = wave3params[31:26];	
				end
		2'b11: begin
					period = wave4params[7:0];
					pulse_width = wave4params[15:8];
					amplitude = wave4params[25:16];
					num_pulses = wave4params[31:26];	
				end
		default: begin
					period = wave1params[7:0];
					pulse_width = wave1params[15:8];
					amplitude = wave1params[25:16];
					num_pulses = wave1params[31:26];						
				end
	endcase
end
//------Channel Counters----------------------------------------------
reg [13:0] counter;
reg [13:0] next_counter;

reg [5:0] pulse_counter;
reg [5:0] next_pulse_counter;

reg trigged;
reg next_trigged;

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		trigged <= 0;
		counter <= 0;
		pulse_counter <= 0;
	end else begin
		trigged <= next_trigged;
		counter <= next_counter;
		pulse_counter <= next_pulse_counter;
	end
end

always @ (*) begin

	if(spi_counter == 10'b1111111111)
		if(trig_flag)
			if(period > 0 && num_pulses > 0) begin
				next_trigged = 1;
				next_counter = 0;
				next_pulse_counter = 0;
			end else begin
				next_trigged = 0;
				next_counter = 0;
				next_pulse_counter = 0;
			end
		else
			if(trigged || (trigger[2] && period > 0 && num_pulses > 0))
				if((counter+1) < {period,6'd0}) begin
					next_trigged = 1;
					next_counter = counter + 1;
					next_pulse_counter = pulse_counter;
				end else if((pulse_counter+1) < num_pulses) begin
					next_trigged = 1;
					next_counter = 0;
					next_pulse_counter = pulse_counter + 1;
				end else begin
					next_trigged = (trigger[2] && period > 0 && num_pulses > 0);
					next_counter = 0;
					next_pulse_counter = 0;
				end
			else
				begin
					next_trigged = 0;
					next_counter = 0;
					next_pulse_counter = 0;
				end
	else begin
		next_trigged = trigged;
		next_counter = counter;
		next_pulse_counter = pulse_counter;
	end
	//---------------------------------------------------
	

//Computing wave
	if(chparams[3])
		data_out = read_data_from_pipe; 
	else if(trigged)
		data_out = counter[13:5] < pulse_width ? amplitude : 10'd0;
	else
		data_out = 10'd0;	
end

endmodule
