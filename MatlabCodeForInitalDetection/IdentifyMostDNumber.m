function mostDNumber = IdentifyMostDNumber(blockInd)
wj = floor((blockInd(1 : 3) - 0.1) / 512) * 512 + 512;
if blockInd(4) <= wj(1)
    t1 = 1;
else
    t1 = ceil((blockInd(4) - wj(1)) / 512) + 1;
end

if blockInd(5) <= wj(2)
    t2 = 1;
else
    t2 = ceil((blockInd(5) - wj(2)) / 512) + 1;
end

if blockInd(6) <= wj(3)
    t3 = 1;
else
    t3 = ceil((blockInd(6) - wj(3)) / 512) + 1;
end

mostDNumber = [t1 t2 t3];

end

