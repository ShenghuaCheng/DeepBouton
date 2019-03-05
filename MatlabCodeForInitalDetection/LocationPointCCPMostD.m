function pointSt = LocationPointCCPMostD(imgOrig, imgOrigO, swcAx, rPatch, offset, selectThre, thetaGauss, volumeThre, minR, localInd1, localInd2, localSize, localNum)
connectedComp = bwconncomp(imgOrig > 0, 6);
numObjects = connectedComp.NumObjects;
connectedCompInd = regionprops(connectedComp, 'PixelList');
pointStructTotal = cell(numObjects, 1);
initialIndTotal = cell(numObjects, 1);
connectedCImgTotal = cell(numObjects, 1);
for i = 1 : numObjects
    tempPixelList = connectedCompInd(i).PixelList(:, [2 1 3]);
    if size(tempPixelList, 1) >= volumeThre && IsCoplanar(tempPixelList) == 0
        [initialInd, connectedCImg] = ExtractMinBox(tempPixelList, imgOrig);
        initialIndTotal{i} = initialInd;
        connectedCImgTotal{i} = connectedCImg;
    end
end
parfor i = 1 : numObjects
    tempPixelList = connectedCompInd(i).PixelList(:, [2 1 3]);
    tempPointStruct = LocationPointCCSp(initialIndTotal{i}, connectedCImgTotal{i}, tempPixelList, thetaGauss, volumeThre, minR, selectThre, localInd1, localInd2, localSize, localNum);
    pointStructTotal{i} = tempPointStruct;
    disp([num2str(i), '/', num2str(numObjects), 'with ', num2str(size(tempPixelList, 1)), ' points', '......', num2str(sum(tempPointStruct.label == 1))]);
end

pointSt.center = [0 0 0];
pointSt.centerRe = [0 0 0];
pointSt.volume = 0;
pointSt.element{1, 1} = zeros(3, 3);
pointSt.radius = 0;
pointSt.label = 0;
for i = 1 : numObjects
    tempPointSt = pointStructTotal{i};
    t1 = size(pointSt.center, 1);
    t2 = size(tempPointSt.center, 1);
    pointSt.center(t1 + 1 : t1 + t2, :) = bsxfun(@plus, tempPointSt.center, offset);
    pointSt.centerRe(t1 + 1 : t1 + t2, :) = bsxfun(@plus, tempPointSt.centerRe, offset);
    pointSt.volume(t1 + 1 : t1 + t2, 1) = tempPointSt.volume;
    for j = 1 : t2
        pointSt.element{t1 + j, 1} = bsxfun(@plus, tempPointSt.element{j, 1}, offset);
    end
    pointSt.radius(t1 + 1 : t1 + t2, 1) = tempPointSt.radius;
    pointSt.label(t1 + 1 : t1 + t2, 1) = tempPointSt.label;
end
pointSt = DeleteNearPoint(pointSt, selectThre, minR);

for i = 1 : size(pointSt.label, 1)
    if pointSt.label(i) == 1
        pBo = pointSt.center(i, :) - offset;
        imgPatch = GenerateBoutonPatchAdaptiveMostD(swcAx, pBo, rPatch, imgOrigO);
        pointSt.sample{i, 1} = imgPatch;
    else
        pointSt.sample{i, 1} = [];
    end
end

end

