classdef TestCondition < handle & matlab.mixin.SetGet
    %TESTCONDITION - Represents an instance of a test condition that the
    %target signal will be presented in.
    %
    %   A Test Condition consists of the following......
    %
    %       The Mask (pink noise, etc.)
    %       The level of the Mask (dB)
    %       The Target (a medical alarm)
    %
    %   During each iteration of the experiment, the only variable that
    %   will be changed is the Level of the Target. Once a threshold is
    %   determined, the TargetLevel will be set to that threshold and is
    %   condsidered the final result.
    %
    %
    
    % Evan Shenkman
    
    properties
        Mask;
        MaskLevel;
        
        TargetFile;
        TargetFileFs;
        
        Target;
        TargetLevel;
        
        Finished;
    end
    
    properties (SetAccess = protected)
        Direction;
        PivotCount;
        Responses;
        Threshold;
    end
    
    methods (Static)
        function obj = TestCondition(mask, maskLevel, targetFile)
            obj.Mask = mask;
            obj.MaskLevel = maskLevel;
            
            obj.TargetFile = targetFile;
            [obj.Target, obj.TargetFileFs] = audioread(['alarms', filesep, targetFile]);
            
            obj.TargetLevel = obj.MaskLevel - 18;
            
            obj.Direction = 'Up';
            obj.PivotCount = 0;
            obj.Finished = false;
            
            obj.Responses = cell(1,0);
        end
    end
    
    methods
        function storeResponse(obj, detected)
            obj.Responses{length(obj.Responses) + 1} = Response(obj.TargetLevel, detected);
        end
        
        function set.TargetLevel(obj, val)
            if strcmp(obj.Direction, 'Up') && val < obj.TargetLevel %#ok<*MCSUP>
                obj.Direction = 'Down';
                obj.PivotCount = obj.PivotCount + 1;
                    
            elseif strcmp(obj.Direction, 'Down') && val > obj.TargetLevel
                obj.Direction = 'Up';
                obj.PivotCount = obj.PivotCount + 1;
                
            end
            
            if obj.PivotCount >= TestConfig.NumPivots
                obj.Finished = true;
            end
            
            obj.TargetLevel = val;
        end
        
        function val = get.TargetLevel(obj)
            val = obj.TargetLevel;
        end
        
        function set.Finished(obj, val)
            if val == true
                % The number of pivots have been reached
                level = obj.MaskLevel - TestConfig.TargetStartOffset;
                while true
                    plusCount = 0;
                    minusCount = 0;
                    for i = 1:length(obj.Responses)
                        if obj.Responses{i}.Level == level
                            if obj.Responses{i}.Detected
                                plusCount = plusCount + 1;
                            else
                                minusCount = minusCount + 1;
                            end
                        end
                    end
                    
                    if plusCount >= minusCount
                        obj.Threshold = level;
                        break;
                    else
                        level = level + TestConfig.StepSizeDB;
                    end
                end
            end
            
            obj.Finished = val;
        end
    end
end

