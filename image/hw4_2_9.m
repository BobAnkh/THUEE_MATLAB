clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
% JPEG����
[DC, AC, height, width] = JpegEncode(hall_gray, QTAB, DCTAB, ACTAB);
fprintf("DC��������:%d, AC��������:%d, �߶�:%d, ���:%d\n", size(DC, 2), size(AC, 2), height, width);
fprintf("ѹ����Ϊ: %5.4f\n", height * width * 8 / (size(DC, 2) + size(AC, 2)));
% �������
save jpegcodes.mat DC AC height width;
