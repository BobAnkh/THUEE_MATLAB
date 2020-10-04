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
title("����ʵ�ֵ�DCT�任");
subplot(2, 1, 2);
imshow(hall_matlab_dct);
title("MATLAB�ṩ��DCT�任");
fprintf("����DCT�任����Ĳ����ֵ�����ֵ:%.13f\n",max(max(abs(hall_my_dct - hall_matlab_dct))));
