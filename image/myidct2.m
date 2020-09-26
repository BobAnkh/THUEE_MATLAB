function P = myidct2(C)
    C = double(C);
    N = size(C, 1);
    D = cos((1:2:(2 * N - 1)) .* (0:1:(N - 1))' * pi / 2 / N);
    D(1, :) = sqrt(0.5);
    D = sqrt(2 / N) * D;
    P = D' * C * D;
end

