function [branchBoxInd, offset] = GetBranchBoxInd(swcBranch, xyzRes)
temp1 = bsxfun(@rdivide, swcBranch(:, [4 3 5]), xyzRes) + 1; 
temp2 = min(temp1, [], 1);
temp3 = max(temp1, [], 1);
branchBoxInd = [temp2 - 40 temp3 + 40];
offset = temp2 - 40 - 1;

end

