function imgOrig = ReadImageSequence(nameFold)
files = dir(fullfile(nameFold, '*.tif'));
temp = struct2cell(files);
temp1 = temp(1, :);
[~, indname] = SortNat(temp1);
files = files(indname);
lengthFiles = length(files);
imgTemp = imread([nameFold files(1).name]);
imgOrig = zeros([size(imgTemp, 1), size(imgTemp, 2), lengthFiles], 'uint16');
temp = whos('imgOrig');
if temp.bytes / 10^9 > 7
    for i = 1 : lengthFiles
        imgOrig(:, :, i) = imread([nameFold files(i).name]);
    end
else
    parfor i = 1 : lengthFiles
        imgOrig(:, :, i) = imread([nameFold files(i).name]);
    end
end

end

