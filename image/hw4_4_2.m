close all;
clc;

% ʹ�õ���һЩ����
test_img = imread('football.jpeg');
detect_window = [45, 30];
% �ֱ���LΪ3,4,5���õ���ͬ�����������
test_image1 = face_detect(test_img, 3, detect_window, 0.30);
test_image2 = face_detect(test_img, 4, detect_window, 0.40);
test_image3 = face_detect(test_img, 5, detect_window, 0.60);

% ��������ֲ�д��ͼƬ
figure;
imshow(test_img);
title("ԭʼ����ͼ��");
figure;
imshow(test_image1);
imwrite(test_image1, 'face_detect_result_L3.jpg');
title("L=3�����������");
figure;
imshow(test_image2);
imwrite(test_image2, 'face_detect_result_L4.jpg');
title("L=4�����������");
figure;
imshow(test_image3);
imwrite(test_image3, 'face_detect_result_L5.jpg');
title("L=5�����������");
