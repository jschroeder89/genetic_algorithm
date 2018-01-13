function selected = elite_sel(n, pop)
    popsize = length(pop(3,:));
    dpop = str2double(pop(3,:));
    percent = round(popsize*n);
    for i = 1:popsize
        for j = 1:percent
            r = randi(popsize);
            tournament(1,j) = r;
            tournament(2,j) = dpop(r); 
        end
        [winner pos] = min(tournament(2,:));
        selected(1:3, i) = pop(1:3, tournament(1,pos));
    end
end