%%
clc;
close all;
clear all;

%%
pop(1,:) = random('unif',-4,4,1,10);
pop(2,:) = random('unif',-4,4,1,10);
pop(3,:) = random('unif',-4,4,1,10);

addpath('../Codierungsfunktionen');
pop_coded = binary_coding(pop, 4, -4, 4, -4);

%%Testing
%fit_vec = zeros(size(a));
%rang_base(pop);

%for i = 1:1000
%    fit_vec(i) = roulette_prinzip(fit_norm);
%end

%x = histc(fit_vec, sort(fit_norm));
%explode = [1 1 1 1 1 1];
%pie(x, explode);
%elite_selekt(2, pop);
%rang_base(pop);
prop_selection(pop_coded)
%selection('rank_base', pop_cell);



