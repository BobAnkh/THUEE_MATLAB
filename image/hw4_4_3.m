close all;
clc;

% 使用到的一些参数
test_img = imread('football.jpeg');
detect_window = [45, 30];
% 顺时针旋转90度
test_img_rotate = imrotate(test_img, -90);
detect_window_rotate = fliplr(detect_window);
% 高度不变，宽度拉伸2倍
test_img_resize = imresize(test_img, [size(test_img, 1), size(test_img, 2) * 2]);
detect_window_resize = [detect_window(1), detect_window(2) * 2];
% 适当改变颜色
test_img_adjust = imadjust(test_img, [0.15, 0.15, 0; 0.90, 0.90, 1]);
detect_window_adjust = detect_window;
% 令L为3，分别检测进行不同处理的图像，得到不同的人脸检测结果
test_image1 = face_detect(test_img_rotate, 3, detect_window_rotate, 0.30);
test_image2 = face_detect(test_img_resize, 3, detect_window_resize, 0.30);
test_image3 = face_detect(test_img_adjust, 3, detect_window_adjust, 0.30);

% 将结果呈现并写成图片
figure;
imshow(test_image1);
imwrite(test_image1, 'face_detect_rotate.jpg');
title("顺时针旋转90°的人脸检测结果");
figure;
imshow(test_image2);
imwrite(test_image2, 'face_detect_resize.jpg');
title("高度不变宽度拉伸的人脸检测结果");
figure;
imshow(test_image3);
imwrite(test_image3, 'face_detect_adjust.jpg');
title("适当改变颜色的人脸检测结果");
