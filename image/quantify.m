function C = quantify(image, QTAB)

P = double(image);
[h, w] = size(P);
C = [];
for a = 1:(h / 8)
    for b = 1:(w / 8)
        C = [C, myzigzag(round(mydct2(P((8 * a - 7):(8 * a), (8 * b - 7):(8 * b))) ./ QTAB))];
    end
end
