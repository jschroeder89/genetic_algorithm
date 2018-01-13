function [norm_fitness key] = norm(fitness)
    %fitness = pop(3,:);
    min_fitness = abs(min(fitness));
    key = min_fitness;
    for i = 1:length(fitness)
        norm_fitness(i) = fitness(i) + min_fitness + 1;
    end
    sum_norm_fit = sum(norm_fitness);
    for i = 1:length(fitness)
        norm_fitness(i) = (norm_fitness(i)/sum_norm_fit); 
    end
    %norm_fitness(length(fitness) + 1) = key;
end