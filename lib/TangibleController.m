classdef TangibleController
    %TANGIBLECONTROLLER Class that enables to send signal when an object was detected
    
    properties
        ipaddress='127.0.0.1';
        port=55001;
        debugMode = true; % decides if success=true // dont send, only print
        verbose = true; % display debug information
        tcpSocket
    end
    
    methods
        function obj = TangibleController(debugMode, ipaddress, port, verbose)
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
            if nargin>3
                obj.verbose=verbose;
            end
            
            if not(obj.debugMode)
                % Prepare TCP socket
                obj.tcpSocket = tcpclient(obj.ipaddress, obj.port);
                set(obj.tcpSocket, 'Timeout', 30);
            end

        end
        
        function [success] = ObjectDetected(obj, objName)
            %OBJECTDETECTED Sends message to indicate that object with
            %objName has been detected
            
            if obj.debugMode || obj.verbose
                c = clock; hh = c(4); mm = c(5); ss = c(6);
                fprintf("%02d:%02d:%0.2f Detected object - [%s]\n", hh, mm, ss, objName)
            end

            if obj.debugMode
                success = true;
            else
                message = "ObjectDetected:" + objName;
                try
                    success = true;
                    write(obj.tcpSocket, message);
                catch ex
                    disp("Unable to send data - reason: " + ex.identifier)
                    success = false;
                end
            end
        end
    end
end

