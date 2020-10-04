close all;
clc;
load hall.mat;
hall_select = double(hall_gray(1:8, 1:8));
hall_direct = hall_select - 128;
% ֱ�Ӽ�ȥ128
hall_direct_dct = dct2(hall_direct);
figure;
subplot(2, 1, 1);
imshow(hall_direct_dct);
title("ֱ�Ӽ�ȥ128");
disp(hall_direct_dct);

% �ڱ任�����
hall_trans = dct2(hall_select);
hall_trans(1, 1) = hall_trans(1, 1) - 128 * size(hall_select, 2);
subplot(2, 1, 2);
imshow(hall_trans);
title("�ڱ任�����");
disp(hall_trans);
disp(hall_trans - hall_direct_dct);
fprintf("��ֵ���ֵ:%.13f\n", max(max(abs(hall_trans - hall_direct_dct))));
