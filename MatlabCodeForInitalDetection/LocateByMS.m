function boutonStMS = LocateByMS(img, offset, volumeThreMS, rFindMax, ra, rMenshiftBox, rMeanShift, minDistMS)
offset = offset(1 : 3);
maxInd = FindMaximum3D(img, rFindMax, ra);
boutonStMS = zeros(size(maxInd, 1), 4);
parfor i = 1 : size(maxInd, 1)
    p = maxInd(i, :);
    pointSet = GeneratePointSet(img, p, rMenshiftBox);
    pointFinal = MeanShiftWeight(p, pointSet, rMeanShift, img);
    boutonStMS(i, :) = [pointFinal size(pointSet, 1) >= volumeThreMS];
end
boutonStMS = DeleteNearPointMS(boutonStMS, minDistMS);
boutonStMS(:, 1 : 3) = bsxfun(@plus, boutonStMS(:, 1 : 3), offset);

end

