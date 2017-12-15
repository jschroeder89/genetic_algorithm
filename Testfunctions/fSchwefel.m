function Z = fSchwefel(X,Y)

    Z1 = -X.*sin(sqrt(abs(X)));
    Z2 = -Y.*sin(sqrt(abs(Y)));

    Z = Z1+Z2;
        
end