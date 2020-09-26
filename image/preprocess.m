function image_processed = preprocess(image)
image_processed = int16(image);
[h, w] = size(image_processed);
a = mod(w, 8);
b = mod(h, 8);
if a ~= 0
    col_block = zeros(h, 8 - a);
    col = image_processed(:, w);
    for num=1:(8 - a)
        col_block(:, num) = col;
    end
    image_processed = [image_processed col_block];
end
[h, w] = size(image_processed);
if b ~= 0
    row_block = zeros(8 - b, w);
    row = image_processed(h, :);
    for num=1:(8 - b)
        row_block(num, :) = row;
    end
    image_processed = [image_processed; row_block];
end
image_processed = image_processed - 128;
end

