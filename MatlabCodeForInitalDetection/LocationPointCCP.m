function pointSt = LocationPointCCP(imgOrig, selectThre, thetaGauss, volumeThre, minR, localInd1, localInd2, localSize, localNum)
%imgOrig = ImgResizeSpecial(imgOrig, xyzRes);
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
    pointSt.center(t1 + 1 : t1 + t2, :) = tempPointSt.center; % bsxfun(@times, tempPointSt.center, [1 1 xyzRes(1)/xyzRes(3)]);
    pointSt.centerRe(t1 + 1 : t1 + t2, :) = tempPointSt.centerRe; % bsxfun(@times, tempPointSt.centerRe, [1 1 xyzRes(1)/xyzRes(3)]);
    pointSt.volume(t1 + 1 : t1 + t2, 1) = tempPointSt.volume;
    for j = 1 : t2
        pointSt.element{t1 + j, 1} = tempPointSt.element{j, 1}; % bsxfun(@times, tempPointSt.element{j, 1}, [1 1 xyzRes(1)/xyzRes(3)]);
    end
    pointSt.radius(t1 + 1 : t1 + t2, 1) = tempPointSt.radius;
    pointSt.label(t1 + 1 : t1 + t2, 1) = tempPointSt.label;
end
pointSt = DeleteNearPoint(pointSt, selectThre, minR);

end

