%DCTHide2 �ڶ���DCT����Ϣ����
clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
image = double(hall_gray);
% JPEG����
[height, width] = size(image);
% ͼ��Ԥ����������
img = preprocess(image);
img_quantified = quantify(img, QTAB);
% ������Ϣ
% ���������Ϣ
h = size(img_quantified, 1);
w = size(img_quantified, 2);
max_len = h * w;
% ���������ʼ��
start = randi(max_len);
% ������ʼ�����ɳ���
seq_len = randi(max_len - start);
hide_info = randi([0, 1], 1, seq_len);

% ����Ϣ������img_quantified, ����start��seq_len����м������ϵ��
hidden = reshape(img_quantified.', 1, []);
hidden(start: start + seq_len - 1) =  bitshift(bitshift(hidden(start: start + seq_len - 1), -1, 'int64'), 1, 'int64')+ hide_info;
img_quantified = reshape(hidden, [], 64).';

% ��������Ϣ��ȡ����
extract_seq = reshape(img_quantified.', 1, []);
extract_info = mod(extract_seq(start: start + seq_len - 1), 2);
correct = length(find(extract_info==hide_info));
correct_rate = correct / seq_len;
fprintf("����2ֻ������Ϣ����ȷ��: %f\n", correct_rate);
% DCϵ��
dc_coeff = img_quantified(1, :);
% DC��ֱ���
dc_diff = [dc_coeff(1), -diff(dc_coeff)];
% DC Huffman����
DC = DCHuffman(dc_diff, DCTAB);
% AC Huffman����
AC = ACHuffman(img_quantified(2:end, :), ACTAB);
fprintf("����2ѹ����Ϊ: %5.4f\n", height * width * 8 / (size(DC, 2) + size(AC, 2)));

% JPEG����
col = ceil(height / 8) * ceil(width / 8);
img_quantified = zeros(64, col);
dc_coeff = DCdecode(DC, col);
img_quantified(1,:) = dc_coeff;
ac_coeff = ACdecode(AC, ACTAB, col);
img_quantified(2:64,:) = ac_coeff;

% ��������Ϣ��ȡ����
extract_seq = reshape(img_quantified.', 1, []);
extract_info = mod(extract_seq(start: start + seq_len - 1), 2);
correct = length(find(extract_info==hide_info));
correct_rate = correct / seq_len;
fprintf("����2��JPEG���������ȷ��: %f\n", correct_rate);
image = iquantify(img_quantified, QTAB, height, width);
image = uint8(image + 128);
imshow(image);
psnr = 10 * log10(255^2 / mse(image, hall_gray));
fprintf("����2��PSNR = %6.4fdB\n", psnr);

function DC = DCHuffman(dc_diff, DCTAB)
    category = ceil(log2(abs(dc_diff)+1));
    DCList = [];
    for a = 1:length(category)
       % category��Huffman����
       category_huff =  DCTAB(category(a) + 1, 2: (DCTAB(category(a) + 1, 1) + 1));
       % magnitude�ı���
       if(dc_diff(a) > 0)
           bin = split(dec2bin(dc_diff(a)), '');
           magnitude = str2double(bin(2:end - 1)).';
       elseif(dc_diff(a) == 0)
           magnitude = [];
       else
           bin = split(dec2bin(-dc_diff(a)), '');
           magnitude = ~str2double(bin(2:end - 1)).';
       end
       DCList = [DCList, category_huff, magnitude];
    end
    DC = num2str(DCList, '%d');
end

function AC = ACHuffman(ac_coeff, ACTAB)
    ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1];
    EOB = [1, 0, 1, 0];
    ACList = [];
    for a = 1:size(ac_coeff, 2)
       ac = ac_coeff(:, a).';
       % ����ֵ��index
       index = find(ac);
       if(isempty(index))
           ACList = [ACList, EOB];
           continue;
       end
       % ÿ������ֵ��Ӧ���γ�
       ac_run = [index(1), diff(index)] - 1;
       for b = 1:length(index)
           while(ac_run(b) >= 16)
               ACList = [ACList, ZRL];
               ac_run(b) = ac_run(b) - 16;
           end
           amp = ac(index(b));
           ac_size = ceil(log2(abs(amp)+1));
           % run/size��Huffman����
           number = find(ACTAB(:,1) == ac_run(b) & ACTAB(:,2) == ac_size);
           rs_huff = ACTAB(number, 4: (ACTAB(number, 3) + 3));
            % amplitude�ı���
           if(amp > 0)
               bin = split(dec2bin(amp), '');
               amplitude = str2double(bin(2:end - 1)).';
           elseif(amp == 0)
               amplitude = [];
           else
               bin = split(dec2bin(-amp), '');
               amplitude = ~str2double(bin(2:end - 1)).';
           end
           ACList = [ACList, rs_huff, amplitude];
       end
       ACList = [ACList, EOB];
    end
    AC = num2str(ACList, '%d');
end
function dc_coeff = DCdecode(DC, col)
    
    % ������ת��������
    a = str2double(split(DC, '')).';
    DCList = a(2:end-1);
    dc_coeff = zeros(1, col);
    for b = 1:col
        if(all(DCList(1:2) == 0))
            DCList(1:2) = [];
            % ��ʱ��Ӧdc_coeff(b)�Ѿ���0�ˣ�����������
        else
            % Ѱ�ҵ�һ��0��λ��
            index = find(~DCList, 1);
            % ����category
            if(index <= 3)
                category = bin2dec(num2str(DCList(1:3), '%d')) - 1;
                DCList(1:3) = [];
            else
                category = index + 2;
                DCList(1:index) = [];
            end
            magnitude = DCList(1:category);
            if(magnitude(1) == 1)
                dc_coeff(b) = bin2dec(num2str(magnitude, '%d'));
            else
                dc_coeff(b) = -bin2dec(num2str(~magnitude, '%d'));
            end
            DCList(1:category) = [];
        end
    end
    for c = 2:col
        dc_coeff(c) = dc_coeff(c - 1) - dc_coeff(c);
    end
end



function ac_coeff = ACdecode(AC, ACTAB, col)
    ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1];
    EOB = [1, 0, 1, 0];
    % ������ת��������
    a = str2double(split(AC, '')).';
    ACList = a(2:end-1);
    ac_coeff = zeros(63, col);
    b = 1;
    index = 0;
    while(b <= col)
        if(all(ACList(1:4) == EOB))
            b = b + 1;
            index = 0;
            ACList(1:4) = [];
        elseif(length(ACList) > 11 && all(ACList(1:11) == ZRL))
            index = index + 16;
            ACList(1:11) = [];
        else     
            % ȡrun��size
            for c = 1:size(ACTAB, 1)
                L = ACTAB(c, 3);
                if(L > length(ACList))
                    continue;
                end
                if(all(ACList(1:L) == ACTAB(c, 4:L + 3)))
                    ac_run = ACTAB(c, 1);
                    ac_size = ACTAB(c, 2);
                    ACList(1:L) = [];
                    break;
                end
            end
            index = index + ac_run + 1;           
            amplitude = ACList(1:ac_size);
            if(amplitude(1) == 1)
                ac_coeff(index, b) = bin2dec(num2str(amplitude, '%d'));
            else
                ac_coeff(index, b) = -bin2dec(num2str(~amplitude, '%d'));
            end
            ACList(1:ac_size) = [];
        end
    end
end