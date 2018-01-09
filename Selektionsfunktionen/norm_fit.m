function norm_fitness = norm(pop)
    fitness = pop(3,:);
    min_fitness = abs(min(fitness));
    for i = 1:length(fitness)
        norm_fitness(i) = fitness(i) + min_fitness + 1;
    end
    sum_norm_fit = sum(norm_fitness);
    for i = 1:length(fitness)
        norm_fitness(i) = (norm_fitness(i)/sum_norm_fit) 
    end
end