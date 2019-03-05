function swcArray = MergeSwc(filepath, dist, branchNum)
swcArray = load([filepath '\axon.swc']);
for i = 1 : branchNum
    temp1 = load([filepath '\b' num2str(i) '.swc']);
    temp2 = temp1(1, 3 : 5);
    if min(sum(bsxfun(@minus, swcArray(:, 3 : 5), temp2).^2, 2)) > dist^2
        disp('error!!');
        continue;
    else
        [~, temp3] = min(sum(bsxfun(@minus, swcArray(:, 3 : 5), temp2).^2, 2));
        temp4 = temp1;
        temp1(1, 7) = temp3;
        temp1(1 : size(temp4, 1), 1) = size(swcArray, 1) + 1 : size(swcArray, 1) + size(temp4, 1);
        for j = 2 : size(temp4, 1)
            if temp4(j, 7) ~= -1
                temp1(j, 7) = temp1(temp4(j, 7), 1);
            else
                temp1(j, 7) = -1;
            end
        end
        swcArray = [swcArray; temp1];
    end
end

end

