%% play "老校歌"
function y = playlxg()
global lxg;
if length(lxg) < 5
    rhythm1 = [1 1 3 5 5 6 1 6 5 5 3 3 5 3 1 6 1 3 5 6 6 6 1 5 3 2 3 2 1 2 5 5 14 5 6 6 7 6 5 1 1 6 1 5 6 5 6 6 5 3 2 2 3 5 1 1 1 3 2 3 2 1 6 6 5 3 2 2 3 1 1 1 6 6 5 5 6 5 2 3 5 1 1 6 6 5 5 6 5 2 3 2 1;
    0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0;
    1 0.5 0.5 1 1 1 0.5 0.5 1 1 1 1 0.5 0.5 1 1 0.5 0.5 2 1 1 0.5 0.5 1 1 1 0.5 0.5 1 1 1 0.5 0.5 1 1 1 0.5 0.5 4 1.5 0.5 1 1 1.5 0.5 2 1.5 0.5 1 1 1 0.5 0.5 2 1.5 0.5 1 1 1 0.5 0.5 2 1.5 0.5 1 1 1 0.5 0.5 2 1 3 1 3 1 1 1 1 1 1 2 1 3 1 3 1 1 1 1 1 0.5 0.5 2];
    rhythm2 = [5 1 3 3 6 6 5 5 1 1 3 1 5 6 6 1 7 4 4 4 3 1 7 1 7 1 7 2 2 2 1 1 1 7 3 3 4 4 3 4 3 4 1 2 1 7 7 1 7 5 5 5 1 7 7 5 1 1 2 1 7 7 5 3 3 1 1 3 3 4 2 7 1 7 3 3 1 1 3 3 4 2 7 7 5;
    -1 0 0 0 0 0 0 0 0 0 0 0 -1 -1 -1 0 -1 0 0 0 0 0 -1 0 -1 0 -1 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 -1 -1 0 -1 -1 -1 -1 0 -1 -1 -1 0 0 0 0 -1 -1 -1 0 0 0 0 0 0 0 0 -1 0 -1 0 0 0 0 0 0 0 0 -1 -1 -1;
    1 1 1 1 1 1 1 1 1 1 0.5 0.5 1 1 0.5 0.5 2 1 1 1 1 1 1 0.5 0.5 1 1 1 1 1 1 1 1 4 1.5 0.5 1 1 1.5 0.5 2 1.5 0.5 1 1 1 0.5 0.5 2 1.5 0.5 1 1 1 1 2 1.5 0.5 1 1 1 1 2 1 3 1 3 1 1 1 1 1 1 2 1 3 1 3 1 1 1 1 1 1 2];
    rhythm3 = [3 3 5 1 1 6 6 1 1 5 5 1 5 3 14 4 4 5 1 1 1 6 1 5 5 5 4 3 5 7 7 7 14 4 4 5 5 5 1 1 1 1 1 1 4 5 5 5 5 5 3 3 3 5 5 4 3 4 4 5 5 5 4 3 5 5 4 4 1 1 1 7 5 5 5 5 5 4 4 1 1 1 7 5 5 4 3;
    0 0 0 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0;
    1 0.5 0.5 1 1 1 1 1 1 1 1 0.5 0.5 1 1 0.5 0.5 2 1 1 0.5 0.5 1 1 1 0.5 0.5 1 1 1 1 1 1 1 1 4 1.5 0.5 1 1 1.5 0.5 2 1.5 0.5 1 1 1 1 2 1.5 0.5 1 1 1 1 2 1.5 0.5 1 1 1 1 2 1 3 1 3 1 1 1 1 1 1 2 1 3 1 3 1 1 1 1 1 0.5 0.5 2];
    rhythm4 = [1 1 1 1 4 4 1 1 1 1 1 1 2 2 2 5 4 4 4 1 1 5 5 1 7 7 2 2 2 2 2 5 1 1 4 6 1 1 1 4 4 7 1 5 5 5 1 1 1 1 5 5 1 4 4 7 1 5 5 1 1 1 4 4 1 1 4 5 5 5 5 1 1 4 4 1 1 4 5 5 5 1;
    0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 -1 -1 -1 -1 0 0 -1 -1 0 -1 -1 0 0 0 0 0 -1 0 0 -1 -1 0 0 0 -1 -1 -1 0 -1 -1 -1 0 0 0 0 -1 -1 0 -1 -1 -1 0 -1 -1 0 0 0 -1 -1 0 0 -1 -1 -1 -1 -1 0 0 -1 -1 0 0 -1 -1 -1 -1 0;
    1 1 1 1 1 1 1 1 1 1 1 1 1 0.5 0.5 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 4 1.5 0.5 1 1 1.5 0.5 2 1.5 0.5 1 1 1 1 2 1.5 0.5 1 1 1 1 2 1.5 0.5 1 1 1 1 2 1 3 1 3 1 1 1 1 1 1 2 1 3 1 3 1 1 1 1 1 1 2];
    y1 = generaterhythm(rhythm1, 3); % in bE tune
    y2 = generaterhythm(rhythm2, 3); % in bE tune
    y3 = generaterhythm(rhythm3, 3); % in bE tune
    y4 = generaterhythm(rhythm4, 3); % in bE tune
    %plot(y);
    lxg = (y1+y2+y3/2+y4/2)/3;
    %plot(lxg);
    %sound(lxg); % play it!
