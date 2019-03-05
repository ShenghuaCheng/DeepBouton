function swc2t3 = Find3DPoint(swc2d, swc3d)

% swc = load('E:\\DATA\\DeepBouton\\Bouton data\\4900\\007LYR 5201 31755 4900.swc');
% swcNew = InsertSwc(swc, 0.2);
% Write2Swc(swcNew, 'E:\\DATA\\DeepBouton\\Bouton data\\4900\\insert.swc')

swc2d = load('E:\DATA\DeepBouton\Bouton data\4200\type4.swc');
swc3d = load('E:\DATA\DeepBouton\Bouton data\4200\insert.swc');
n = size(swc2d, 1);
ff = @(p) sum(bsxfun(@minus, swc2d(p, 3:4), swc3d(:,3:4)).^2, 2);
distArray = arrayfun(ff, 1:n, 'UniformOutput', 0);
distArray = cell2mat(distArray);

[temp, ind] = min(distArray, [], 1);

swc2t3 = swc3d(ind, :);
swc2t3(:,7) = -1;
swc2t3(:,2) = 1;
swc2t3(:,1) = 1:n;

swc2t3_1 = swc2t3;
swc2t3_1(:,5) = 0;

swc2t3_2 = swc2t3;
swc2t3_2(:,3:4) = swc2d(:,3:4);

Write2Swc(swc2t3, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type4_3d.swc')
Write2Swc(swc2t3_1, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type4_3d_1.swc')
Write2Swc(swc2t3_2, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type4_3d_2.swc')

end

