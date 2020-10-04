close all;
clc;
load hall.mat;
hall_select = double(hall_gray(1:8, 1:8));
hall_direct = hall_select - 128;
% 直接减去128
hall_direct_dct = dct2(hall_direct);
figure;
subplot(2, 1, 1);
imshow(hall_direct_dct);
title("直接减去128");
disp(hall_direct_dct);

% 在变换域进行
hall_trans = dct2(hall_select);
hall_trans(1, 1) = hall_trans(1, 1) - 128 * size(hall_select, 2);
subplot(2, 1, 2);
imshow(hall_trans);
title("在变换域操作");
disp(hall_trans);
disp(hall_trans - hall_direct_dct);
fprintf("差值最大值:%.13f\n", max(max(abs(hall_trans - hall_direct_dct))));
