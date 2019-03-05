function imgPatch = GenerateBoutonPatchAdaptiveMostD(swcAx, pBo, rPatch, imgOrigO)
n = size(swcAx, 1);
vecT = zeros(n - 1, 3);
for i = 1 : n - 1
    v = swcAx(i, 3 : 5) - swcAx(i + 1, 3 : 5);
    v = v / norm(v);
    vecT(i, :) = v;
end
vMain = mean(vecT, 1);
vMain = vMain / norm(vMain);
if norm([vMain(1) vMain(2) 0]) <= 0.5
    imgPatch = GetPatchMostD(rPatch, imgOrigO, pBo, 5);
elseif norm([vMain(1) vMain(2) 0]) > 0.5 && norm([vMain(1) vMain(2) 0]) <= 0.2588
    imgPatch = GetPatchMostD(rPatch, imgOrigO, pBo, 7);
else
    imgPatch = GetPatchMostD(rPatch, imgOrigO, pBo, 7);
end

end



