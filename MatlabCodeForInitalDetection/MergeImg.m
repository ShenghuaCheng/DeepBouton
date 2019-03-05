function [imgPrj, offset] = MergeImg(imgTotal)
n = size(imgTotal, 1);
OFFSET = zeros(2 * n, 2);
for i = 1 : n
    OFFSET(i * 2 - 1, :) = [1 1] + imgTotal{i}.offset(1 : 2);
    OFFSET(i * 2, :) = size(imgTotal{i}.imgPrj) + imgTotal{i}.offset(1 : 2);
end
boxInd = [min(OFFSET, [], 1) max(OFFSET, [], 1)];
offset = boxInd(1 : 2) - 1;
imgSize = boxInd(3 : 4) - boxInd(1 : 2) + 1;

imgPrj = zeros(imgSize, 'uint16');
for i = 1 : n
    tempInd = [[1 1] + imgTotal{i}.offset(1 : 2) - offset size(imgTotal{i}.imgPrj) + imgTotal{i}.offset(1 : 2) - offset];
    imgPrj(tempInd(1) : tempInd(3), tempInd(2) : tempInd(4)) = max(imgPrj(tempInd(1) : tempInd(3), tempInd(2) : tempInd(4)), imgTotal{i}.imgPrj);
end

end

