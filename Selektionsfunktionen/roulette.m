function [sel pos] = roulette(fitness)
    fit_sum = sum(fitness);
    r = random('unif', 0, 1);
    val = fitness(1);
    pos = 1;
    sel = 0;
    for i = 2:length(fitness)
        if r < val
            sel = fitness(i-1);
            pos = i-1;
            break;
        else
            val = fitness(i) + val;
        end
        if val == 1
            sel = fitness(length(fitness));
            pos = i;
        end
    end
end