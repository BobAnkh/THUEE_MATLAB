close all;
clear all;
clc;

% �ֱ���LΪ3,4,5���õ���ͬ������ģ����
face_template1 = color_histogram(3);
face_template2 = color_histogram(4);
face_template3 = color_histogram(5);

% ���Ƴ���ͬL����µ�����ģ��
figure;
subplot(3, 1, 1);
plot(face_template1);
title("L = 3");
subplot(3, 1, 2);
plot(face_template2);
title("L = 4");
subplot(3, 1, 3);
plot(face_template3);
title("L = 5");
