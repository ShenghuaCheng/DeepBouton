function img = ReadTiff(pathImg)
info = imfinfo(pathImg);
num_images = numel(info);
img = zeros([info(1).Height, info(1).Width, num_images], 'uint16');
parfor k = 1 : num_images
    img(:, :, k) = imread(pathImg, k);
end

end

