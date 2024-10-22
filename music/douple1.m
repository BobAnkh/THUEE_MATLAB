%原始数值由于过大，导致matlab仿真困难，所以只能将全部参数值（除初相位、延迟时间、幅度外）除以1000进行仿真
clear;
close all;
clc;
%基本参数设定
%光速，原始为3e8
c=3e5;
%发射信号频率，原始为1e9
f_0=1e6;
%初相位
phi=0.28*pi;
%延迟时间
t_0=0.0001;
t_1=0.001;
%幅度
A=1;
B=0.001;
D=0.0001;
%实际多普勒频率目前为2KHz，对应原始2MHz
v_r=3e2;
lambda=c/f_0;
f_d=2*v_r/lambda;
%采样频率,对应原始4GHz
f_s=2.5e6;
N=f_s+1;
dt_z=1/f_s;
T_z=0:dt_z:1;
%发射信号与接收信号
send=A*cos(2*pi*f_0*T_z+phi);
receive=B*cos(2*pi*f_0*(T_z-t_0))+D*cos(2*pi*(f_0+f_d)*(T_z-t_1)+phi);
%将发射信号与接收信号相乘
signal=send.*receive;
%构建低通滤波器
Wp=2.5e3*2/f_s;
Ws=8e3*2/f_s;
Ap=1;
As=70;
[Nc,Wc]=cheb2ord(Wp,Ws,Ap,As);
[B,A]=cheby2(Nc,As,Wc,'low');
sig_filt=filter(B,A,signal);
%绘制切比雪夫滤波器
%freqz(B,A);
%去除直流分量
sig_filt=sig_filt-mean(sig_filt);
%加窗，使用汉宁窗或海明窗
window=hanning(N);
%window=hamming(N);
sig_win=sig_filt.*window';
%DFT
Magnitude=abs(fft(sig_win,N));
freqx=0:1:f_s;
stem(freqx,Magnitude);
%stem(freqx,sig_win);
