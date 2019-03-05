function imgNew = SpecialProcess(img, r, eroNum1, eroThre)
temp1 = strel3dSpecialNu(2*r+1);
temp2 = convn(padarray(double(img), [r r r], 'symmetric'), temp1, 'valid');
temp3 = convn(padarray(img > 0, [r r r], 'symmetric'), temp1, 'valid');
temp3 = temp2 ./ (temp3 + 0.01);
imgNew = img > 0;
imgNew(img < temp3) = 0;
for i = 1 : eroNum1
    imgNew = ErodeImg(imgNew, eroThre);
end
imgNew = img .* imgNew;

end

