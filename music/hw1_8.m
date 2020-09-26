close all;
clc;
load('Guitar.mat');
fs = 8000;
OMG = 2*pi*4000;
REP = 20;
LEN = length(realwave);
wave = zeros(REP*LEN, 1);
for count=1:REP
    wave((LEN*(count-1)+1):LEN*count) = realwave;
end
N = length(wave);
[t,omg,FT,IFT] = prefourier([0,N/fs],N,[0,OMG],N);
fw = FT*wave;
%fw = fft(wave);
amp = abs(fw);
plot(omg/2/pi,amp);
