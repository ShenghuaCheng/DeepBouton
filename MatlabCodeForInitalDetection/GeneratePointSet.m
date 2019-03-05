function pointSet = GeneratePointSet(img, p, rMenshiftBox)
imgSize = size(img);
temp1 = ModifyBoundPoint(imgSize, p - rMenshiftBox);
temp2 = ModifyBoundPoint(imgSize, p + rMenshiftBox);
temp3 = img(temp1(1) : temp2(1), temp1(2) : temp2(2), temp1(3) : temp2(3));
offset = temp1 - 1;
temp4 = find(temp3 > 0);
[w1, w2, w3] = ind2sub(size(temp3), temp4);
temp5 = bsxfun(@plus, [w1 w2 w3], offset);
temp6 = sub2ind(imgSize, temp5(:, 1), temp5(:, 2), temp5(:, 3));
pointSet = [temp5 temp6];

end

