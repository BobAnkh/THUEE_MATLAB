clear;
close all;
clc;
%回波信号存在两个频率来源，一个是静物体回波，一个是动物体回波
%发射机信号，幅度A，频率f0=1GHz，相位phi
A = 1;
f0 = 1e6;
phi = 0.6*pi;
%接收机信号，幅度B,C，频率f0,f0+fd，相位phi
B = 0.8;
C = 0.6;
%动物体速度v <= 300km/s，发射电磁波波长
v = 3 * 1e3;
lamda = 3 * 1e8 / f0;
fd = 2 * v / lamda;
%接收信号延时t1,t2
t1 = 0;
t2 = 0;
%首先，对信号进行采样
fs = 3 * 1e6;%采样频率
dt = 1 / fs;%采样间隔
T = 0 : dt : 1;%定义每个采样时间点
%发射信号snd，接收信号rcv
snd = A * cos(2 * pi * f0 * T + phi);
rcv = B * cos(2 * pi * f0 * (T - t1) + phi) + C * cos(2 * pi * (f0 + fd) * (T - t2) + phi);
%将接受信号与发射信号送入乘法器
signmul = snd .* rcv;
%butterworth滤波器参数
wp = 2 * 2500 / fs;
ws = 2 * 30000 / fs;
Rp = 1;
As = 60;
%估计最高多普勒频率为2000Hz，因此低通滤波器的通带与阻带之间的过渡可以平缓一些，以降低滤波器阶数
[N,wc] = buttord(wp, ws, Rp, As);
%绘制滤波器幅频响应
%[o,m,n] = butter(N, wc);
%sos = zp2sos(o, m, n)
%freqz(sos, 10000, fs)
%构建滤波器
[B,A] = butter(N, wc, 'low');
[H,W] = freqz(B, A);
%信号通过滤波器
signfilter = filter(B, A, signmul);
signfilter = signfilter - mean(signfilter);
%加窗函数减少频率泄露
win = hann(length(T));
signhann = signfilter.*win';
%绘制频谱
plotsign = signhann;
l = length(plotsign);
p = fft(plotsign, l);
p1 = abs(p);
ff = [0:3000000] * fs / l;
stem(ff, p1);
%绘制时域图像
%stem(T, signfilter);