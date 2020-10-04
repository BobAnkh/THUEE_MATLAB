clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
% JPEG����
[DC, AC, height, width] = JpegEncode(hall_gray, QTAB/2, DCTAB, ACTAB);
fprintf("DC��������:%d, AC��������:%d, �߶�:%d, ���:%d\n", size(DC, 2), size(AC, 2), height, width);
fprintf("ѹ����Ϊ: %5.4f\n", height * width * 8 / (size(DC, 2) + size(AC, 2)));

% JPEG����
image = JpegDecode(DC, AC, height, width, QTAB/2, ACTAB);
psnr = 10 * log10(255^2 / mse(image, hall_gray));
fprintf("PSNR = %6.4fdB\n", psnr);

figure;
subplot(1, 2, 1);
imshow(hall_gray);
title("ԭʼͼ��");
subplot(1, 2, 2);
imshow(image);
title("���뻹ԭͼ��");
