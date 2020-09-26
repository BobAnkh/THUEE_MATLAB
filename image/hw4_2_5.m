close all; 
clc;
% TODO 再去看看ggg的matlab小学期是怎么得到幅频响应的
b = [-1, 1];
a = 1;
n = 5000;
[h, w] = freqz(b, a, n); 
subplot(2, 1, 1);
plot(w / pi, 20 * log10(abs(h)));
% plot(w / pi, abs(h));
% set(gca,'YScale','log')
% xlabel("freq/pi");
ylabel("Magnitude/db");
title("频率响应（幅度）");
subplot(2, 1, 2);
plot(w / pi,angle(h) * 180 / pi);
xlabel("freq/pi");
ylabel("Phase/°");
title("频率响应（相位）");