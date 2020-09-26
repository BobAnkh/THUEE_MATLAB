close all;
clc;

rhythm_f = [523.25,523.25,587.33,392,349.23,349.23,293.66,392];
note_time = [1,0.5,0.5,2,1,0.5,0.5,2];
fs = 8000;

cur_pos = 1;
for k=1:length(note_time)
    t = 1/fs:1/fs:note_time(k);
    music(cur_pos:(cur_pos + note_time(k)*fs - 1)) = sin(2*pi*rhythm_f(k)*t);
    cur_pos = cur_pos + note_time(k)*fs;
end
plot(music);
sound(music,fs);