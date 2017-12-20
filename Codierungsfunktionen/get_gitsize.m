function gittersize = get_gittersize(Sx)

if Sx <= 10
    gittersize = 1e5;
elseif Sx <= 100
    gittersize = 1e6;
elseif Sx > 100
    gittersize = 1e7;
end

end