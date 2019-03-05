function [ output_args ] = FindNegPoints()
swc1 = load('E:\\DATA\\DeepBouton\\Bouton data\\4200\\type1_3d.swc');
swc1(:,2) = 1;
swc2 = load('E:\\DATA\\DeepBouton\\Bouton data\\4200\\type2_3d.swc');
swc2(:,2) = 2;
swc3 = load('E:\\DATA\\DeepBouton\\Bouton data\\4200\\type3_3d.swc');
swc3(:,2) = 3;
swcp = load('E:\\DATA\\DeepBouton\\Bouton data\\4200\\img\\bouton.swc');

swc = [swc1;swc2;swc3];
swc(:,1) = 1 : size(swc,1);

n = size(swc, 1);
ff = @(p) sum(bsxfun(@minus, swc(p, 3:5), swcp(:,3:5)).^2, 2);
distArray = arrayfun(ff, 1:n, 'UniformOutput', 0);
distArray = cell2mat(distArray);

[temp, ind] = min(distArray, [], 1);

swcne = swcp(setdiff(1:size(swcp,1),ind), :);
Write2Swc(swcne, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type_ne.swc')
swcne_1 = swcne;
swcne_1(:,5) = 0;
Write2Swc(swcne_1, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type_ne_2d.swc')
Write2Swc(swc, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type_po.swc')
swc_1 = swc;
swc_1(:,5) = 0;
Write2Swc(swc_1, 'E:\\DATA\\DeepBouton\\Bouton data\\4200\\type_po_2d.swc')

end

