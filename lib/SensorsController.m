classdef SensorsController
    %VOICECONTROLLER Class that sends signals to move characer
    
    properties
        ipaddress='127.0.0.1';
        port=55001;
        debugMode = true; % decides if success=true;display debug information
    end
    
    methods
        function obj = SensorsController(debugMode,ipaddress,port)
            %SENSORSCONTROLLER Constructor of a class with optional
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

        function [success] = MoveToRight(obj)
            
            if(obj.debugMode)
                success=true;disp("Moving on to the right track")
            else
                success=sendmsg("TurnRight",obj.ipaddress,obj.port);
            end
        end
        
        function [success] = MoveToLeft(obj)
            
            if(obj.debugMode)
                success=true;disp("Moving on to the left track")
            else
                success=sendmsg("TurnLeft",obj.ipaddress,obj.port);
            end
        end

        function [success] = Jump(obj)
            
            if(obj.debugMode)
                success=true;disp("Jumping")
            else
                success=sendmsg("Jump",obj.ipaddress,obj.port);
            end
        end
    end
end

