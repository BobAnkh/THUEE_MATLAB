close all; 
clc;
% TODO ��ȥ����ggg��matlabСѧ������ô�õ���Ƶ��Ӧ��
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
title("Ƶ����Ӧ�����ȣ�");
subplot(2, 1, 2);
plot(w / pi,angle(h) * 180 / pi);
xlabel("freq/pi");
ylabel("Phase/��");
title("Ƶ����Ӧ����λ��");