function out = PinkNoiseGenerator(testSignal, samplingRate, maskerLevel_DBSPL, maskeeLevel_DBSPL)
    fs=samplingRate;
    
    % Apply the Calibration measurement
    maskerLevel_DBFS=TestConfig.CalibrationLevel-maskerLevel_DBSPL;
    maskeeLevel_DBFS=TestConfig.CalibrationLevel-maskeeLevel_DBSPL;

    % Convert the dBFS value to a gain scalar
    maskerLevel=db2mag(-1*maskerLevel_DBFS);
    maskeeLevel=db2mag(-1*maskeeLevel_DBFS);
    
    % Convert incoming signal into RMS
    testSignal=testSignal./sqrt(2);
    
    % Create a Colored Noise generator
    hpink = dsp.ColoredNoise('Color', TestConfig.MaskType, 'SamplesPerFrame', size(testSignal,1)+fs);
    
    % Setup the Random Number Generator
    rng default;
    
    % Generate the pink noise sequence
    pink_noise = step(hpink);
    
    % Normalize
    pink_noise=pink_noise./max(abs(pink_noise));
    %Convert to rms
    pink_noise=pink_noise./sqrt(2);
    
    startIndex=fs/2+1;
    
    % Generate Audio Output
    testSig = zeros(size(testSignal,1)+fs,1);
    testSig(startIndex:startIndex+length(testSignal)-1) = testSignal(:,1);
    
    % Mix in Pink Noise
    outAudio = maskerLevel .* pink_noise + maskeeLevel .* testSig;
    
    % Play Audio
    sound(outAudio,fs);
    
    out=1.0;
end
