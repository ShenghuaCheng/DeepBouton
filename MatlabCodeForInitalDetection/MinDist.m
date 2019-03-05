function [alph, beta] = MinDist(i, rhoInd, sizeImg, yxzInd, rhoIndNew)
    tempVar = bsxfun(@minus, yxzInd(:, rhoInd(rhoIndNew(1 : i-1))), yxzInd(:, rhoInd(rhoIndNew(i))));
    [alph, tempVar1] = min(sqrt(sum(tempVar.^2)) / norm(sizeImg - 1));
    beta = rhoInd(rhoIndNew(tempVar1));
end


