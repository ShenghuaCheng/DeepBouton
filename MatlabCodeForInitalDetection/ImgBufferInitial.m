function imgBuffer = ImgBufferInitial(bufferNum)
imgBuffer = cell(bufferNum, 1);
for i = 1 : bufferNum
    imgBuffer{i}.imgBlock = [];
    imgBuffer{i}.xyzInd = [-1 -1 -1];
    imgBuffer{i}.orderInd = i;
end

end

