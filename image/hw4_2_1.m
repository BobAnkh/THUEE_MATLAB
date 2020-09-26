close all;
clc;
load hall.mat;
hall_select = int16(hall_gray(1:8, 1:8));
hall_direct = hall_select - 128;
% 直接减去128
%imshow(hall_direct);
disp(hall_direct);
disp(dct2(hall_direct));

% 在变换域进行
hall_trans = dct2(hall_select);
hall_trans(1, 1) = hall_trans(1, 1) - 128 * size(hall_select, 2);
disp(hall_trans);
disp(hall_trans - dct2(hall_direct));
% 可以看到差值小于1e-12，故可以认为基本是一样的
