classdef ArmKinectController
    %ARMCONTROLLER Class that sends signals to place obstacle when methods are invoked
    
    properties
        kinect = true; % else its arm
        ipaddress='127.0.0.1';
        port=55001;
        debugMode = true; % decides if success=true;display debug information
    end
    
    methods
        function obj = ArmKinectController(kinect,debugMode,ipaddress,port)
            %ARMKINECTCONTROLLER Constructor of a class with optional
            %kinect: if true it controls signals send from kinect else
            %controls signals send from arm
            %arguments: debugMode, ipaddress and port. By default these values are:
            %true, '127.0.0.1'(localhost) and 55001
            obj.kinect=kinect;
            if nargin>1
                obj.debugMode = debugMode;
            end
            if nargin>2
                obj.ipaddress = ipaddress;
            end
            if nargin>3
                obj.port=port;
            end
        end

        function [controllerName] = GetControllerName(obj)
            if obj.kinect
                controllerName = "Kinect";
            else
                controllerName = "Arm";
            end
        end
        
        function [success] = PlaceObstacleDown(obj)
            
            if(obj.debugMode)
                success=true;disp(obj.GetControllerName()+" placing obstacle on bottom track")
            else
                success=sendmsg("ObstacleDown:"+obj.GetControllerName(),obj.ipaddress,obj.port);
            end
        end

        function [success] = PlaceObstacleUp(obj)
            
            if(obj.debugMode)
                success=true;disp(obj.GetControllerName()+" placing obstacle on upper track")
            else
                success=sendmsg("ObstacleUp:"+obj.GetControllerName(),obj.ipaddress,obj.port);
            end
        end

        function [success] = PlaceObstacleRight(obj)
            
            if(obj.debugMode)
                success=true;disp(obj.GetControllerName()+" placing obstacle on right track")
            else
                success=sendmsg("ObstacleRight:"+obj.GetControllerName(),obj.ipaddress,obj.port);
            end
        end

        function [success] = PlaceObstacleLeft(obj)
            
            if(obj.debugMode)
                success=true;disp(obj.GetControllerName()+" placing obstacle on left track")
            else
                success=sendmsg("ObstacleLeft:"+obj.GetControllerName(),obj.ipaddress,obj.port);
            end
        end
    end
end

