function lineSt = DivideSWC(swcArray)
%%
%
n = size(swcArray, 1);
temp1 = find(swcArray(:, 1) - swcArray(:, 7) ~= 1);
temp2 = find(swcArray(:, 7) == -1);
m = numel(temp1);
lineSt = cell(m, 1);
i = 1;
k1 = temp1(i);
k2 = temp1(i + 1) - 1;
lineSt{i}.ind = (k1 : k2)';
for i = 1 : m - 1
    if ismember(temp1(i), temp2)
        k1 = temp1(i);
        k2 = temp1(i + 1) - 1;
        lineSt{i}.ind = (k1 : k2)';
    else
        k1 = temp1(i);
        k2 = temp1(i + 1) - 1;
        lineSt{i}.ind = [swcArray(temp1(i), 7); (k1 : k2)'];
    end
end
i = m;
if ismember(temp1(i), temp2)
    k1 = temp1(i);
    k2 = n;
    lineSt{i}.ind = (k1 : k2)';
else
    k1 = temp1(i);
    k2 = n;
    lineSt{i}.ind = [swcArray(temp1(i), 7); (k1 : k2)'];
end

lineStNew = cell(1, 1);
nn = 0;
for i = 1 : m
    temp1 = swcArray(lineSt{i}.ind, 3 : 5);
    temp2 = 0;
    for j = 1 : size(temp1, 1) - 1
        temp2 = temp2 + norm(temp1(j, :) - temp1(j + 1, :));
    end
    temp3 = ceil(temp2 / 80);
    temp4 = round(size(temp1, 1) / temp3);
    j = 1;
    nn = nn + 1;
    temp5 = lineSt{i}.ind(1 : min(j * temp4, size(temp1, 1)));
    lineStNew{nn, 1}.ind = temp5;
    for j = 2 : temp3 - 1
        nn = nn + 1;
        temp5 = lineSt{i}.ind((j - 1) * temp4 : j * temp4);
        lineStNew{nn, 1}.ind = temp5;
    end
    if temp3 >= 2
        j = temp3;
        nn = nn + 1;
        temp5 = lineSt{i}.ind((j - 1) * temp4 : size(temp1, 1));
        lineStNew{nn, 1}.ind = temp5;
    end
end

lineSt = lineStNew;

end


