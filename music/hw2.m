% 1
% [x, y] = meshgrid(0:1:100,0:1:50);
% phi_1 = zeros(51, 101);
% for i = 2:100
%     phi_1(51, i) = 10;
% end
% phi_2 = phi_1;
% error = 1;
% eps = 1e-7;
% while( error > eps)
%     error = 0;
%     for i = 2:50
%         for j = 2:100
%             phi_2(i, j) = (phi_1(i-1, j) + phi_1(i+1, j) + phi_1(i, j-1) + phi_1(i, j+1)) ./ 4;
%             if (abs(phi_2(i, j) - phi_1(i, j)) > error)
%                 error = abs(phi_2(i, j) - phi_1(i, j));
%             end
%         end
%     end
%     phi_1 = phi_2;
% end
% 
% contour(x, y, phi_1, 0.2:0.6:9.8);
% axis equal;
% xticks(0:10:100);
% yticks(0:10:50);
% grid minor;

% 2
% [x, y] = meshgrid(0:1:50,0:1:50);
% phi_1 = zeros(51, 51);
% for i = 2:50
%     phi_1(51, i) = 10;
% end
% phi_2 = phi_1;
% error = 1;
% eps = 1e-7;
% while( error > eps)
%     error = 0;
%     for i = 2:50
%         for j = 2:50
%             phi_2(i, j) = (phi_1(i-1, j) + phi_1(i+1, j) + phi_1(i, j-1) + phi_1(i, j+1)) ./ 4;
%             if (abs(phi_2(i, j) - phi_1(i, j)) > error)
%                 error = abs(phi_2(i, j) - phi_1(i, j));
%             end
%         end
%     end
%     for i=2:50
%         phi_2(i, 51) = phi_2(i, 50);
%     end
%     phi_1 = phi_2;
% end
% 
% contour(x, y, phi_1, 0.2:0.6:9.8);
% axis equal;
% xticks(0:10:50);
% yticks(0:10:50);
% grid minor;

% 3
[x, y] = meshgrid(0:1:50,0:1:50);
phi_1 = zeros(51, 51);
for i = 2:50
    phi_1(51, i) = 10;
end
phi_2 = phi_1;
error = 1;
eps = 1e-7;
while( error > eps)
    error = 0;
    for i = 2:50
        for j = 2:50
            phi_2(i, j) = (phi_1(i-1, j) + phi_1(i+1, j) + phi_1(i, j-1) + phi_1(i, j+1)) ./ 4;
            if (abs(phi_2(i, j) - phi_1(i, j)) > error)
                error = abs(phi_2(i, j) - phi_1(i, j));
            end
        end
    end
    for i=2:50
        phi_2(i, 51) = phi_2(i, 50);
        phi_2(i, 1) = phi_2(i,2);
    end
    phi_1 = phi_2;
end

contour(x, y, phi_1, 0.2:0.6:9.8);
axis equal;
xticks(0:10:50);
yticks(0:10:50);
grid minor;