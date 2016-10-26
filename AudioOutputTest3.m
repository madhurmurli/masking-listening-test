fs=16000;
hwhite = dsp.ColoredNoise('Color','pink','SamplesPerFrame',8000);
rng default;
x = step(hwhite);
x=x./max(abs(x));
x=x./1.1;
p=0;
%%
d = daq.getDevices;
 dev = d(4);
 %%
 s = daq.createSession('directsound');
 s.IsContinuous=true;
noutchan = 2;
addAudioOutputChannel(s, dev.ID, 1:noutchan);
s.Rate = fs;
while(p<10)
    queueOutputData(s, x, 1, noutchan);
 
p=p+1;
end
startBackground(s);
