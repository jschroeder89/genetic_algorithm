function sel = selection(sel_function, n, pop)
    if strcmp(sel_function, 'rank_base')
        sel = rank_base(pop);
    elseif strcmp(sel_function, 'elite')
        sel = elite_sel(n, pop);
    end
end