close all;
clc;
load hall.mat;
hall_select = int16(hall_gray(1:8, 1:8));
hall_direct = hall_select - 128;
% ֱ�Ӽ�ȥ128
%imshow(hall_direct);
disp(hall_direct);
disp(dct2(hall_direct));

% �ڱ任�����
hall_trans = dct2(hall_select);
hall_trans(1, 1) = hall_trans(1, 1) - 128 * size(hall_select, 2);
disp(hall_trans);
disp(hall_trans - dct2(hall_direct));
% ���Կ�����ֵС��1e-12���ʿ�����Ϊ������һ����
