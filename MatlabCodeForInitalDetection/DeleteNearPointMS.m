function pointSt = DeleteNearPointMS(pointSt, minDistMS)
temp1 = find(pointSt(:, 4) == 1);
for i = 1 : numel(temp1)
    for j = i + 1 : numel(temp1)
        if norm(pointSt(temp1(i), 1 : 3) - pointSt(temp1(j), 1 : 3)) < minDistMS
            pointSt(temp1(j), 4) = -3;
        end
    end
end


end

