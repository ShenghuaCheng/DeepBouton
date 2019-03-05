function pointFinal = MeanShiftWeight(p, pointSet, rMeanShift, imgDest)
theta = rMeanShift / 2;
tolMeanShift = 0.01;
meanPoint = p;
for k = 1 : 100
    temp = sum(bsxfun(@minus, pointSet(:, 1 : 3), meanPoint).^2, 2);
    ind = find(temp <= rMeanShift^2);
    if isempty(ind)
        pointFinal = p;
        break;
    else
        gaussianDist = 1 / theta * exp(-0.5 * temp(ind) / theta^2);
        meanPointOld = meanPoint;
        weightDist = pointSet(ind, 4) .* gaussianDist;
        meanPoint = sum(bsxfun(@times, pointSet(ind, 1 : 3), weightDist / sum(weightDist)));
        if norm(meanPoint - meanPointOld) < tolMeanShift || k == 100
            pointFinal = meanPoint;
            break;
        end
        
    end
end
pNearest = GenerateNearestPoint(pointFinal, size(imgDest));
val = zeros(1, 8);
for ii = 1 : 8
    val(ii) = imgDest(pNearest(ii, 1), pNearest(ii, 2), pNearest(ii, 3));
end
if sum(val) == 0
    pointFinal = p;
end

end

