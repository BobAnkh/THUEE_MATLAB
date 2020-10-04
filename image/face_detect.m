function test_image = face_detect(test_img,L, detect_window, epsilon)
%face_detect ����ʶ���ú����������ʶ�����ͼƬ
%   test_img:��Ҫ����������ͼ�����
% 	L:ѡȡ�����Ƹ�Lλ
%   detect_window:̽�ⴰ��С
%   epsilon:��ͬ�ľ����б���ֵ

% �õ�������׼
face_template = color_histogram(L);

% ʶ��ͼ��
% ��ȡ����ͼ��
test_image = test_img;
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
    % ��ֹʶ��򳬹�����ͼ��߽�
    if w > w_test - detect_window(2)
        w_select = w_test - detect_window(2) + 1;
    else
        w_select = w;
    end
    for h=1:h_step:h_test
        % ��ֹʶ��򳬹�����ͼ��߽�
        if h > h_test - detect_window(1)
            h_select = h_test - detect_window(1) + 1;
        else
            h_select = h;
        end
        % ���̽�ⴰ���е���ɫ����ʸ��������������ģ��֮��ľ���
        detect_color_vec = img2color_vec(test_image(h_select:(h_select + detect_window(1) - 1), w_select:(w_select + detect_window(2) - 1), :), L);
        d = distance(detect_color_vec, face_template);
        % ������ֵ�ж��Ƿ���Ҫ���뿼��
        if d < epsilon
            if boxes((h_select - h_dup):(h_select + h_dup),(w_select - w_dup):(w_select + w_dup)) == zeros(1 + 2 * h_dup, 1 + 2 * w_dup)
                boxes(h_select, w_select) = d;
            else
                % ʶ���ȥ��
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
end

% ������������������ģ�������̶ȣ������룩
function dis = distance(test, template)
    dis = 1 - sum(sqrt(test .* template));
end
