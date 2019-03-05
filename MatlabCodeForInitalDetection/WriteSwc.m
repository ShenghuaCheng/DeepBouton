function WriteSwc(A, xyzRes, nameSwc)
if isempty(A) == 0
    A = bsxfun(@times, (A - 1), xyzRes);
    n = size(A, 1);
    B = ones(n, 7);
    B(:, 1) = 1 : n;
    B(:, 7) = -1;
    B(:, [4 3 5]) = A;
    Write2Swc(B, nameSwc);
end

end

