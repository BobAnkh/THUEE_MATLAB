function test_image = face_detect(test_img,L, detect_window, epsilon)
%face_detect 人脸识别用函数，输出加识别框后的图片
%   test_img:需要被人脸检测的图像矩阵
% 	L:选取二进制高L位
%   detect_window:探测窗大小
%   epsilon:不同的距离判别阈值

% 得到人脸标准
face_template = color_histogram(L);

% 识别图像
% 读取待测图像
test_image = test_img;
[h_test, w_test, ~] = size(test_image);
boxes = zeros(h_test, w_test);
% 计算探测窗口在两个方向上滑动的步长
h_step = floor(detect_window(1) / 5);
w_step = floor(detect_window(2) / 5);
% 识别框去重范围
h_dup = floor(0.8 * detect_window(1));
w_dup = floor(0.8 * detect_window(2));
% 探测窗口开始扫描待测图像
for w=1:w_step:w_test
    % 防止识别框超过待测图像边界
    if w > w_test - detect_window(2)
        w_select = w_test - detect_window(2) + 1;
    else
        w_select = w;
    end
    for h=1:h_step:h_test
        % 防止识别框超过待测图像边界
        if h > h_test - detect_window(1)
            h_select = h_test - detect_window(1) + 1;
        else
            h_select = h;
        end
        % 获得探测窗口中的颜色比例矢量并计算与人脸模板之间的距离
        detect_color_vec = img2color_vec(test_image(h_select:(h_select + detect_window(1) - 1), w_select:(w_select + detect_window(2) - 1), :), L);
        d = distance(detect_color_vec, face_template);
        % 根据阈值判断是否需要纳入考虑
        if d < epsilon
            if boxes((h_select - h_dup):(h_select + h_dup),(w_select - w_dup):(w_select + w_dup)) == zeros(1 + 2 * h_dup, 1 + 2 * w_dup)
                boxes(h_select, w_select) = d;
            else
                % 识别框去重
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

% 画红框
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

% 计算区域特征与人脸模板的相近程度（即距离）
function dis = distance(test, template)
    dis = 1 - sum(sqrt(test .* template));
end
