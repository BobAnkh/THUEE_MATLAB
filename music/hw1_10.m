close all;
clc;

rhythm_f = [523.25,523.25,587.33,392,349.23,349.23,293.66,392];
note_time = [1,0.5,0.5,2,1,0.5,0.5,2];
fs = 8000;

harmonic_wave_amp = [0.1661,0.2414,0.1581,0.1823,0,0,0.0583];

cur_pos = 1;
for k=1:length(note_time)
    t = 1/fs:1/fs:note_time(k);
    sample = zeros(1, length(t));
    for h = 1:length(harmonic_wave_amp)
        sample = sample + harmonic_wave_amp(h) * sin(2*pi*rhythm_f(k)*h*t);
    end
    music(cur_pos:(cur_pos + note_time(k)*fs - 1)) = sample.*envelope(note_time(k)*fs);
    cur_pos = cur_pos + note_time(k)*fs;
end
plot(music);
sound(music,fs);