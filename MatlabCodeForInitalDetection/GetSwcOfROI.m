function [swcArrayROI, label] = GetSwcOfROI(swcArray, boxIndROI, xyzRes)
pt = bsxfun(@rdivide, swcArray(:, [4 3 5]), xyzRes) + 1;
swcArray = swcArray(pt(:, 1) >= boxIndROI(1) & pt(:, 1) <= boxIndROI(4) & pt(:, 2) >= boxIndROI(2) & pt(:, 2) <= boxIndROI(5) & pt(:, 3) >= boxIndROI(3) & pt(:, 3) <= boxIndROI(6), :);
if isempty(swcArray)
    swcArrayROI = [1 1 0 0 boxIndROI(3)-1 1 -1]; 
    label = 0;
else
    n = size(swcArray, 1);
    temp1 = swcArray;
    swcArray(:, 1) = 1 : n;
    for i = 1 : n
        temp2 = find(temp1(i, 7) == temp1(:, 1));
        if isempty(temp2)
            swcArray(i, 7) = -1;
        else
            swcArray(i, 7) = swcArray(temp2, 1);
        end
    end
    swcArrayROI = swcArray;
    label = 1;
end

end

