function blockswcNew = InsertPointNew(blockswc, entireswc, insertDist)
n = size(blockswc, 1);
blockswcNew = [];
for i = 1 : n
    p = blockswc(i, 3 : 5);
    if blockswc(i, 7) == -1
        blockswcNew = [blockswcNew; p];
        continue;
    end
    q = entireswc(blockswc(i, 7), 3 : 5);
    if norm(p - q) <= insertDist
        blockswcNew = [blockswcNew; p];
    else
        blockswcNew = [blockswcNew; p];
        vec = (q - p) / norm(q - p);
        temp = norm(q - p);
        m = floor(temp / insertDist);
        for j = 1 : m
            s = p + vec * insertDist * j;
            blockswcNew = [blockswcNew; s];
        end
    end
end
    
end

