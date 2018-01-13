function sel = selection(sel_function, pop)
    switch sel_function
    case 'rank_base'
        sel = rank_base(pop);
    end
end