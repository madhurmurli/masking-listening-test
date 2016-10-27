function testConditions = generateTestConditions()
    %generateTestConditions - generates all combinations of test conditions
    %outlined in the TestConfig file
    %
    % See also TestConfig.m
    
    d = dir([TestConfig.AlarmFolder filesep '*.wav']);

    numConditions = length(TestConfig.MaskLevels) * length(d);

    testConditions = cell(1, numConditions);
    index = 1;

    for j = 1:length(TestConfig.MaskLevels)
        for k = 1:length(d)

            testConditions{index} = TestCondition(TestConfig.MaskType, TestConfig.MaskLevels(j), d(k).name);
            index = index + 1;

        end
    end
end