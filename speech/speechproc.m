function speechproc()

    % 定义常数
    FL = 80;                % 帧长
    WL = 240;               % 窗长
    P = 10;                 % 预测系数个数
    s = readspeech('voice.pcm',100000);             % 载入语音s
    L = length(s);          % 读入语音长度
    FN = floor(L/FL)-2;     % 计算帧数
    % 预测和重建滤波器
    exc = zeros(L,1);       % 激励信号（预测误差）
    zi_pre = zeros(P,1);    % 预测滤波器的状态
    s_rec = zeros(L,1);     % 重建语音
    zi_rec = zeros(P,1);
    % 合成滤波器
    exc_syn = zeros(L,1);   % 合成的激励信号（脉冲串）
    s_syn = zeros(L,1);     % 合成语音
    zi_syn = zeros(P,1);
    % 变调不变速滤波器
    exc_syn_t = zeros(L,1);   % 合成的激励信号（脉冲串）
    s_syn_t = zeros(L,1);     % 合成语音
    zi_syn_t = zeros(P,1);
    % 变速不变调滤波器（假设速度减慢一倍）
    exc_syn_v = zeros(2*L,1);   % 合成的激励信号（脉冲串）
    s_syn_v = zeros(2*L,1);     % 合成语音
    zi_syn_v = zeros(P,1);

    hw = hamming(WL);       % 汉明窗
    
    pos = 2*FL+1;           % 激励信号起始位置
    
    FL_v = FL*2;            % 变速不变调的帧长
    pos_v = 2*FL_v+1;       % 变速不变调激励信号起始位置
    
    pos_t = 2*FL+1;         % 变调不变速激励信号起始位置
    % 依次处理每帧语音
    for n = 3:FN

        % 计算预测系数（不需要掌握）
        s_w = s(n*FL-WL+1:n*FL).*hw;    %汉明窗加权后的语音
        [A, E] = lpc(s_w, P);            %用线性预测法计算P个预测系数
                                        % A是预测系数，E会被用来计算合成激励的能量

        if n == 27
        % (3) 在此位置写程序，观察预测系统的零极点图
            figure;
            zplane(A, 1);
            title("预测系统的零极点图");
        end
        
        s_f = s((n-1)*FL+1:n*FL);       % 本帧语音，下面就要对它做处理

        % (4) 在此位置写程序，用filter函数s_f计算激励，注意保持滤波器状态
        
        [exc((n-1)*FL+1:n*FL), zi_pre] = filter(A, 1, s_f, zi_pre);

        % (5) 在此位置写程序，用filter函数和exc重建语音，注意保持滤波器状态
      
        [s_rec((n-1)*FL+1:n*FL), zi_rec] = filter(1, A, exc((n-1)*FL+1:n*FL), zi_rec);

        % 注意下面只有在得到exc后才会计算正确
        s_Pitch = exc(n*FL-222:n*FL);
        PT = findpitch(s_Pitch);    % 计算基音周期PT（不要求掌握）
        G = sqrt(E*PT);           % 计算合成激励的能量G（不要求掌握）

        
        % (10) 在此位置写程序，生成合成激励，并用激励和filter函数产生合成语音

        while pos <= n * FL
            exc_syn(pos) = G;
            pos = pos + PT;
        end
        [s_syn((n-1)*FL+1:n*FL), zi_syn] = filter(1, A, exc_syn((n-1)*FL+1:n*FL), zi_syn);

        % (11) 不改变基音周期和预测系数，将合成激励的长度增加一倍，再作为filter
        % 的输入得到新的合成语音，听一听是不是速度变慢了，但音调没有变。

        while pos_v <= n * FL_v
            exc_syn_v(pos_v) = G;
            pos_v = pos_v + PT;
        end
        [s_syn_v((n-1)*FL_v+1:n*FL_v), zi_syn_v] = filter(1, A, exc_syn_v((n-1)*FL_v+1:n*FL_v), zi_syn_v);
        
        % (13) 将基音周期减小一半，将共振峰频率增加150Hz，重新合成语音，听听是啥感受～
        while pos_t <= n * FL
            exc_syn_t(pos_t) = G;
            pos_t = pos_t + round(PT / 2);
        end
        [z, p, k] = tf2zpk(1, A);
        p = p .* exp(1i * sign(imag(p)) * 150 * 2 * pi / 8000);
        [~, A1] = zp2tf(z, p, k);
        [s_syn_t((n-1)*FL+1:n*FL), zi_syn_t] = filter(1, A1, exc_syn_t((n-1)*FL+1:n*FL), zi_syn_t);
        
    end

    % (6) 在此位置写程序，听一听 s ，exc 和 s_rec 有何区别，解释这种区别
    % 后面听语音的题目也都可以在这里写，不再做特别注明
    
    % 试听第(6)题的3个信号
    % sound([s;exc;s_rec] / 32768, 8000);

    % 试听本报告生成的全部信号，分别是:
    % 原始语音s, 激励信号exc, 重建语音s_rec, 合成语音s_syn, 变速不变调s_syn_v, 变调不变速s_syn_t
    sound([s;exc;s_rec;s_syn;s_syn_v;s_syn_t] / 32768, 8000);

    % 绘制(6)时域波形图
    time = (0 : L - 1)' / 8000;
    figure;
    subplot(3, 1, 1);
    plot(time, s);
    % 查看细节波形
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s(n)');
    subplot(3, 1, 2);
    plot(time, exc);
    % 查看细节波形
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('exc(n)');
    subplot(3, 1, 3);
    plot(time, s_rec);
    % 查看细节波形
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s\_rec(n)');
    
    % 绘制(6)频域波形图
    figure;
    fft_freq = 8000 * (0 : (L / 2))' / L;
    subplot(3, 1, 1);
    S = abs(fft(s) / L);
    S = S(1 : L / 2 + 1);
    S(2 : end - 1) = 2 * S(2 : end - 1);
    plot(fft_freq, S);
    ylabel('s(n)单侧频谱');
    subplot(3, 1, 2);
    EXC = abs(fft(exc) / L);
    EXC = EXC(1 : L / 2 + 1);
    EXC(2 : end - 1) = 2 * EXC(2 : end - 1);
    plot(fft_freq, EXC);
    ylabel('exc(n)单侧频谱');
    subplot(3, 1, 3);
    S_REC = abs(fft(s_rec) / L);
    S_REC = S_REC(1 : L / 2 + 1);
    S_REC(2 : end - 1) = 2 * S_REC(2 : end - 1);
    plot(fft_freq, S_REC);
    ylabel('s\_rec(n)单侧频谱');

    % 绘制(10)时域波形图
    time = (0 : L - 1)' / 8000;
    figure;
    subplot(2, 1, 1);
    plot(time, s);
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s(n)');
    subplot(2, 1, 2);
    plot(time, s_syn);
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s\_syn(n)');
    
    % 绘制(10)频域波形图
    figure;
    fft_freq = 8000 * (0 : (L / 2))' / L;
    subplot(2, 1, 1);
    S = abs(fft(s) / L);
    S = S(1 : L / 2 + 1);
    S(2 : end - 1) = 2 * S(2 : end - 1);
    plot(fft_freq, S);
    ylabel('s(n)单侧频谱');
    subplot(2, 1, 2);
    S_SYN = abs(fft(s_syn) / L);
    S_SYN = S_SYN(1 : L / 2 + 1);
    S_SYN(2 : end - 1) = 2 * S_SYN(2 : end - 1);
    plot(fft_freq, S_SYN);
    ylabel('s\_syn(n)单侧频谱');
    
    % 绘制(11)和(13)时域波形图
    time = (0 : L - 1)' / 8000;
    time1 = (0 : 2 * L - 1)' / 8000;
    figure;
    subplot(4, 1, 1);
    plot(time, s);
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s(n)');
    subplot(4, 1, 2);
    plot(time, s_syn);
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s\_syn(n)');
    subplot(4, 1, 3);
    plot(time1, s_syn_v);
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s\_syn\_v(n)');
    subplot(4, 1, 4);
    plot(time, s_syn_t);
    % set(gca, 'XLim', [0.5, 0.55]);
    ylabel('s\_syn\_t(n)');
    
    % 绘制(11)和(13)频域波形图
    figure;
    fft_freq = 8000 * (0 : (L / 2))' / L;
    fft_freq1 = 2 * 8000 * (0 : L)' / L;
    subplot(4, 1, 1);
    S = abs(fft(s) / L);
    S = S(1 : L / 2 + 1);
    S(2 : end - 1) = 2 * S(2 : end - 1);
    plot(fft_freq, S);
    ylabel('s(n)单侧频谱');
    subplot(4, 1, 2);
    S_SYN = abs(fft(s_syn) / L);
    S_SYN = S_SYN(1 : L / 2 + 1);
    S_SYN(2 : end - 1) = 2 * S_SYN(2 : end - 1);
    plot(fft_freq, S_SYN);
    ylabel('s\_syn(n)单侧频谱');
    subplot(4, 1, 3);
    S_SYN_V = abs(fft(s_syn_v) / L);
    S_SYN_V = S_SYN_V(1 : L + 1);
    S_SYN_V(2 : end - 1) = 2 * S_SYN_V(2 : end - 1);
    plot(fft_freq1, S_SYN_V);
    ylabel('s\_syn\_v(n)单侧频谱');
    subplot(4, 1, 4);
    S_SYN_T = abs(fft(s_syn_t) / L);
    S_SYN_T = S_SYN_T(1 : L / 2 + 1);
    S_SYN_T(2 : end - 1) = 2 * S_SYN_T(2 : end - 1);
    plot(fft_freq, S_SYN_T);
    ylabel('s\_syn\_t(n)单侧频谱');
    
    % 保存所有文件
    writespeech('exc.pcm',exc);
    writespeech('rec.pcm',s_rec);
    writespeech('exc_syn.pcm',exc_syn);
    writespeech('syn.pcm',s_syn);
    writespeech('exc_syn_t.pcm',exc_syn_t);
    writespeech('syn_t.pcm',s_syn_t);
    writespeech('exc_syn_v.pcm',exc_syn_v);
    writespeech('syn_v.pcm',s_syn_v);
return

% 从PCM文件中读入语音
function s = readspeech(filename, L)
    fid = fopen(filename, 'r');
    s = fread(fid, L, 'int16');
    fclose(fid);
return

% 写语音到PCM文件中
function writespeech(filename,s)
    fid = fopen(filename,'w');
    fwrite(fid, s, 'int16');
    fclose(fid);
return

% 计算一段语音的基音周期，不要求掌握
function PT = findpitch(s)
[B, A] = butter(5, 700/4000);
s = filter(B,A,s);
R = zeros(143,1);
for k=1:143
    R(k) = s(144:223)'*s(144-k:223-k);
end
[R1,T1] = max(R(80:143));
T1 = T1 + 79;
R1 = R1/(norm(s(144-T1:223-T1))+1);
[R2,T2] = max(R(40:79));
T2 = T2 + 39;
R2 = R2/(norm(s(144-T2:223-T2))+1);
[R3,T3] = max(R(20:39));
T3 = T3 + 19;
R3 = R3/(norm(s(144-T3:223-T3))+1);
Top = T1;
Rop = R1;
if R2 >= 0.85*Rop
    Rop = R2;
    Top = T2;
end
if R3 > 0.85*Rop
    Rop = R3;
    Top = T3;
end
PT = Top;
return