function out = PinkNoiseGenerator(testSignal,samplingRate,maskerLevel_DBFS,maskeeLevel_DBFS)
fs=samplingRate;
   %maskerLevel=dbtomag(maskerLevel_DBFS);
   %maskeeLevel=dbtomag(maskeeLevel_DBFS);
   maskerLevel=0.5;
   maskeeLevel=0.5;
 hpink = dsp.ColoredNoise('Color','pink','SamplesPerFrame',size(testSignal,1)+fs);
    rng default;
     pink_noise = step(hpink);
    pink_noise=pink_noise./max(abs(pink_noise));
    testSignal=[zeros(fs/2,1) testSignal zeros(fs/2,1)];
    outAudio=maskerLevel.*pink_noise+maskeeLevel.*testSignal;
    soundsc(outAudio,fs);
out=1.0;
end
