function color_vec = img2color_vec(img, L)
%��ͼ�����Lת�����ɫ���������ĺ�����L����ѡȡ�����Ƹ�Lλ
%   img:ͼ��
%   L:ѡȡ�����Ƹ�Lλ
    color_vec = zeros(2^(3 * L), 1);
    % ��ȡǰLλ����Ϊ��������Ҫ������λ��������չλ��
    image = double(bitshift(img, -(8 - L)));
    color_list = bitshift(image(:, :, 1), 2 * L) + bitshift(image(:, :, 2), L) + image(:, :, 3);
    % չƽ��1ά���飬�����������
    color_list = color_list(:);
    for color=1:length(color_list)
        color_vec(color_list(color) + 1) = color_vec(color_list(color) + 1) + 1;
    end
    % ת���ɱ���
    color_vec = color_vec / length(color_list);
end
