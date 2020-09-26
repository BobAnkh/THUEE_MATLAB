close all;
clc;

img_folder = 'Faces/';
L = 4;
face_template = zeros(2^(3 * L), 1);

% 将图片读取进来并得到人脸标准
img_list = dir(img_folder);
for img_name=3:length(img_list)
    image = imread([img_folder, img_list(img_name).name]);
    face_template = face_template + img2color_vec(image, L);
end
face_template = face_template / (length(img_list) - 2);
plot(face_template);


% 将图像根据L转变成颜色比例向量的函数，L就是选取二进制高L位
function color_vec = img2color_vec(img, L)
    color_vec = zeros(2^(3 * L), 1);
    % 抽取前L位，因为后续还需要向左移位，所以延展位数
    image = uint32(bitshift(img, -(8 - L)));
    color_list = bitshift(image(:, :, 1), 2 * L) + bitshift(image(:, :, 2), L) + image(:, :, 3);
    % 展平成1维数组，方便后续计算
    color_list = color_list(:);
    for color=1:length(color_list)
        color_vec(color_list(color) + 1) = color_vec(color_list(color) + 1) + 1;
    end
    % 转换成比例
    color_vec = color_vec / length(color_list);
end