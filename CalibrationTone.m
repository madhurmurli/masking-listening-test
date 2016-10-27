function out = CalibrationTone(f,samplingRate)
fs=samplingRate;
t=1/fs:1/fs:fs*10;
x=sin(2*pi*f*t);
soundsc(x,fs);
out=1.0;
end
