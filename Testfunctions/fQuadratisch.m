function z = fQuadratisch(xi)
    
    n = length(xi);
    
    z=0;
    for i=1:1:n
    
        z = z + xi(i).^2;
    
    end

end