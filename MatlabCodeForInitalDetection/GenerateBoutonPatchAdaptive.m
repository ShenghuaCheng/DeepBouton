function imgPatch = GenerateBoutonPatchAdaptive(swcAxIns, d, pBo, rPatch, xyzRes, imgOrigPad)
temp1 = sum(bsxfun(@minus, swcAxIns(:, 3 : 5), pBo).^2, 2);
[temp2, temp3] = min(temp1);
n = size(swcAxIns, 1);
if temp2 < d^2
    indLast = temp3;
    indNext = swcAxIns(indLast, 7);
    v = swcAxIns(indLast, 3 : 5) - swcAxIns(indNext, 3 : 5);
    v = v / norm(v);
    w1 = 1;
    vecT = v;
    %pT = [swcAxIns(indLast, 3 : 5); swcAxIns(indNext, 3 : 5)];
    while indNext ~= -1 && w1 <= 25
        v = swcAxIns(indLast, 3 : 5) - swcAxIns(indNext, 3 : 5);
        v = v / norm(v);
        w1 = w1 + 1;
        vecT = [vecT; v];
        %pT = [pT; swcAxIns(indNext, 3 : 5)];
        indLast = indNext;
        indNext = swcAxIns(indLast, 7);
    end
    indLast = temp3;
    indNext = indLast + 1;
    v = swcAxIns(indNext, 3 : 5) - swcAxIns(indLast, 3 : 5);
    v = v / norm(v);
    w1 = 1;
    vecT = [vecT; v];
    %pT = [pT; swcAxIns(indNext, 3 : 5)];
    while indNext <= n && swcAxIns(indNext, 7) == indLast && w1 <= 25
        v = swcAxIns(indNext, 3 : 5) - swcAxIns(indLast, 3 : 5);
        v = v / norm(v);
        w1 = w1 + 1;
        vecT = [vecT; v];
        %pT = [pT; swcAxIns(indNext, 3 : 5)];
        indLast = indNext;
        indNext = indLast + 1;
    end
    
    vMain = mean(vecT, 1);
    vMain = vMain / norm(vMain);
    if norm([vMain(1) vMain(2) 0]) <= 0.5
        imgPatch = GetPatch(rPatch, imgOrigPad, pBo, 5, xyzRes);
    elseif norm([vMain(1) vMain(2) 0]) > 0.5 && norm([vMain(1) vMain(2) 0]) <= 0.2588
        imgPatch = GetPatch(rPatch, imgOrigPad, pBo, 7, xyzRes);
    else
        imgPatch = GetPatch(rPatch, imgOrigPad, pBo, 7, xyzRes);
    end
else
    imgPatch = GetPatch(rPatch, imgOrigPad, pBo, 7, xyzRes);
end

end

