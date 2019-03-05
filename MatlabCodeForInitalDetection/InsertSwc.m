function swcArrayNew = InsertSwc(swcArray, insetDist)
n = size(swcArray, 1);
swcArrayNew = [];
for i = 1 : n
    if swcArray(i, 7) == -1
        temp1 = size(swcArrayNew, 1);
        swcArrayNew(temp1 + 1, 1) = temp1 + 1;
        swcArrayNew(temp1 + 1, 2 : 7) = swcArray(i, 2 : 7);
        swcArrayNew(temp1 + 1, 8) = i;
    else
        temp1 = size(swcArrayNew, 1);
        p = swcArray(i, 3 : 5);
        q = swcArray(swcArray(i, 7), 3 : 5);
        if norm(p - q) <= insetDist
            swcArrayNew(temp1 + 1, 1) = temp1 + 1;
            swcArrayNew(temp1 + 1, 2 : 6) = swcArray(i, 2 : 6);
            swcArrayNew(temp1 + 1, 7) = find(swcArrayNew(1 : temp1, 8) == swcArray(i, 7));
            swcArrayNew(temp1 + 1, 8) = i;
        else
            vec = (p - q) / norm(p - q);
            temp2 = norm(p - q);
            m = ceil(temp2 / insetDist) - 1;
            s = q + vec * insetDist;
            swcArrayNew(temp1 + 1, 1) = temp1 + 1;
            swcArrayNew(temp1 + 1, 2) = 4;
            swcArrayNew(temp1 + 1, 3 : 5) = s;
            swcArrayNew(temp1 + 1, 6) = swcArray(i, 6);
            swcArrayNew(temp1 + 1, 7) = find(swcArrayNew(1 : temp1, 8) == swcArray(i, 7));
            swcArrayNew(temp1 + 1, 8) = 0;
            for j = 2 : m
                s = q + vec * insetDist * j;
                swcArrayNew(temp1 + j, 1) = temp1 + j;
                swcArrayNew(temp1 + j, 2) = 4;
                swcArrayNew(temp1 + j, 3 : 5) = s;
                swcArrayNew(temp1 + j, 6) = swcArray(i, 6);
                swcArrayNew(temp1 + j, 7) = temp1 + j - 1;
                swcArrayNew(temp1 + j, 8) = 0;
            end
            swcArrayNew(temp1 + m + 1, 1) = temp1 + m + 1;
            swcArrayNew(temp1 + m + 1, 2 : 6) = swcArray(i, 2 : 6);
            swcArrayNew(temp1 + m + 1, 7) = temp1 + m;
            swcArrayNew(temp1 + m + 1, 8) = i;
        end
    end
end

for i = 1 : size(swcArrayNew, 1)
    wj = i;
    while swcArrayNew(wj, 8) == 0
        wj = wj - 1;
    end
    swcArrayNew(i, 8) = swcArrayNew(wj, 8);
end

end

