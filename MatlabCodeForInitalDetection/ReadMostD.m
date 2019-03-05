function imgBlock = ReadMostD(pathMostD, blockInd, numBlock)
%% 从MostD中读取指定坐标的子块
%
mostDNumber = IdentifyMostDNumber(blockInd);
imgBlockB = cell(mostDNumber);
for i = 1 : mostDNumber(1)
    for j = 1 : mostDNumber(2)
        for k = 1 : mostDNumber(3)
            temp = floor((blockInd(1 : 3) - 0.1) / 512);
            temp = temp + [i-1, j-1, k-1];
            temp = ModifyBoundBlock(numBlock, temp);
            fileName = [pathMostD, '\z', num2str(temp(3)), '\y', num2str(temp(1)),  '\', num2str(temp(2)), '_', num2str(temp(1)), '_', num2str(temp(3)), '.tif'];
            imgBlockB{i, j, k} = ReadImageStack(fileName, [512 512 512]);
        end
    end
end
imgBlockB = cell2mat(imgBlockB);
offset = floor((blockInd(1 : 3) - 0.1) / 512) * 512;
temp1 = blockInd(1 : 3) - offset;
temp2 = blockInd(4 : 6) - offset;
imgBlock = imgBlockB(temp1(1) : temp2(1), temp1(2) : temp2(2), temp1(3) : temp2(3));

end

