clear;
close all;
clc;
%�ز��źŴ�������Ƶ����Դ��һ���Ǿ�����ز���һ���Ƕ�����ز�
%������źţ�����A��Ƶ��f0=1GHz����λphi
A = 1;
f0 = 1e6;
phi = 0.6*pi;
%���ջ��źţ�����B,C��Ƶ��f0,f0+fd����λphi
B = 0.8;
C = 0.6;
%�������ٶ�v <= 300km/s�������Ų�����
v = 3 * 1e3;
lamda = 3 * 1e8 / f0;
fd = 2 * v / lamda;
%�����ź���ʱt1,t2
t1 = 0;
t2 = 0;
%���ȣ����źŽ��в���
fs = 3 * 1e6;%����Ƶ��
dt = 1 / fs;%�������
T = 0 : dt : 1;%����ÿ������ʱ���
%�����ź�snd�������ź�rcv
snd = A * cos(2 * pi * f0 * T + phi);
rcv = B * cos(2 * pi * f0 * (T - t1) + phi) + C * cos(2 * pi * (f0 + fd) * (T - t2) + phi);
%�������ź��뷢���ź�����˷���
signmul = snd .* rcv;
%butterworth�˲�������
wp = 2 * 2500 / fs;
ws = 2 * 30000 / fs;
Rp = 1;
As = 60;
%������߶�����Ƶ��Ϊ2000Hz����˵�ͨ�˲�����ͨ�������֮��Ĺ��ɿ���ƽ��һЩ���Խ����˲�������
[N,wc] = buttord(wp, ws, Rp, As);
%�����˲�����Ƶ��Ӧ
%[o,m,n] = butter(N, wc);
%sos = zp2sos(o, m, n)
%freqz(sos, 10000, fs)
%�����˲���
[B,A] = butter(N, wc, 'low');
[H,W] = freqz(B, A);
%�ź�ͨ���˲���
signfilter = filter(B, A, signmul);
signfilter = signfilter - mean(signfilter);
%�Ӵ���������Ƶ��й¶
win = hann(length(T));
signhann = signfilter.*win';
%����Ƶ��
plotsign = signhann;
l = length(plotsign);
p = fft(plotsign, l);
p1 = abs(p);
ff = [0:3000000] * fs / l;
stem(ff, p1);
%����ʱ��ͼ��
%stem(T, signfilter);