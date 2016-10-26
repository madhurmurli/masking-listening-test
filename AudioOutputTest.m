load handel;
ly = length(y);
lspan = 1:ly;
t = lspan/Fs;

hf = figure();
plot(t, y./max(y))
axis tight;
title('Signal (Handel''s Hallelujah Chorus) vs Time');
xlabel('Time (s)');
ylabel('Amplitude');

markers = struct('xpos', [0.2, 0.4, 0.55, 0.65, 0.8], 'string', num2str([1:5]'));
for i = 1:5
    annotation(hf, 'textbox', [markers.xpos(i) 0.48 0.048 0.080], 'String', markers.string(i), 'BackgroundColor', 'w', 'FontSize', 16);
end
d = daq.getDevices;
 dev = d(4);
 %%
 s = daq.createSession('directsound');
noutchan = 2;
addAudioOutputChannel(s, dev.ID, 1:noutchan);
s.Rate = Fs;
queueOutputData(s, repmat(y, 1, noutchan));
x=1
queueOutputData(s, repmat(y, 1, noutchan));
x=2
queueOutputData(s, repmat(y, 1, noutchan));

startForeground(s);
close(hf);
