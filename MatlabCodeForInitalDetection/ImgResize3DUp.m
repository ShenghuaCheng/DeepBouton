function imgRe = ImgResize3DUp(imgOrig, sizeXYVoxel, sizeZVoxel)
%% 对Z向进行插值
%
e = size(imgOrig);
scaleZ = round(sizeZVoxel / sizeXYVoxel);
[x, y, z] = ndgrid(1 : 1 : e(1), 1 : 1 : e(2), 1 : scaleZ : e(3) * scaleZ);
[x1, y1, z1] = ndgrid(1 : 1 : e(1), 1 : 1 : e(2), 1 : 1 : e(3) * scaleZ);
imgRe = interpn(x, y, z, double(imgOrig), x1, y1, z1, 'spline');
imgRe = uint16(imgRe);

end

