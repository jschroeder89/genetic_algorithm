function [fitness] = fitness_prop(pop)
%%
fitness = pop(3,:);
fitness_min = min(fitness);
sum_fitness = sum(fitness)

if fitness_min < 0
    for i = 1:length(fitness)
        fitness_norm(i) = fitness(i) + abs(fitness_min);
    end
    sum_fitness = sum(fitness_norm)
end


end