close all;
clc;
load('Guitar.mat');
% 新版本用audioread而不是wavread
y = audioread('fmt.wav');
plot(y);
sound(y);
