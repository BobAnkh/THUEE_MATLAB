close all;
clc;
load hall.mat;

% 绘制原图像
imwrite(hall_color, 'hall_color.jpg');

% 绘制红色圆
hall_circle = hall_color;
[h, w, c] = size(hall_color);
center_x = (w + 1)/2;
center_y = (h + 1)/2;
r = min(h/2, w/2);
[x, y] = meshgrid(1:w, 1:h);
distance = sqrt((x - center_x).^2 + (y - center_y).^2);
circle_area = distance <= r;
% 该圆透明红色
R = hall_color(:,:,1);
R(circle_area) = 255;
hall_circle(:,:,1) = R;
imwrite(hall_circle, 'hall_transparent_red_circle.jpg');
% 该圆实心红色
G = hall_color(:,:,2);
G(circle_area) = 0;
hall_circle(:,:,2) = G;
B = hall_color(:,:,3);
B(circle_area) = 0;
hall_circle(:,:,3) = B;
imwrite(hall_circle, 'hall_opaque_red_circle.jpg');
% 绘制棋盘格，修改block_w为单个棋盘格横向宽度，修改block_h为单个棋盘格纵向高度
hall_chess = hall_color;
block_w = 21;
block_h = 20;
x = ceil(x / block_w);
y = ceil(y / block_h);
chess_area = logical(mod(x + y +1, 2));
R = hall_color(:,:,1);
R(chess_area) = 0;
hall_chess(:,:,1) = R;
G = hall_color(:,:,2);
G(chess_area) = 0;
hall_chess(:,:,2) = G;
B = hall_color(:,:,3);
B(chess_area) = 0;
hall_chess(:,:,3) = B;
imwrite(hall_circle, 'hall_chess.jpg');
