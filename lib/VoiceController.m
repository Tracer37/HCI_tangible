classdef VoiceController
    %VOICECONTROLLER Class that triggers voice-controlled events to the game
    
    properties
        ipaddress='127.0.0.1';
        port=55001;
        debugMode = true; % decides if success=true;display debug information
    end
    
    methods
        function obj = VoiceController(debugMode,ipaddress,port)
            %VOICECONTROLLER Constructor of a class with optional
            %arguments: debugMode, ipaddress and port. By default these values are:
            %true, '127.0.0.1'(localhost) and 55001
            if nargin>0
                obj.debugMode = debugMode;
            end
            if nargin>1
                obj.ipaddress = ipaddress;
            end
            if nargin>2
                obj.port=port;
            end
        end
        
        function [success] = SetBottomObstacle(obj)
            %PLACEBOTTOMOBSTACLE Sends message to place bottom barrier
            
            if(obj.debugMode)
                success=true;disp("Switching to bottom obstacle")
            else
                success=sendmsg("BottomObstacle",obj.ipaddress,obj.port);
            end
        end

        function [success] = SetWallObstacle(obj)
            %PLACEWALLOBSTACLE Sends message to place wall barrier
            
            if(obj.debugMode)
                success=true;disp("Switching to wall obstacle")
            else
                success=sendmsg("WallObstacle",obj.ipaddress,obj.port);
            end
        end

        function [success] = SpecialObstacle(obj)
            %SPECIALOBSTACLE Sends message to place special obstacle
            
            if(obj.debugMode)
                success=true;disp("Placing special obstacle")
            else
                success=sendmsg("SpecialObstacle",obj.ipaddress,obj.port);
            end
        end
    end
end

