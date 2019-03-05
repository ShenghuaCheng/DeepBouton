function blockLinexyzNew = InsertPoint(blockLinexyz, insertDist)
n = size(blockLinexyz, 1);
blockLinexyzNew = [];
for i = 1 : n - 1
    p = blockLinexyz(i, :);
    q = blockLinexyz(i + 1, :);
    if norm(p - q) <= insertDist
        blockLinexyzNew = [blockLinexyzNew; p];
    else
        blockLinexyzNew = [blockLinexyzNew; p];
        vec = (q - p) / norm(q - p);
        temp = norm(q - p);
        m = floor(temp / insertDist);
        for j = 1 : m
            s = p + vec * insertDist * j;
            blockLinexyzNew = [blockLinexyzNew; s];
        end
    end
end
blockLinexyzNew = [blockLinexyzNew; blockLinexyz(n, :)];   
end

