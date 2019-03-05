function line = Tree2Line(tree)
ind1 = find(tree(:,7) + 1 ~= tree(:, 1));
ind2 = tree(ind1, 7);
ind3 = ind1 - 1;
ind3 = ind3(ind3 > 0);

n = size(ind3, 1);
line = cell(n, 1);
for i = 1 :n
    a = ind3(i);
    p1 = ind3(i);
    p2 = tree(tree(p1, 7));
    a = [a;p2];
    while sum(p2 == ind1) == 0 && p2 ~= -1
        p1 = p2;
        p2 = tree(p1, 7);
        a = [a;p2];
    end
    p1 = p2;
    p2 = tree(p1, 7);
    if p2 ~= -1
        a = [a;p2];
    end
    line{i} = a;
end

b = zeros(size(tree, 1)*2, 7);
nn = 0;
for i = 1 : n
    a = line{i};
    m = size(a,1);
    
    b0 = zeros(m, 7);
    b0(:, 1) = nn+1 : nn+m;
    b0(:,2) = i;
    b0(:,3:5) = tree(a, 3:5);
    b0(2:m,7) = nn+1 : nn+m-1;
    b0(1, 7) = -1;    
    b(nn+1:nn+m, :) = b0;
    
%     for j = 1 :m
%         b(nn+j, 1) = nn+j;
%         b(nn+j, 2) = i;
%         b(nn+j, 3:5) = tree(a(j), 3:5);
%         if j == 1
%             b(nn+j,7) = -1;
%         else
%             b(nn+j,7) = nn+j-1;
%         end
%     end

    nn = nn + m;
end

b = b(b(:,1)> 0, :); 
line = b;
    
    
end

