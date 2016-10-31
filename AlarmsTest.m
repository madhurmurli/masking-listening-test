addpath(['src' filesep]);
addpath(['src' filesep 'functions']);
addpath(['src' filesep 'objects']);

addpath(['GUIs' filesep]);
addpath(['alarms' filesep]);
addpath(['subjects' filesep]);

if isempty(TestConfig.CalibrationLevel) || isnan(TestConfig.CalibrationLevel)
    TestConfig.CalibrationLevel(100);
end

calibrationGUI