else
    sound(lxg); % play it!
end

%wavwrite(lxg,'老校歌.wav');

%% generate a piece of rhythm
function y = generaterhythm(rhythm, basetune) 
% GENERATERHYTHM function.
% rhythm is a 3 * len matrix
% for each column, the element on the first row
% shows the 'sound name' of one tune, the one
% on the second row shows the sound step of that tune,
% and the one on the third row shows how long
%in seconds it should lasts.
fs = 8000;
soundpos = [0 2 4 5 7 9 11 0:12];
y = zeros(1, sum(rhythm(3,:))*fs + 1); % initialize
curpos = 1;
for count = 1 : length(rhythm)
cursoundname = rhythm(1, count);
cursoundpos = soundpos(cursoundname);
curfreq = 220 * 2 .^ ((cursoundpos + basetune + 3) / 12 + rhythm(2, count));
cursound = generatetune(curfreq, rhythm(3, count), fs);
y(1,curpos:(curpos + length(cursound) - 1)) = cursound;
curpos = curpos + length(cursound);
end
plot(y);
 
 
%% generate a piece of sound with the frequence of freq
function y = generatetune (freq, time, fs)
y1 = generatetune2 (freq + 3, time, fs);
y2 = generatetune2 (freq - 3, time, fs);
y3 = generatetune2 (freq, time, fs);
y = (y1 + y2) / 8 + y3 * (3 / 4);
 
 
%% generate a piece of sound with the frequence of freq
function y = generatetune2 (freq, time, fs)
c = [ 1 0.2 0.4 0.08 0.2 0.05 0.1 0.04 ];
t = 0:1/fs:(time - 1/fs);
y = zeros(1, length(t));
for j = 1 : 8
    y = y + c(j) * sin(t*j*freq*2*pi);
end
%%y = 0.6 * sin(t*freq*2*pi) + 0.1 * sin(t*freq*4*pi) + 0.2 * sin(t*freq*6*pi);
for count1 = 1 : length(y)
    y(1, count1) = y(1, count1) * amendment(count1 / 2000, length(y) / 2000);
end
 
%% amendment of the shape of the wave
function y = amendment(p, l) % 0 <= p <= 1
if p < 0.2
y = p * 5;
elseif p < 0.3
y = 1.8 - p * 4;
else
    y = 0.6 * exp((0.3 - p)/5);
%%elseif p < (l - 0.2)
%%y = 0.6;
%%else
%%y = (l - p) * 3;
end 
