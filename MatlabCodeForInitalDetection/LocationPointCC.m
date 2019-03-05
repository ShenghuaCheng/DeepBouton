function pointStruct = LocationPointCC(imgOrig, tempPixelList, thetaGauss, volumeThre, minR, selectThre, localInd1, localInd2, localSize, localNum)
pointStruct.center = [0 0 0];
pointStruct.centerRe = [0 0 0];
pointStruct.volume = 0;
pointStruct.element{1, 1} = zeros(3, 3);
pointStruct.radius = 0;
pointStruct.label = 0;
if size(tempPixelList, 1) >= volumeThre && IsCoplanar(tempPixelList) == 0
    [initialInd, connectedCImg] = ExtractMinBox(tempPixelList, imgOrig);
    pointStruct = LocationPoint(connectedCImg, thetaGauss, volumeThre, pointStruct, initialInd, minR, selectThre, localInd1, localInd2, localSize, localNum);  %在每个连通域上定位point
else
    numPoint = size(pointStruct.center, 1);
    pointStruct.center(numPoint + 1, :) = [0 0 0];
    pointStruct.centerRe(numPoint + 1, :) = [0 0 0];
    pointStruct.volume(numPoint + 1, 1) = 0;
    pointStruct.element{numPoint + 1, 1} = zeros(3, 3);
    pointStruct.radius(numPoint + 1, 1) = 0;
    pointStruct.label(numPoint + 1, 1) = -2;
end

end

