function boutonStW = MergeBoutonSt(boutonStTotal, selectThre, minR)
n = size(boutonStTotal, 1);
boutonStW = boutonStTotal{1};
for i = 2 : n
    tempPointSt = boutonStTotal{i};
    if isempty(tempPointSt)
        continue;
    end
    t1 = size(boutonStW.center, 1);
    t2 = size(tempPointSt.center, 1);
    boutonStW.center(t1 + 1 : t1 + t2, :) = tempPointSt.center;
    boutonStW.centerRe(t1 + 1 : t1 + t2, :) = tempPointSt.centerRe;
    boutonStW.volume(t1 + 1 : t1 + t2, 1) = tempPointSt.volume;
    boutonStW.element(t1 + 1 : t1 + t2, 1) = tempPointSt.element;
    boutonStW.radius(t1 + 1 : t1 + t2, 1) = tempPointSt.radius;
    boutonStW.label(t1 + 1 : t1 + t2, 1) = tempPointSt.label;
    boutonStW.sample(t1 + 1 : t1 + t2, 1) = tempPointSt.sample;
end
boutonStW = DeleteNearPoint(boutonStW, selectThre, minR);

end

