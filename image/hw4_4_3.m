close all;
clc;

% ʹ�õ���һЩ����
test_img = imread('football.jpeg');
detect_window = [45, 30];
% ˳ʱ����ת90��
test_img_rotate = imrotate(test_img, -90);
detect_window_rotate = fliplr(detect_window);
% �߶Ȳ��䣬�������2��
test_img_resize = imresize(test_img, [size(test_img, 1), size(test_img, 2) * 2]);
detect_window_resize = [detect_window(1), detect_window(2) * 2];
% �ʵ��ı���ɫ
test_img_adjust = imadjust(test_img, [0.15, 0.15, 0; 0.90, 0.90, 1]);
detect_window_adjust = detect_window;
% ��LΪ3���ֱ�����в�ͬ�����ͼ�񣬵õ���ͬ�����������
test_image1 = face_detect(test_img_rotate, 3, detect_window_rotate, 0.30);
test_image2 = face_detect(test_img_resize, 3, detect_window_resize, 0.30);
test_image3 = face_detect(test_img_adjust, 3, detect_window_adjust, 0.30);

% ��������ֲ�д��ͼƬ
figure;
imshow(test_image1);
imwrite(test_image1, 'face_detect_rotate.jpg');
title("˳ʱ����ת90������������");
figure;
imshow(test_image2);
imwrite(test_image2, 'face_detect_resize.jpg');
title("�߶Ȳ�������������������");
figure;
imshow(test_image3);
imwrite(test_image3, 'face_detect_adjust.jpg');
title("�ʵ��ı���ɫ�����������");
