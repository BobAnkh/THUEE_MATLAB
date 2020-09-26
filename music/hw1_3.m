close all;
clc;

rhythm_f = [523.25,523.25,587.33,392,349.23,349.23,293.66,392];
note_time = [1,0.5,0.5,2,1,0.5,0.5,2];
fs = 8000;

%rhythm_f = rhythm_f * 2; % 最简单的上升1个八度
%rhythm_f = rhythm_f / 2; % 最简单的下降1个八度

cur_pos = 1;
for k=1:length(note_time)
    t = 1/fs:1/fs:note_time(k);
    music(cur_pos:(cur_pos + note_time(k)*fs - 1)) = sin(2*pi*rhythm_f(k)*t).*envelope(note_time(k)*fs);
    cur_pos = cur_pos + note_time(k)*fs;
end
music = resample(music, 100, 106); % 上升半个音阶
%music = resample(music, 106, 100); % 下降半个音阶
plot(music);
sound(music,fs);