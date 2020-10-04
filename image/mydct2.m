function C = mydct2(P)
%mydct2 自己写的进行DCT变换的函数
%   P:待变换的矩阵，认为P是个方阵
    P = double(P);
    N = size(P, 1);
    D = cos((1:2:(2 * N - 1)) .* (0:1:(N - 1))' * pi / 2 / N);
    D(1, :) = sqrt(0.5);
    D = sqrt(2 / N) * D;
    C = D * P * D';
end

