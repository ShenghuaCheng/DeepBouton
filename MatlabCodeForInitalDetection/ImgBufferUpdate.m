function ImgBufferUpdate(imgBlock, blockInd)
global imgBufferGb
n = size(imgBufferGb, 1);
temp = zeros(n, 1);
for i = 1 : n
    temp(i) = imgBufferGb{i}.orderInd;
end
temp1 = find(temp == n);
temp2 = find(temp ~= n);
imgBufferGb{temp1}.imgBlock = imgBlock;
imgBufferGb{temp1}.xyzInd = blockInd;
imgBufferGb{temp1}.orderInd = 1;
for i = 1 : n - 1
    imgBufferGb{temp2(i)}.orderInd = imgBufferGb{temp2(i)}.orderInd + 1;
end

end

