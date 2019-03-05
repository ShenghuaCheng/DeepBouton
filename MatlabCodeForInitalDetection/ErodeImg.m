function eroImg = ErodeImg(binImg, eroIntesity)
tempTemplate = ones(3, 3, 3, 'uint16');
tempImg = convn(padarray(binImg, [1 1 1], 'symmetric'), tempTemplate, 'valid');
eroImg = uint16(tempImg > eroIntesity & binImg);


