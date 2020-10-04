function image = iquantify(image_quantified, QTAB, height, width)
%iquantify 实现逆zigzag、反量化、IDCT和拼接功能
%   image_quantified:图像的量化矩阵
%   QTAB:量化系数
%   height: 原始图像高度
%   width: 原始图像宽度

h = ceil(height / 8);
w = ceil(width / 8);
img = zeros(8 * h, 8 * w);
for a = 1:h
    for b = 1:w
        img((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)) = idct2(myizigzag(image_quantified(:,w  * (a - 1) + b)) .* QTAB);
    end
end
image = img(1:height, 1:width);
