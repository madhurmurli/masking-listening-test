classdef TestConfig
    %TESTCONFIG - Configuration of the Medical Alarms Listening Test
    %
    % Change the Constant properties below to alter the configuration of
    % the listening test.
    %
    % Evan Shenkman
    
    properties (Constant)
        MaskType = 'pink';                  % The type of masking signal
        MaskLevels = 50:5:85;               % The levels of the masking signals
        
        AlarmFolder = 'alarms';             % Where the medical alarm files can be found
        SubjectsFolder = 'subjects';        % Where the subjects results will be stored
        
        StepSizeDB = 3;                     % The step size for the 1 up, 1 down experiment
    end
    
    methods
    end
    
end

