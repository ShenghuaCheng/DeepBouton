function imgPatch = GetPatch(rPatch, imgOrigPad, pBo, zDist, xyzRes)
wj = rPatch - zDist : rPatch + zDist;
temp1 = round(pBo([2 1 3]) ./ xyzRes + 1);
a = temp1 + rPatch - rPatch;
b = temp1 + rPatch + rPatch;
imgTemp = imgOrigPad(a(1) : b(1), a(2) : b(2), a(3) : b(3));
imgPatch = max(imgTemp(:, :, wj), [], 3);

end

