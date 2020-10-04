clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
image = double(hall_gray);
height = size(image, 1);
width = size(image , 2);
max_len = height * width;


% 随机生成一个需要隐藏的序列
seq_len = randi(max_len);
hide_info = randi([0, 1], 1, seq_len);
hide_seq = dec2bin([hide_info, zeros(1, max_len - seq_len)]);
% 隐藏信息
P = dec2bin(image.');
P(:, end) = hide_seq;
% 还原回图片
img = reshape(bin2dec(P), width, height).';
C = dec2bin(img.');
% 将隐藏信息抽取出来
extract_info = bin2dec(C(1:seq_len, end)).';
correct = length(find(extract_info==hide_info));
correct_rate = correct / seq_len;
fprintf("只隐藏信息的正确率: %f\n", correct_rate);

figure;
subplot(1, 3, 1);
imshow(hall_gray);
title("原图片");
subplot(1, 3, 2);
imshow(uint8(img));
title("隐藏信息后的图片");

% JPEG编码和解码
[DC, AC, height, width] = JpegEncode(img, QTAB, DCTAB, ACTAB);
img = JpegDecode(DC, AC, height, width, QTAB, ACTAB);
subplot(1, 3, 3);
imshow(uint8(img));
title("JPEG编码解码后的图片");
C = dec2bin(img.');
% 将隐藏信息抽取出来
extract_info = bin2dec(C(1:seq_len, end)).';
correct = length(find(extract_info==hide_info));
correct_rate = correct / seq_len;
fprintf("JPEG编码解码后的正确率: %f\n", correct_rate);
