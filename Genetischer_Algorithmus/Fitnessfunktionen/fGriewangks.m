function z = fGriewangks(x,y)

    z = 1 + (x.^2 ./ 4000) + (y.^2 ./ 4000) - cos(x ./ sqrt(1)) .* cos(y ./ sqrt(2));

end