function vector = myzigzag(matrix)
% 针对本大作业独特情况，8x8分块采用更高效的索引法，同时也给出更通用但是效率相对差一些的循环法
[h, w] = size(matrix);
% 这个if可能已经不需要了
if h == 1 && w == 1
    vector = matrix;
elseif h == 8 && w == 8
    vector = reshape(matrix', 1, 64);
% index需要再检查一遍
    index = [1, 2, 9, 17, 10, 3, 4, 11,...
    18, 25, 33, 26, 19, 12, 5, 6,...
    13, 20, 27, 34, 41, 49, 42, 35,...
    28, 21, 14, 7, 8, 15, 22, 29,...
    36, 43, 50, 57, 58, 51, 44, 37,...
    30, 23, 16, 24, 31, 38, 45, 52,...
    59, 60, 53, 46, 39, 32, 40, 47,...
    54, 61, 62, 55, 48, 56, 63, 64];
    vector = vector(index);
else
    row = 1;
    col = 1;
    pos = 1;
    % 方向，第一维表示纵向，第二维表示横向
    direction = [-1, 1];
    vector = zeros(1, h*w);
    while( row <= h && col <= w)
        vector(pos) = matrix(row, col);
        if isequal(direction, [-1, 1]) && row == 1 && col ~= w
            direction = [0, 1];
            col = col + 1;
        elseif isequal(direction, [-1, 1]) && col == w
            direction = [1, 0];
            row = row + 1;
        elseif isequal(direction, [-1, 1]) && row ~= 1 && col ~= w
            row = row - 1;
            col = col + 1;
        elseif isequal(direction, [1, -1]) && row ~= h && col == 1
            direction = [1, 0];
            row = row + 1;
        elseif isequal(direction, [1, -1]) && row == h
            direction = [0, 1];
            col = col + 1;
        elseif isequal(direction, [1, -1]) && col ~= 1 && row ~= h
            row = row + 1;
            col = col - 1;
        elseif isequal(direction, [1, 0]) && col == 1
            direction = [-1, 1];
            row = row - 1;
            col = col + 1;
        elseif isequal(direction, [0, 1]) && row == 1
            direction = [1, -1];
            row = row + 1;
            col = col - 1;
        elseif isequal(direction, [1, 0]) && col == w
            direction = [1, -1];
            row = row + 1;
            col = col - 1;
        elseif isequal(direction, [0, 1]) && row == h
            direction = [-1, 1];
            row = row - 1;
            col = col + 1;
        end
        pos = pos + 1;
    end
        
end
end

