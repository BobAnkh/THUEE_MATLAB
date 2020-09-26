function amp = envelope(len)
    n = 1:len;
    % TODO: 改成分段类型的，可以尝试多种包络，包括折线、指数衰减和现在这样的
    % 尝试过使用n之后发现冲激比较迟缓，决定使用sqrt(n)
    %amp =  exp(0.5) / sqrt(len / 14) * sqrt(n).*exp(- 7 * n / len);
    amp =  10 * exp(1) /len  * n.*exp(- 10 * n / len);
    %border = ceil(len*0.6);
    %attenuation = border:len;
    %amp(border:len) = amp(border)/exp(-15*border/len)*exp(-15*attenuation/len);
    % plot(amp);
end

