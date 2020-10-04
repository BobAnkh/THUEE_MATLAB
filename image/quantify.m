function output = quantify(image, QTAB)
%quantify ʵ�ַֿ顢DCT��������zigzag����
%   image:�Ѿ�����Ԥ�����ͼ��
%   QTAB:����ϵ��
P = double(image);
[h, w] = size(P);
output = zeros(64, h * w / 64);
for a = 1:(h / 8)
    for b = 1:(w / 8)
        output(:,(w / 8) * (a - 1) + b) = myzigzag(round(dct2(P((8 * a - 7):(8 * a), (8 * b - 7):(8 * b))) ./ QTAB)).';
    end
end
