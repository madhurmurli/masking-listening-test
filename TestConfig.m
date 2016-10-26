classdef TestConfig
    %TESTCONFIG - Configuration of the Medical Alarms Listening Test
    %
    % Change the Constant properties below to alter the configuration of
    % the listening test.
    %
    % Evan Shenkman
    
    properties (Constant)
        MaskTypes = {'pink'};               % The type of masking signal
        MaskLevels = 50:5:85;               % The levels of the masking signals
        
        AlarmFolder = 'alarms';             % Where the medical alarm files can be found
    end
    
    methods
    end
    
end

