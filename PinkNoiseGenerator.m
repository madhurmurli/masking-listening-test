function out = PinkNoiseGenerator(testSignal,samplingRate,maskerLevel_DBSPL,maskeeLevel_DBSPL)
fs=samplingRate;
maskerLevel_DBFS=TestConfig.configurationLevel-maskerLevel_DBSPL;
maskeeLevel_DBFS=TestConfig.configurationLevel-maskeeLevel_DBSPL;

maskerLevel=dbtomag(maskerLevel_DBFS);
maskeeLevel=dbtomag(maskeeLevel_DBFS);

hpink = dsp.ColoredNoise('Color','pink','SamplesPerFrame',size(testSignal,1)+fs);
rng default;
pink_noise = step(hpink);
pink_noise=pink_noise./max(abs(pink_noise));
startIndex=fs/2+1;
endIndex=startIndex+size(testSignal,1)-1;
testSig=zeros(size(testSignal,1)+fs,1);
testSig(startIndex:endIndex)=testSignal;
%testSignal=[zeros(fs/2,1) testSignal zeros(fs/2,1)];
outAudio=maskerLevel.*pink_noise+maskeeLevel.*testSig;
soundsc(outAudio,fs);
out=1.0;
end
