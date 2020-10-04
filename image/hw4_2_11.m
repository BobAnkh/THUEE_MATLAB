clear all;
close all;

load hall.mat;
load jpegcodes.mat;
load JpegCoeff.mat;
% JPEG����
image = JpegDecode(DC, AC, height, width, QTAB, ACTAB);
psnr = 10 * log10(255^2 / mse(image, hall_gray));
fprintf("PSNR = %6.4fdB\n", psnr);

figure;
subplot(1, 2, 1);
imshow(hall_gray);
title("ԭʼͼ��");
subplot(1, 2, 2);
imshow(image);
title("���뻹ԭͼ��");
imwrite(image, 'hall_jpeg_decode.jpeg');
