function copl = IsCoplanar(allPoints)
if size(allPoints,1) <= 3
	copl = 1;
end
rnk = rank(bsxfun(@minus, allPoints(2 : end, :), allPoints(1,:)));
copl = rnk <= size(allPoints,2) - 1;




