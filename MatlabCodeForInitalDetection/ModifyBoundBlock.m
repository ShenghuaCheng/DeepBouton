function blockIndNew = ModifyBoundBlock(numBlock, blockInd)
blockIndNew = zeros(1, 3);
numBlock = numBlock - 1;
blockIndNew(1) = min(blockInd(1), numBlock(1));
blockIndNew(2) = min(blockInd(2), numBlock(2));
blockIndNew(3) = min(blockInd(3), numBlock(3));

end

