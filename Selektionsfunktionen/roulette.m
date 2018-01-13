function [sel pos] = roulette(fitness)
    fit_sum = sum(fitness);
    r = random('unif', 0, 1);
    val = fitness(1);
    pos = 1;
    for i = 2:length(fitness)
        if r <= val
            sel = fitness(i-1);
            pos = i-1;
            break;
        end
        val = fitness(i-1) + fitness(i);
        if r >= val
            sel = fitness(i);  
            pos = i;
        end
    end
end