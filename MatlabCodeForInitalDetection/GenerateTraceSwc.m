function GenerateTraceSwc(pointTrace, xyzRes, name)
A = ones(size(pointTrace, 1), 7);
A(:, 1) = 1 : size(pointTrace, 1);
A(:, [4 3 5]) = bsxfun(@times, pointTrace - 1, xyzRes);
A(:, 7) = 0 : size(pointTrace, 1)- 1;
A(1, 7) = -1;
Write2Swc(A, name);


end

