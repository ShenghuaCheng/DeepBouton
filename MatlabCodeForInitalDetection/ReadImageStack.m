function img = ReadImageStack(pathImg, sizeImg)
%%=========================================================================
%% ¶ÁÈ¡Ò»¸östack
%
img = zeros(sizeImg, 'uint16');
parfor i = 1 : sizeImg(3)
    img(:, :, i) = imread(pathImg, i);
end
