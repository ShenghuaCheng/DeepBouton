function [imgBlock, flag] = ImgBufferQuery(blockInd)
global imgBufferGb
n = size(imgBufferGb, 1);
flag = 0;
for i = n : -1 : 1
    if sum(imgBufferGb{i}.xyzInd == blockInd) == 3
        flag = 1;
        imgBlock = imgBufferGb{i}.imgBlock;
        break;
    end
end
if flag == 0
    imgBlock = [];
end

end

