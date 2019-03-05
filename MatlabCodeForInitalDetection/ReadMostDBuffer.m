function imgBlock = ReadMostDBuffer(pathMostD, blockInd, numBlock)
mostDNumber = IdentifyMostDNumber(blockInd);
imgBlockB = cell(mostDNumber);
for i = 1 : mostDNumber(1)
    for j = 1 : mostDNumber(2)
        for k = 1 : mostDNumber(3)
            temp = floor((blockInd(1 : 3) - 0.1) / 512);
            temp = temp + [i-1, j-1, k-1];
            temp = ModifyBoundBlock(numBlock, temp);
            [imgBlockBTemp, flag] = ImgBufferQuery(temp);
            if flag == 1
                imgBlockB{i, j, k} = imgBlockBTemp;
                fileName = [pathMostD, '\z', num2str(temp(3)), '\y', num2str(temp(1)),  '\', num2str(temp(2)), '_', num2str(temp(1)), '_', num2str(temp(3)), '.tif'];
                disp(['Reading ', fileName, ' from imgBuffer']);
            else
                fileName = [pathMostD, '\z', num2str(temp(3)), '\y', num2str(temp(1)),  '\', num2str(temp(2)), '_', num2str(temp(1)), '_', num2str(temp(3)), '.tif'];
                if sum(GetImgShape(fileName) == [512 512 512]) == 3
                    imgBlockB{i, j, k} = ReadImageStack(fileName, [512 512 512]);
                else
                    fileName = [pathMostD, '\z', num2str(temp(3)), '\y', num2str(temp(1)),  '\', num2str(temp(2)), '_', num2str(temp(1)), '_', num2str(temp(3)), '_bak.tif'];
                    imgBlockB{i, j, k} = ReadImageStack(fileName, [512 512 512]);
                end
                disp(['Reading ', fileName, ' from disk']);
                ImgBufferUpdate(imgBlockB{i, j, k}, temp);
            end
        end
    end
end
imgBlockB = cell2mat(imgBlockB);
offset = floor((blockInd(1 : 3) - 0.1) / 512) * 512;
temp1 = int32(blockInd(1 : 3) - offset);
temp2 = int32(blockInd(4 : 6) - offset);
imgBlock = imgBlockB(temp1(1) : temp2(1), temp1(2) : temp2(2), temp1(3) : temp2(3));

end

