close all;
clc;
load hall.mat;
hall_process = preprocess(hall_gray);
%hall_select = hall_process(17:32, 41:56);
hall_select = hall_process;
hall_result = hall_select;
[h, w] = size(hall_select);

figure;
subplot(2, 2, 1);
imshow(uint8(hall_result + 128));
title("δ���κδ����ԭͼ��");

for a = 1:(h / 8)
    for b = 1:(w / 8)
        C = mydct2(hall_select((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)));
        hall_result((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)) = myidct2(C);
    end
end
subplot(2, 2, 2);
imshow(uint8(hall_result + 128));
title("������任��ͼ��");

for a = 1:(h / 8)
    for b = 1:(w / 8)
        C = mydct2(hall_select((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)));
        C(:, 5: 8) = 0;
        hall_result((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)) = myidct2(C);
    end
end
subplot(2, 2, 3);
imshow(uint8(hall_result + 128));
title("�Ҳ�4������任��ͼ��");

for a = 1:(h / 8)
    for b = 1:(w / 8)
        C = mydct2(hall_select((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)));
        C(:, 1: 4) = 0;
        hall_result((8 * a - 7):(8 * a), (8 * b - 7):(8 * b)) = myidct2(C);
    end
end
subplot(2, 2, 4);
imshow(uint8(hall_result + 128));
title("���4������任��ͼ��");
