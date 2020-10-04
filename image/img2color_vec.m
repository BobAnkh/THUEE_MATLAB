function color_vec = img2color_vec(img, L)
%将图像根据L转变成颜色比例向量的函数，L就是选取二进制高L位
%   img:图像
%   L:选取二进制高L位
    color_vec = zeros(2^(3 * L), 1);
    % 抽取前L位，因为后续还需要向左移位，所以延展位数
    image = double(bitshift(img, -(8 - L)));
    color_list = bitshift(image(:, :, 1), 2 * L) + bitshift(image(:, :, 2), L) + image(:, :, 3);
    % 展平成1维数组，方便后续计算
    color_list = color_list(:);
    for color=1:length(color_list)
        color_vec(color_list(color) + 1) = color_vec(color_list(color) + 1) + 1;
    end
    % 转换成比例
    color_vec = color_vec / length(color_list);
end
