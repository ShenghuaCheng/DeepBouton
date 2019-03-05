function imgShape = GetImgShape(pathImg)
info = imfinfo(pathImg);
num_images = numel(info);
imgShape = [info(1).Height, info(1).Width, num_images];

end

