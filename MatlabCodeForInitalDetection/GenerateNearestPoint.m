function pNearest = GenerateNearestPoint(p, imgSizeTotal)
temp1 = floor(p);
temp2 = ceil(p);
pNearest = zeros(8, 3);
pNearest(1, :) = ModifyBoundPoint(imgSizeTotal, [temp1(1) temp1(2) temp1(3)]);
pNearest(2, :) = ModifyBoundPoint(imgSizeTotal, [temp1(1) temp1(2) temp2(3)]);
pNearest(3, :) = ModifyBoundPoint(imgSizeTotal, [temp1(1) temp2(2) temp1(3)]);
pNearest(4, :) = ModifyBoundPoint(imgSizeTotal, [temp1(1) temp2(2) temp2(3)]);
pNearest(5, :) = ModifyBoundPoint(imgSizeTotal, [temp2(1) temp1(2) temp1(3)]);
pNearest(6, :) = ModifyBoundPoint(imgSizeTotal, [temp2(1) temp1(2) temp2(3)]);
pNearest(7, :) = ModifyBoundPoint(imgSizeTotal, [temp2(1) temp2(2) temp1(3)]);
pNearest(8, :) = ModifyBoundPoint(imgSizeTotal, [temp2(1) temp2(2) temp2(3)]);

end

