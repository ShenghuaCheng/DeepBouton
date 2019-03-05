function linexyz = GenerateBlockInd(swcArray, xyzRes, insertDist)
swcArrayNew = InsertPointNew(swcArray, swcArray, insertDist);
temp1 = bsxfun(@rdivide, swcArrayNew, xyzRes) + 1;
temp1 = temp1(:, [2 1 3]);
linexyz = temp1;

end

