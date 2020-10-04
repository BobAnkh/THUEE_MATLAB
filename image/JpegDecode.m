function image = JpegDecode(DC, AC, height, width, QTAB, ACTAB)
%JpegDecode
%   DC: DC码流
%   AC: AC码流
%   height: 原始图像高度
%   width: 原始图像宽度
%   QTAB: 量化系数
%   ACTAB: AC系数码本

col = ceil(height / 8) * ceil(width / 8);
img_quantified = zeros(64, col);
% 解码出DC系数
dc_coeff = DCdecode(DC, col);
img_quantified(1,:) = dc_coeff;
% 解码出AC系数
ac_coeff = ACdecode(AC, ACTAB, col);
img_quantified(2:64,:) = ac_coeff;
% 反量化
image = iquantify(img_quantified, QTAB, height, width);
image = uint8(image + 128);
end

function dc_coeff = DCdecode(DC, col)
    
    % 从码流转换成数组
    a = str2double(split(DC, '')).';
    DCList = a(2:end-1);
    dc_coeff = zeros(1, col);
    for b = 1:col
        if(all(DCList(1:2) == 0))
            DCList(1:2) = [];
            % 此时对应dc_coeff(b)已经是0了，无需额外操作
        else
            % 寻找第一个0的位置
            index = find(~DCList, 1);
            % 计算category
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
    % 从码流转换成数组
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
            % 取run和size
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