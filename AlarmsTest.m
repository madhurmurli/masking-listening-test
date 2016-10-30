addpath('alarms/');
addpath('subjects/');

if isempty(TestConfig.CalibrationLevel) || isnan(TestConfig.CalibrationLevel)
    TestConfig.CalibrationLevel(100);
end

calibrationGUI