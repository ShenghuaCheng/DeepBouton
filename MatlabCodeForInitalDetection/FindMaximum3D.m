function maxInd = FindMaximum3D(img, r, ra)
img = double(img);
temp1 = strel3dSpecial(2*r+1);
temp1_1 = strel3dSpecialNu(2*r+1);
temp2 = imdilate(img, temp1);
temp3 = convn(padarray(img, [r r r], 'symmetric'), temp1_1, 'valid');
temp4 = convn(padarray(img > 0, [r r r], 'symmetric'), temp1_1, 'valid');
temp3 = (temp3 ./ temp4 + 0.01);
imgMax = img > temp2 & (img - temp3) ./ (temp3 + 0.1) > ra;
maxInd = find(imgMax == 1);
[w1, w2, w3] = ind2sub(size(img), maxInd);
maxInd = [w1 w2 w3];

end

