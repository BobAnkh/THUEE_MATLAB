clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
% JPEG编码
[DC, AC, height, width] = JpegEncode(hall_gray, QTAB, DCTAB, ACTAB);
fprintf("DC码流长度:%d, AC码流长度:%d, 高度:%d, 宽度:%d\n", size(DC, 2), size(AC, 2), height, width);
fprintf("压缩比为: %5.4f\n", height * width * 8 / (size(DC, 2) + size(AC, 2)));
% 保存变量
save jpegcodes.mat DC AC height width;
