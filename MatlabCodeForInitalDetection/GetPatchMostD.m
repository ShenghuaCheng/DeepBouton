function imgPatch = GetPatchMostD(rPatch, imgOrig, pBo, zDist)
temp1 = round(pBo);
a = temp1 - rPatch;
b = temp1 + rPatch;
imgTemp = imgOrig(a(1) : b(1), a(2) : b(2), temp1(3) - zDist : temp1(3) + zDist);
imgPatch = max(imgTemp, [], 3);

end

