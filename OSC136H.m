classdef OSC136H < handle
    
    properties
        
        % OKFP Dev object for using the Opal Kelly FP Library
        dev
        
    end

    methods
        % OSC136H Constructor
        % Initializes the channel and waveform information to all zeroes.
        % Also loads the OK library, and constructs a dev object that will
        % be used for all library interactions with FrontPanel.
        function obj = OSC136H()
            if ~libisloaded('okFrontPanel')
                loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
            end
            % Initialize a new OSC136H object
            obj.dev = calllib('okFrontPanel', 'okFrontPanel_Construct');
            fprintf('Successfully loaded okFrontPanel.\n');
        end
        
        % OSC136H Destructor
        % Disconnects from the board to prevent connection issues when
        % using multiple instances of the classes. 
        function delete(this)
             this.Disconnect();
        end
        
        % isOpen
        % Checks if we are currently connected to a board.
        function open = isOpen(this)
            open = calllib('okFrontPanel', 'okFrontPanel_IsOpen', this.dev);
        end
               
        % OutputWireInVal
        % Reads the value at a given WireIn endpoint using FP and outputs
        % the 16-bit wire. Useful for checking whether updates worked
        % correctly.
        function OutputWireInVal(this, endpoint)
        	if endpoint > 32
        		fprintf('Out of scope of WireIn\n');
        		return;
        	end
            WIREIN_SIZE = 16;
            buf = libpointer('uint32Ptr', 10);
            calllib('okFrontPanel', 'okFrontPanel_GetWireInValue', this.dev, endpoint, buf);
            fprintf('WireIn %d: ', endpoint);
            fprintf(dec2bin(get(buf, 'Value'), WIREIN_SIZE));
            fprintf('\n');
        end

        function OutputWireOutVal(this, endpoint)
        	if endpoint <= 32
        		fprintf('Out of scope of WireOut\n');
        		return;
        	end
            WIREIN_SIZE = 16;
            buf = libpointer('uint32Ptr', 10);
            calllib('okFrontPanel', 'okFrontPanel_UpdateWireOuts', this.dev);
            buf = calllib('okFrontPanel', 'okFrontPanel_GetWireOutValue', this.dev, endpoint);
            fprintf('WireOut endpoint decimal %d: ', endpoint);
            fprintf(dec2bin(buf, WIREIN_SIZE));
            fprintf('\n');
        end
        
        % WriteToWireIn
        % Takes an OK FP WireIn endpoint, a beginning bit, a write length,
        % and a value. Writes the first write_length bits of value into the
        % WireIn specified by endpoint, starting at the location begin.
        function WriteToWireIn(this, endpoint, begin, write_length, value)
            % Mask constructed to isolate desired bits.
            mask = (2 ^ write_length) - 1;
            shifter = begin;
            mask = bitshift(mask, shifter);
            val =  bitshift(bitor(0, value), shifter);
            calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', this.dev, endpoint, val, mask);
            calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', this.dev);
            fprintf('WriteToWireIn %d: %d\n', endpoint, value);
        end
                
        % Disconnect
        % Attempts to disconnect a connected OK FPGA.
        function ec = Disconnect(this)
           if ~this.isOpen()
              fprintf('No open board to disconnect!\n');
              ec = 0;
              return
           end
           this.SysReset();
           calllib('okFrontPanel', 'okFrontPanel_Close', this.dev);
           if this.isOpen()
               fprintf('Failed to close board\n')
               ec = -1;
               return
           end
           fprintf('Successfully closed board\n')
           ec = 0;
        end
        
        % Configure
        % Takes a filename as a path to the bitfile, and loads it onto the
        % FPGA. The desired bitfile is titled 'config.bit'.
        function Configure(this, filename)
           ec = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', this.dev, filename);
           if ec ~= "ok_NoError"
               fprintf('Error loading bitfile\n')
               return
           end
           fprintf("Succesfully loaded bitfile\n");
           
           pll = calllib('okFrontPanel', 'okPLL22150_Construct');
           calllib('okFrontPanel', 'okPLL22150_SetReference', pll, 48.0, 0);
           calllib('okFrontPanel', 'okPLL22150_SetVCOParameters', pll, 512, 125);
           
           calllib('okFrontPanel', 'okPLL22150_SetDiv1', pll, 'ok_DivSrc_VCO', 15);
           calllib('okFrontPanel', 'okPLL22150_SetDiv2', pll, 'ok_DivSrc_VCO', 8);
           
           calllib('okFrontPanel', 'okPLL22150_SetOutputSource', pll, 0, 'ok_ClkSrc22150_Div1ByN');
           calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', pll, 0, 1);
           
           calllib('okFrontPanel', 'okPLL22150_SetOutputSource', pll, 1, 'ok_ClkSrc22150_Div2ByN');
           calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', pll, 1, 1);
           
           calllib('okFrontPanel', 'okFrontPanel_SetPLL22150Configuration', this.dev, pll);
        end
        
        % Gets list of serial numbers for all connected boards
        function serials = GetBoardSerials(this)
            serials = 'No connected devices';
            device_count = calllib('okFrontPanel', 'okFrontPanel_GetDeviceCount', this.dev);
            for d = 0:(device_count - 1)
                sn = calllib('okFrontPanel', 'okFrontPanel_GetDeviceListSerial', this.dev, d, blanks(30));
                if ~exist('snlist', 'var')
                    snlist = sn;
                else
                    snlist = char(snlist, sn);
                end
            end
            if exist('snlist', 'var')
                serials = snlist;
            end
        end


        % Connect
        % Connects the board to the first openly available FPGA.
        function ec = ConnectToFirst(this)
            % For now, all this function does is connect to the first
            % available board.
            serial = this.GetBoardSerials();
            this.dev = calllib('okFrontPanel', 'okFrontPanel_Construct');
            calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', this.dev, serial);
            open = calllib('okFrontPanel', 'okFrontPanel_IsOpen', this.dev);
            if ~open
                fprintf('Failed to open board\n')
                ec = -1;
                return
            end
            this.Configure('OSC1_LITE_Control.bit');
            this.SysReset();
            fprintf('Successfully opened board\n')
            ec = 0;
        end
        

        % Reset the electronics, as well as setting all parameters to 0.
        function ec = SysReset(this)
            ec = 0;
            open = calllib('okFrontPanel', 'okFrontPanel_IsOpen', this.dev);
            if ~open
                fprintf('Failed to open board\n')
                ec = -1;
                return
            end
            
            fprintf('Reseting system to default state\n')

            this.WriteToWireIn(hex2dec('00'), 0, 16, 1);
            this.WriteToWireIn(hex2dec('01'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('02'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('03'), 0, 16, 0);

            this.WriteToWireIn(hex2dec('00'), 0, 16, 0);
        end      

        function ec = EnableWrite(this, value)
            ec = 0;
            open = calllib('okFrontPanel', 'okFrontPanel_IsOpen', this.dev);
            if ~open
                fprintf('Failed to Enable Write\n')
                ec = -1;
                return
            end
            fprintf('Writing %d to the register\n', value)
            this.WriteToWireIn(hex2dec('00'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('03'), 0, 16, value);
            this.WriteToWireIn(hex2dec('02'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('01'), 0, 16, 1);
        end

        function ec = EnableRead(this)
            ec = 0;
            open = calllib('okFrontPanel', 'okFrontPanel_IsOpen', this.dev);
            if ~open
                fprintf('Failed to Enable Read\n')
                ec = -1;
                return
            end
            fprintf('Reading from the register\n')
            this.WriteToWireIn(hex2dec('00'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('02'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('01'), 0, 16, 2);
        end

        function ec = EnableClear(this)
            ec = 0;
            open = calllib('okFrontPanel', 'okFrontPanel_IsOpen', this.dev);
            if ~open
                fprintf('Failed to Enable Clear\n')
                ec = -1;
                return
            end
            fprintf('Clearing the register\n')
            this.WriteToWireIn(hex2dec('00'), 0, 16, 0);
            this.WriteToWireIn(hex2dec('02'), 0, 16, 1);
            this.WriteToWireIn(hex2dec('02'), 0, 16, 0);
        end    
    end
end

