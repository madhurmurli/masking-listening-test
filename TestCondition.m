classdef TestCondition
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
    end
    
    methods (Static)
        function obj = TestCondition(mask, maskLevel, targetFile)
            obj.Mask = mask;
            obj.MaskLevel = maskLevel;
            
            obj.TargetFile = targetFile;
            [obj.Target, obj.TargetFileFs] = audioread(['alarms', filesep, targetFile]);
        end
    end
end

