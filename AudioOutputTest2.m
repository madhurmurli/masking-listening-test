fs=32000;
hwhite = dsp.ColoredNoise('Color','pink','SamplesPerFrame',64000);
rng default;
x = step(hwhite);
x=x./max(abs(x));
x=x./1.1;
%%
d = daq.getDevices;
 dev = d(4);
 %%
 s = daq.createSession('directsound');
noutchan = 2;
addAudioOutputChannel(s, dev.ID, 1:noutchan);
s.Rate = fs;
queueOutputData(s, repmat(x, 1, noutchan));
queueOutputData(s, repmat(x, 1, noutchan));
queueOutputData(s, repmat(x, 1, noutchan));

startForeground(s);
