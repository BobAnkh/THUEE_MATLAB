function amp = envelope(len)
    n = 1:len;
    % TODO: �ĳɷֶ����͵ģ����Գ��Զ��ְ��磬�������ߡ�ָ��˥��������������
    % ���Թ�ʹ��n֮���ֳ弤�Ƚϳٻ�������ʹ��sqrt(n)
    %amp =  exp(0.5) / sqrt(len / 14) * sqrt(n).*exp(- 7 * n / len);
    amp =  10 * exp(1) /len  * n.*exp(- 10 * n / len);
    %border = ceil(len*0.6);
    %attenuation = border:len;
    %amp(border:len) = amp(border)/exp(-15*border/len)*exp(-15*attenuation/len);
    % plot(amp);
end

