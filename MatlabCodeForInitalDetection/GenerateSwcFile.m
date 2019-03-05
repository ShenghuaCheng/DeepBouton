function GenerateSwcFile(cellStruct, xyzRes, swcname)
cellPosition = cellStruct.center(cellStruct.label == 1, :);
WriteSwc(cellPosition, xyzRes, swcname);

end

