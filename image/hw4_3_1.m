clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
image = double(hall_gray);
height = size(image, 1);
width = size(image , 2);
max_len = height * width;


% �������һ����Ҫ���ص�����
seq_len = randi(max_len);
hide_info = randi([0, 1], 1, seq_len);
hide_seq = dec2bin([hide_info, zeros(1, max_len - seq_len)]);
% ������Ϣ
P = dec2bin(image.');
P(:, end) = hide_seq;
% ��ԭ��ͼƬ
img = reshape(bin2dec(P), width, height).';
C = dec2bin(img.');
% ��������Ϣ��ȡ����
extract_info = bin2dec(C(1:seq_len, end)).';
correct = length(find(extract_info==hide_info));
correct_rate = correct / seq_len;
fprintf("ֻ������Ϣ����ȷ��: %f\n", correct_rate);

figure;
subplot(1, 3, 1);
imshow(hall_gray);
title("ԭͼƬ");
subplot(1, 3, 2);
imshow(uint8(img));
title("������Ϣ���ͼƬ");

% JPEG����ͽ���
[DC, AC, height, width] = JpegEncode(img, QTAB, DCTAB, ACTAB);
img = JpegDecode(DC, AC, height, width, QTAB, ACTAB);
subplot(1, 3, 3);
imshow(uint8(img));
title("JPEG���������ͼƬ");
C = dec2bin(img.');
% ��������Ϣ��ȡ����
extract_info = bin2dec(C(1:seq_len, end)).';
correct = length(find(extract_info==hide_info));
correct_rate = correct / seq_len;
fprintf("JPEG�����������ȷ��: %f\n", correct_rate);
