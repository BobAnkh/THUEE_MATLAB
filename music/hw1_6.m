close all;
clc;
load('Guitar.mat');
% �°汾��audioread������wavread
y = audioread('fmt.wav');
plot(y);
sound(y);
