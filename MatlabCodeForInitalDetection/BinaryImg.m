function binImg = BinaryImg(origImg, binThre, eroThre, eroNum)
%¶þÖµ»¯
binImg = zeros(size(origImg), 'uint16');
parfor i = 1 : size(origImg, 3)
    tempBackImg = origImg(:, :, i);
    tempBackImg = padarray(tempBackImg, [4 4], 'symmetric');
    averageTemplate = ones(9,9)/81;
    tempBackImg = double(tempBackImg);
    for j = 1 : 20
        tempBackImg = conv2(tempBackImg, averageTemplate, 'valid');
        tempBackImg = padarray(tempBackImg, [4 4], 'symmetric');
    end
    tempBackImg = tempBackImg(5 : end - 4, 5 : end - 4); 
    tempBackImg = tempBackImg + binThre .* sqrt(tempBackImg);
    binImg(:, :, i) = origImg(:, :, i) > tempBackImg; 
end

for i = 1 : eroNum
    binImg = ErodeImg(binImg, eroThre);
end

end


