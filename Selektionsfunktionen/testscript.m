%%
clc;
close all;
clear all;

%%
pop = [2.3 3.0 1.6 -2.5 0.6 0.8 1.9;
    -2.8 3.0 0.5 2.4 2.3 -1.7 -1.9;
    3.0458 5.6387 2.4957 -2.7573 4.9273 -1.5867 1.2875]; %Test population

fit_norm = [0.1 0.2 0.25 0.05 0.05 0.35];
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
norm_fit(pop)


