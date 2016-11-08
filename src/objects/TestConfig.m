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
        TargetStartOffset = 9;              % How many dB ABOVE than the mask will the target start at
        
        AlarmFolder = 'alarms';             % Where the medical alarm files can be found
        SubjectsFolder = 'subjects';        % Where the subjects results will be stored
        
        NumUp = 2;
        NumDown = 1;
        StepSizeDB = 3;                     % The step size for the 1 up, 1 down experiment
        NumPivots = 6;
        
        MinCalibration = 5;
    end
    
    methods (Static)
        function val = CalibrationLevel(calDB)
            % CalibrationLevel - Set/Get the Calibration Level
            %
            %   cal = TestConfig.CalibrationLevel(calDB)
            %       If calDB is passed, the static calibration value will
            %       be updated and returned if an output variable is given.
            %
            %       Without the calDB argument, the static calibration
            %       value will just be returned.
            %
            % ~Evan Shenkman~
            
            persistent CalibrationDB;
            if nargin
                CalibrationDB = calDB;
            end
            val = CalibrationDB;
        end
    end
    
end

