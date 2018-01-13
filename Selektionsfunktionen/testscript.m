%%
clc;
close all;
clear all;

%%
pop = [2.3 3.0 1.6 -2.5 0.6 0.8 1.9;
    -2.8 3.0 0.5 2.4 2.3 -1.7 -1.9;
    3.0458 5.6387 2.4957 -2.7573 4.9273 -1.5867 1.2875]; %Test population
for i = 1:length(pop(:,1))
    for j = 1:length(pop(1,:))
        pop_cell(i,j) = {pop(i,j)};
    end    
end
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
pop_cell;
selection('rank_base', pop_cell);



