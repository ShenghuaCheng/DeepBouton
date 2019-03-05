function [alph, beta] = MinDistLocal(i, rhoInd, sizeImg, yxzInd, rhoIndNew, localInd1, localInd2, rhoPadded, localSize)
    tempWj1 = (localSize - 1) / 2;
    tempWj2 = (localSize + 1) / 2;
    temp1 = yxzInd(:, rhoInd(rhoIndNew(i))) + [tempWj1 tempWj1 tempWj1]';
    temp2 = rhoPadded(temp1(1) - tempWj1 : temp1(1) + tempWj1, temp1(2) - tempWj1 : temp1(2) + tempWj1, temp1(3) - tempWj1 : temp1(3) + tempWj1);
    temp3 = temp2 >= temp2(tempWj2, tempWj2, tempWj2);
    if sum(temp3(:)) == 1
        alph = 0.5;
        beta = 0;
    else
        [temp4, temp5] = min(localInd2(temp3));
        temp7 = localInd1(temp3);
        temp5 = temp7(temp5);
        alph = temp4 / norm(sizeImg - 1);
        [beta1, beta2, beta3] = ind2sub([localSize localSize localSize], temp5);
        temp6 = [beta1, beta2, beta3]' + yxzInd(:, rhoInd(rhoIndNew(i))) - [tempWj2 tempWj2 tempWj2]';
        beta = sub2ind(sizeImg, temp6(1), temp6(2), temp6(3));
    end
end

