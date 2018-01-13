function sel = selection(sel_function, n, pop)
    switch sel_function
    case 'rank_base'
        sel = rank_base(pop);
    case 'elite'
        sel = elite_sel(n, pop);
    end
end