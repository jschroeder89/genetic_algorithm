function best = elite_selek(n, pop)
    
    fitness = pop(3,:);
    fit_sorted = sort(fitness, 'descend')
    for i = 1:n
        best(i) = fit_sorted(i);
    end
end