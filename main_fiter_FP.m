clear
clc

thre = 0.3;
pathProb =  'BoutonDetectionResults\bouton_prob.mat';
pathSvBouton = 'BoutonDetectionResults';

prob = load(pathProb);
prob = prob(1).prob;
prob = prob(:,2);
bouton2d = load([pathSvBouton, '\bouton_initial_2d_xy.swc']);
bouton3d = load([pathSvBouton, '\bouton_initial_3d.swc']);

bouton2d_1 = bouton2d(prob > thre, :);
bouton3d_1 = bouton3d(prob > thre, :);
Write2Swc(bouton2d_1, [pathSvBouton, '\bouton_final_2d_xy.swc']);
Write2Swc(bouton3d_1, [pathSvBouton, '\bouton_final_3d.swc']);


