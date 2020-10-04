close all;
clc;

% 使用到的一些参数
test_img = imread('football.jpeg');
detect_window = [45, 30];
% 分别令L为3,4,5，得到不同的人脸检测结果
test_image1 = face_detect(test_img, 3, detect_window, 0.30);
test_image2 = face_detect(test_img, 4, detect_window, 0.40);
test_image3 = face_detect(test_img, 5, detect_window, 0.60);

% 将结果呈现并写成图片
figure;
imshow(test_img);
title("原始待测图像");
figure;
imshow(test_image1);
imwrite(test_image1, 'face_detect_result_L3.jpg');
title("L=3的人脸检测结果");
figure;
imshow(test_image2);
imwrite(test_image2, 'face_detect_result_L4.jpg');
title("L=4的人脸检测结果");
figure;
imshow(test_image3);
imwrite(test_image3, 'face_detect_result_L5.jpg');
title("L=5的人脸检测结果");
