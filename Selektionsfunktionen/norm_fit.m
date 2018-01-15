function [norm_fitness] = norm(dpop)
    popsize = length(dpop);
    max_fitness = abs(max(dpop)) + 1;
    for i = 1:popsize
        fit_norm(i) = max_fitness - dpop(i);
    end
    sum_norm_fit = sum(fit_norm);
    norm_fitness = fit_norm./sum_norm_fit;
end