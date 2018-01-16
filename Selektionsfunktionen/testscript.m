%%
clc;
close all;
clear all;
%parpool('local', 4);
%%
%pop(1,:) = random('unif',-4,4,1,10);
%pop(2,:) = random('unif',-4,4,1,10);
%pop(3,:) = random('unif',-4,4,1,10);
addpath('../Codierungsfunktionen');
addpath('../Genetischer_Algorithmus');
%pop_coded = binary_coding(pop, 4, -4, 4, -4);

%%Testing
%fit_vec = zeros(size(a));
%rang_base(pop);

%for i = 1:1000
%    fit_vec(i) = roulette_prinzip(fit_norm);
%end
fitness = [0.05 0.05 0.1 0.2 0.35 0.1 0.1 0.05]
[sel pos] = roulette(fitness)
%x = histc(fit_vec, sort(fit_norm));
%explode = [1 1 1 1 1 1];
%pie(x, explode);
%elite_selekt(2, pop);
%rang_base(pop);
tic
%parfor i = 1:20
 %   GeneticAlgorithm
%end
toc
%prop_selection(pop_coded)
%selection('rank_base', pop_cell);
%delete(gcp('nocreate'));


