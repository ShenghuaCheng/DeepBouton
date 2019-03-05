function pointSt = DeleteNearPoint(pointSt, selectThre, minR)
temp1 = find(pointSt.label == 1);
[~, temp2] = sort(pointSt.volume(temp1), 'descend');
for i = 1 : numel(temp1)
    for j = i + 1 : numel(temp1)
        if norm(pointSt.center(temp1(temp2(i)), :) - pointSt.center(temp1(temp2(j)), :)) < selectThre * minR
            pointSt.label(temp1(temp2(j)), 1) = -3;
        end
    end
end

end

