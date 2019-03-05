clear
clc

%%
%
pathMostD = 'X:\TDIEa001\level1_data';
numBlock = [96 60 16]; % y x z
pathSwc = 'D:\MyMatlabFiles\DeepBoutonForPaper\Data\PyramidalCellWholeAxon.swc';
pathSave = 'D:\MyMatlabFiles\DeepBoutonForPaper\Bouton1';
xyzRes = [0.2 0.2 1];

%%
%
binThre = 3; 
eroThre = 4;
eroNum = 3;
sizeVoxel = xyzRes(1);
minR = 1.5; % voxel
averR = 3; % voxel
selectThre = 2;%2
r = [8 8 4];%[7 7 5]
insertDist = 0.5;
rPatch = 30;
volumeThre = 0.2 * pi/6 * (2*minR + 1)^3;
thetaGauss = averR / 2;
localSize = round(averR*2) * 2 + 1;
localNum = localSize^3;
localInd1 = reshape(1 : localSize^3, [localSize, localSize, localSize]);
localInd2 = zeros(localSize, localSize, localSize);
for i = 1 : localSize
    for j = 1 : localSize
        for k = 1 : localSize
            localInd2(i, j, k) = norm([i j k] - [(localSize + 1)/2 (localSize + 1)/2 (localSize + 1)/2]);
        end
    end
end
localInd2((localSize + 1)/2, (localSize + 1)/2, (localSize + 1)/2) = 2 * localSize;
global imgBufferGb
bufferNum = 25;
imgBufferGb = ImgBufferInitial(bufferNum);
    
%%
%
swcArray = load(pathSwc);
lineSt = DivideSWC(swcArray);
n = size(lineSt, 1);
boutonStTotal = cell(n, 1);
imgTotal = cell(n, 1);

for i = 1 : n % 
    disp(['i = ', num2str(i), ' ...... ', num2str(n)]);
    temp = swcArray(lineSt{i}.ind, :);
    temp(:, 1) = 1 : size(temp, 1);
    temp(:, 7) = 0 : size(temp, 1) - 1;
    temp(1, 7) = -1;
    linexyz = GenerateBlockInd(temp, xyzRes, insertDist);
    [imgBlock, imgBlockSP, imgPrj, offset] = ReadBlockDataMostD(pathMostD, numBlock, linexyz, r, binThre, eroThre, eroNum, swcArray, xyzRes);
    imgTotal{i}.imgPrj = imgPrj;
    imgTotal{i}.offset = offset;
    boutonStTotal{i} = LocationPointCCPMostD(imgBlock, imgBlockSP, temp, rPatch, offset, selectThre, thetaGauss, volumeThre, minR, localInd1, localInd2, localSize, localNum);
end
boutonStW = MergeBoutonSt(boutonStTotal, selectThre/2, minR); %
[imgPrj, offset] = MergeImg(imgTotal);
temp1 = boutonStW.label;
temp2 = boutonStW.center;
temp5 = boutonStW.sample;
temp5 = temp5(temp1 == 1, :);
temp3 = temp2(temp1 == 1, :);
temp4 = temp3;
temp4(:, 3) = 1;

WriteSwc(temp3, xyzRes, [pathSave, '\bouton_initial_3d.swc']);
WriteSwc(temp4, xyzRes, [pathSave, '\bouton_initial_2d_xy.swc']);
temp6 = swcArray;
temp6(:, 5) = 0;
Write2Swc(swcArray, [pathSave, '\axon_3d.swc']);
Write2Swc(temp6, [pathSave, '\axon_2d_xy.swc']);
sampleTotal = zeros(61, 61, sum(temp1 == 1));
jj = 0;
for i = 1 : size(temp1, 1)
    if temp1(i) == 1
        jj = jj + 1;
        sampleTotal(:, :, jj) = temp5{jj};
    end
end
WriteImageStack(imgPrj, [pathSave, '\img_extracted_xy.tif']);
Write2txt(offset, [pathSave, '\img_offset.txt']);
Write2txt(offset(end:-1:1)*xyzRes(1), [pathSave, '\img_offset_amira.txt']);
save([pathSave, '\bouton_patches.mat'], 'sampleTotal', '-v7.3')

