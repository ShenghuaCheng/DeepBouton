function GenerateExcelFile(cellStruct, xyzRes, localizationResultPath)
fileName = [localizationResultPath, '\', 'cellLocated.xlsx'];
cellPosition = cellStruct.centerRe(cellStruct.label == 1, :);
cellPosition = bsxfun(@times, cellPosition(:, [2 1 3]) - 1, xyzRes);
cellVolume = cellStruct.volume(cellStruct.label == 1, :);
cellRadius = cellStruct.radius(cellStruct.label == 1, :);
n = size(cellRadius, 1);
infoCellLocated = cell(n + 1, 5);
infoTitle = {'cellPostionX', 'cellPositionY', 'cellPositionY', 'cellVolume', 'cellRadius'};
infoValue = [cellPosition, cellVolume, cellRadius];
infoCellLocated(1, :) = infoTitle;
infoCellLocated(2 : end, :) = num2cell(infoValue);
xlswrite(fileName, infoCellLocated);

end

