function [sel pos] = roulette_prinzip(fitness)
    %fit_sorted = sort(pop, 'ascend');
    %fitness = pop(3,:);
    fit_sum = sum(fitness);
    r = rand(fit_sum);
    val = pop(1);
    for i = 2:length(fitness)
        if r <= val
            sel = fitness(i-1);
            break;
        end
        val = fitness(i-1) + fitness(i);
        if r >= val
            sel = fitness(i);  
        end
    end
end