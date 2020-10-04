clear all;
close all;

load snow.mat;
load JpegCoeff.mat;
% JPEG编码
[DC, AC, height, width] = JpegEncode(snow, QTAB, DCTAB, ACTAB);
fprintf("DC码流长度:%d, AC码流长度:%d, 高度:%d, 宽度:%d\n", size(DC, 2), size(AC, 2), height, width);
fprintf("压缩比为: %5.4f\n", height * width * 8 / (size(DC, 2) + size(AC, 2)));

% JPEG解码
image = JpegDecode(DC, AC, height, width, QTAB, ACTAB);
psnr = 10 * log10(255^2 / mse(image, snow));
fprintf("PSNR = %6.4fdB\n", psnr);

figure;
subplot(1, 2, 1);
imshow(snow);
title("原始图像");
subplot(1, 2, 2);
imshow(image);
title("解码还原图像");
