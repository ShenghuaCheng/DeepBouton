function [initialInd, connectedCImg] = ExtractMinBox(pixelList, origImg)
%% 根据形态参数 重新定位和分割
%
temp2 = min(pixelList, [], 1); % 这儿的temp2， temp3， temp4， temp4_1, temp7都是临时变量
temp3 = max(pixelList, [], 1);
temp7 =  sub2ind([temp3(1) - temp2(1) + 1, temp3(2) - temp2(2) + 1, temp3(3) - temp2(3) + 1], pixelList(:, 1) - temp2(1) + 1, pixelList(:, 2) - temp2(2) + 1, pixelList(:, 3) - temp2(3) + 1);
temp4 = origImg(temp2(1) : temp3(1), temp2(2) : temp3(2), temp2(3) : temp3(3));
temp4_1 = temp4;
temp4 = zeros(size(temp4), 'uint16');
temp4(temp7) = temp4_1(temp7); %取包含单个连通域的矩形，
initialInd = temp2;
connectedCImg = temp4;


