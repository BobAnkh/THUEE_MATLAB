function vector = myzigzag(matrix)
% ��Ա�����ҵ���������8x8�ֿ���ø���Ч����������ͬʱҲ������ͨ�õ���Ч����Բ�һЩ��ѭ����
[h, w] = size(matrix);
% ���if�����Ѿ�����Ҫ��
if h == 1 && w == 1
    vector = matrix;
elseif h == 8 && w == 8
    vector = reshape(matrix', 1, 64);
% index��Ҫ�ټ��һ��
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
    % ���򣬵�һά��ʾ���򣬵ڶ�ά��ʾ����
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

