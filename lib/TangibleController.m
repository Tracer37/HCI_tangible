classdef TangibleController
    %TANGIBLECONTROLLER Class that enables to send signal when an object was
    %detected
    
    properties
        ipaddress='127.0.0.1';
        port=55001;
        debugMode = true; % decides if success=true;display debug information
    end
    
    methods
        function obj = TangibleController(debugMode,ipaddress,port)
            %TANGIBLECONTROLLER Constructor of a class with optional
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
        
        function [success] = ObjectDetected(obj,objName)
            %OBJECTDETECTED Sends message to indicate that object with
            %objName has been detected
            
            if(obj.debugMode)
                success=true;disp("Detected object with name "+objName)
            else
                success=sendmsg("ObjectDetected:"+objName,obj.ipaddress,obj.port);
            end
        end
    end
end

