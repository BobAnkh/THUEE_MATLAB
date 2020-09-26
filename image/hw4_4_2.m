close all;
clc;

% ʹ�õ���һЩ����
train_img_folder = 'Faces/';
test_img = 'football.jpeg';
L = 5;
face_template = zeros(2^(3 * L), 1);
detect_window = [45, 30];
switch L
    case 3
        epsilon = 0.25;
    case 4
        epsilon = 0.40;
    case 5
        epsilon = 0.60;
end
      
% ��ͼƬ��ȡ�������õ�������׼
img_list = dir(train_img_folder);
for img_name=3:length(img_list)
    image = imread([train_img_folder, img_list(img_name).name]);
    face_template = face_template + img2color_vec(image, L);
end
face_template = face_template / (length(img_list) - 2);

% ʶ��ͼ��
% ��ȡ����ͼ��
test_image = imread(test_img);
[h_test, w_test, ~] = size(test_image);
boxes = zeros(h_test, w_test);
% ����̽�ⴰ�������������ϻ����Ĳ���
h_step = floor(detect_window(1) / 5);
w_step = floor(detect_window(2) / 5);
% ʶ���ȥ�ط�Χ
h_dup = floor(0.8 * detect_window(1));
w_dup = floor(0.8 * detect_window(2));
% ̽�ⴰ�ڿ�ʼɨ�����ͼ��
for w=1:w_step:w_test
    if w > w_test - detect_window(2)
        w_select = w_test - detect_window(2) + 1;
    else
        w_select = w;
    end
    for h=1:h_step:h_test
        if h > h_test - detect_window(1)
            h_select = h_test - detect_window(1) + 1;
        else
            h_select = h;
        end
        % ���̽�ⴰ���е���ɫ����ʸ��������������ģ��֮��ľ���
        detect_color_vec = img2color_vec(test_image(h_select:(h_select + detect_window(1) - 1), w_select:(w_select + detect_window(2) - 1), :), L);
        d = distance(detect_color_vec, face_template);
        if d < epsilon
            if boxes((h_select - h_dup):(h_select + h_dup),(w_select - w_dup):(w_select + w_dup)) == zeros(1 + 2 * h_dup, 1 + 2 * w_dup)
                boxes(h_select, w_select) = d;
            else
                % ʶ���ȥ�� TODO
                [dup_row, dup_col, dup_d] = find(boxes((h_select - h_dup):(h_select + h_dup),(w_select - w_dup):(w_select + w_dup)));
                for num=1:length(dup_row)
                    if d < dup_d(num)
                        boxes(dup_row(num) - 1 + h_select - h_dup,dup_col(num) - 1 + w_select - w_dup) = 0;
                        boxes(h_select, w_select) = d;
                    else
                        boxes(h_select, w_select) = 0;
                        break
                    end
                end
            end
        end
    end
end

% �����
[row, col] = find(boxes);
red_horizontal = 255 * ones(1, detect_window(2));
red_horizontal(:, :, 2) = zeros(1, detect_window(2));
red_horizontal(:, :, 3) = zeros(1, detect_window(2));
red_vertical = 255 * ones(detect_window(1), 1);
red_vertical(:, :, 2) = zeros(detect_window(1), 1);
red_vertical(:, :, 3) = zeros(detect_window(1), 1);
for num=1:length(row)
    test_image(row(num), col(num):(col(num) + detect_window(2) - 1), :) = red_horizontal;
    test_image(row(num) + detect_window(1) - 1, col(num):(col(num) + detect_window(2) - 1), :) = red_horizontal;
    test_image(row(num):(row(num) + detect_window(1) - 1), col(num), :) = red_vertical;
    test_image(row(num):(row(num) + detect_window(1) - 1), col(num) + detect_window(2) - 1, :) = red_vertical;
end

% ��������ֲ�д��ͼƬ
imshow(test_image);
imwrite(test_image, 'face_detect_result.jpg');

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

% ������������������ģ�������̶ȣ������룩
function dis = distance(test, template)
    dis = 1 - sum(sqrt(test .* template));
end