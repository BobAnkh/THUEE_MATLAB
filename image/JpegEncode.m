function [DC, AC, height, width] = JpegEncode(image, QTAB, DCTAB, ACTAB)
%JpegEncode JPEG编码函数
%   image:未经任何处理的原始图片
%   QTAB:量化系数
%   DCTAB:DC系数码本
%   ACTAB:AC系数码本

[height, width] = size(image);

% 图像预处理与量化
img = preprocess(image);
img_quantified = quantify(img, QTAB);

% DC系数
dc_coeff = img_quantified(1, :);
% DC差分编码
dc_diff = [dc_coeff(1), -diff(dc_coeff)];
% DC Huffman编码
DC = DCHuffman(dc_diff, DCTAB);

% AC Huffman编码
AC = ACHuffman(img_quantified(2:end, :), ACTAB);

end

function DC = DCHuffman(dc_diff, DCTAB)
    category = ceil(log2(abs(dc_diff)+1));
    DCList = [];
    for a = 1:length(category)
       % category的Huffman编码
       category_huff =  DCTAB(category(a) + 1, 2: (DCTAB(category(a) + 1, 1) + 1));
       % magnitude的编码
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
       % 非零值的index
       index = find(ac);
       if(isempty(index))
           ACList = [ACList, EOB];
           continue;
       end
       % 每个非零值对应的游程
       ac_run = [index(1), diff(index)] - 1;
       for b = 1:length(index)
           while(ac_run(b) >= 16)
               ACList = [ACList, ZRL];
               ac_run(b) = ac_run(b) - 16;
           end
           amp = ac(index(b));
           ac_size = ceil(log2(abs(amp)+1));
           % run/size的Huffman编码
           number = find(ACTAB(:,1) == ac_run(b) & ACTAB(:,2) == ac_size);
           rs_huff = ACTAB(number, 4: (ACTAB(number, 3) + 3));
            % amplitude的编码
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
