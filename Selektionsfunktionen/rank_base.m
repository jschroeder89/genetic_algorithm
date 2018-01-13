function selected = rank_base(pop)
    popsize = length(pop(3,:));
    dpop(3,:) = cell2mat(pop(3,:));
    [fit_sorted original_pos] = sort(dpop(3,:), 'descend');    
    ranks(1,:) = [1:1:popsize];
    ranks(2,:) = original_pos;
    sum_ranks = sum(ranks(1,:)); 
    ranked_fit = ranks(1,:)./sum_ranks;
    for i = 1:popsize
        [sel pos] = roulette(ranked_fit);
        selected(1:3, i) = pop(1:3, original_pos(pos));  
    end
end