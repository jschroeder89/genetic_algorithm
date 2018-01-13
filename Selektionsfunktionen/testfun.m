function selected = testfun(pop)
    popsize = length(pop(3,:));
    c = pop(3,1);
    for i = 1:popsize
        pop(3, i) = cell2mat(pop(3,i));
    end
    [fit_sorted original_pos] = sort(pop(3,:), 'descend');    
    ranks(1,:) = [1:1:popsize];
    ranks(2,:) = original_pos;
    sum_ranks = sum(ranks(1,:)); 
    ranked_fit = ranks(1,:)./sum_ranks;
    for i = 1:popsize
        [sel pos] = roulette(ranked_fit);
        selected(1:2, i) = pop(1:2, pos);
        selected(3,i) = {pop(3, pos)}; 
    end
    sel
end