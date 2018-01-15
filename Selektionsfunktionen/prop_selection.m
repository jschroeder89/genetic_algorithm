function seleceted = prop_selection(pop)
    popsize = length(pop(3,:));
    dpop = str2double(pop(3,:));
    norm_fitness = norm_fit(dpop);
    for i = 1:popsize
        [sel pos] = roulette(norm_fitness);
        sel, pos
        seleceted(1:3, i) = pop(1:3, pos);
    end
end