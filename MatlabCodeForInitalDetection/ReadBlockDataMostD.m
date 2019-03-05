function [imgBlock, imgBlockSP, imgPrj, offset] = ReadBlockDataMostD(pathMostD, numBlock, linexyz, r, binThre, eroThre, eroNum, swcArray, xyzRes)
blockInd = [round(min(linexyz, [], 1) - [50 50 15]) round(max(linexyz, [], 1) + [50 50 15])];
offset = blockInd(1 : 3) - 1;
imgOrig = ReadMostDBuffer(pathMostD, blockInd, numBlock);
imgBin = BinaryImg(imgOrig, binThre, eroThre, eroNum);
img = imgOrig .* imgBin;
img1 = false(size(img));
temp = round(linexyz);
temp = bsxfun(@minus, temp, offset);
temp1 = sub2ind(size(img), temp(:, 1), temp(:, 2), temp(:, 3));
img1(temp1) = 1;
templete = strel3dEh(2 * r + 1);
imgBlock = uint16(imdilate(img1, templete)) .* img;
imgBlockTemp = uint16(imdilate(img1, templete)) .* imgOrig;
imgPrj = max(imgBlockTemp, [], 3);

[swcArrayROI, ~] = GetSwcOfROI(swcArray, blockInd, xyzRes);
temp1 = bsxfun(@rdivide, swcArrayROI(:,3:5), xyzRes) + 1;
temp1 = temp1(:, [2 1 3]);
linexyz = temp1;
img1 = false(size(img));
temp = round(linexyz);
temp = bsxfun(@minus, temp, double(offset));
temp1 = sub2ind(size(img), temp(:, 1), temp(:, 2), temp(:, 3));
img1(temp1) = 1;
imgBlockSP = uint16(imdilate(img1, templete)) .* imgOrig;
    
end

