function gitsize = get_gitsize(Sx)

if Sx <= 10
    gitsize = 1e5;
elseif Sx <= 100
    gitsize = 1e6;
elseif Sx > 100
    gitsize = 1e7;
end

end