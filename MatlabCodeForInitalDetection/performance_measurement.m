%% performance measurement
%
clear
clc

r = 1.2;

boutonAI = load('D:\LYR-Checked.swc');%part_1.swc
%boutonAI = load('D:\part_1.swc');%part_1.swc
%boutonAI = load('D:\GalaBestW1.4.swc');%part_1.swc
%boutonAI = load('D:\BassBest.swc');%part_1.swc
boutonMA = load('D:\GTc.swc');%part_1.swc
%boutonMA = load('D:\GTcF.swc');
MISS = [];
PAIR = [];
PAIRED = [];
n = size(boutonMA, 1);
m = size(boutonAI, 1);
t2 = boutonAI(:, 3 : 4);
for i = 1 : n
    t1 = boutonMA(i, 3 : 4);
    t3 = bsxfun(@minus, t2, t1);
    t4 = sqrt(sum(t3.^2, 2));
    t4(PAIRED) = 2 * r;
    t5 = t4 <= r;
    if sum(t5) == 0
        MISS = [MISS; i];
    else
        PAIR = [PAIR; i];
        [~, t6] = min(t4);
        PAIRED = [PAIRED; t6];
    end
end
accuracy = numel(PAIR) / m;
recall = numel(PAIR) / n;
F1 = 2 * accuracy * recall / (accuracy + recall);
    


