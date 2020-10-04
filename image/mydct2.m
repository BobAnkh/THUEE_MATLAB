function C = mydct2(P)
%mydct2 �Լ�д�Ľ���DCT�任�ĺ���
%   P:���任�ľ�����ΪP�Ǹ�����
    P = double(P);
    N = size(P, 1);
    D = cos((1:2:(2 * N - 1)) .* (0:1:(N - 1))' * pi / 2 / N);
    D(1, :) = sqrt(0.5);
    D = sqrt(2 / N) * D;
    C = D * P * D';
end

