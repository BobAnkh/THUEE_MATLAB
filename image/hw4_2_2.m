clear all;
close all;

load hall.mat;
hall_select = double(hall_gray(1:8, 1:8));
hall_select = hall_select - 128;
hall_my_dct = mydct2(hall_select);
hall_matlab_dct = dct2(hall_select);
figure;
subplot(2, 1, 1);
imshow(hall_my_dct);
title("自行实现的DCT变换");
subplot(2, 1, 2);
imshow(hall_matlab_dct);
title("MATLAB提供的DCT变换");
fprintf("两种DCT变换结果的差绝对值的最大值:%.13f\n",max(max(abs(hall_my_dct - hall_matlab_dct))));
