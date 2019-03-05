function pointNew = ModifyBoundPoint(imgSize, point)
pointNew = zeros(1, 3);
pointNew(1) = min(max(point(1), 1), imgSize(1));
pointNew(2) = min(max(point(2), 1), imgSize(2));
pointNew(3) = min(max(point(3), 1), imgSize(3));

end

