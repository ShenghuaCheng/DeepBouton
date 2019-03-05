function imgRe = ImgResize3DDown(imgOrig, sizeXYVoxel, sizeZVoxel)
n = size(imgOrig, 3);
temp = imresize(imgOrig(:, :, 1), sizeXYVoxel/sizeZVoxel);
imgRe = zeros([size(temp) n], 'uint16');
imgRe(:, :, 1) = temp;
parfor i = 2 : n
    imgRe(:, :, i) = imresize(imgOrig(:, :, i), sizeXYVoxel/sizeZVoxel)
end

end

