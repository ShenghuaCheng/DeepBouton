function WriteImageSequence(img, nameFold)
n = size(img, 3);
parfor i = 1 : n
    imwrite(uint16(img(:, :, i)), [nameFold '\' num2str(i) '.tif']);
end

end

