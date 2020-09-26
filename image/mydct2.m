function C = mydct2(P)
    % 认为P是个方阵
    P = double(P);
    N = size(P, 1);
    D = cos((1:2:(2 * N - 1)) .* (0:1:(N - 1))' * pi / 2 / N);
    D(1, :) = sqrt(0.5);
    D = sqrt(2 / N) * D;
    C = D * P * D';
end

