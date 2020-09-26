close all;
clc;

img_folder = 'Faces/';
L = 4;
face_template = zeros(2^(3 * L), 1);

% ��ͼƬ��ȡ�������õ�������׼
img_list = dir(img_folder);
for img_name=3:length(img_list)
    image = imread([img_folder, img_list(img_name).name]);
    face_template = face_template + img2color_vec(image, L);
end
face_template = face_template / (length(img_list) - 2);
plot(face_template);


% ��ͼ�����Lת�����ɫ���������ĺ�����L����ѡȡ�����Ƹ�Lλ
function color_vec = img2color_vec(img, L)
    color_vec = zeros(2^(3 * L), 1);
    % ��ȡǰLλ����Ϊ��������Ҫ������λ��������չλ��
    image = uint32(bitshift(img, -(8 - L)));
    color_list = bitshift(image(:, :, 1), 2 * L) + bitshift(image(:, :, 2), L) + image(:, :, 3);
    % չƽ��1ά���飬�����������
    color_list = color_list(:);
    for color=1:length(color_list)
        color_vec(color_list(color) + 1) = color_vec(color_list(color) + 1) + 1;
    end
    % ת���ɱ���
    color_vec = color_vec / length(color_list);
end