fs=16000;
%hwhite = dsp.ColoredNoise('Color','pink','SamplesPerFrame',8000);
%rng default;
%x = step(hwhite);
%x=x./max(abs(x));
%x=x./1.1;
%%
d = daq.getDevices;
 dev = d(4);
 %%
 p=0;
 s = daq.createSession('directsound');
 s.IsContinuous=true;
noutchan = 2;
addAudioOutputChannel(s, dev.ID, 1:noutchan);
s.Rate = fs;
while(p<10)
    f=zeros(1600,1);
    queueOutputData(s, repmat(f, 1, noutchan));

p=p+1;
end
p=0;
 startBackground(s);

while(p<2)
    hwhite = dsp.ColoredNoise('Color','pink','SamplesPerFrame',fs);
    rng default;
    x = step(hwhite);
    x=x./max(abs(x));
    x=x./1.1;
    %x=x.*(p+1)/2;
    queueOutputData(s, repmat(x, 1, noutchan));

p=p+1;
end
