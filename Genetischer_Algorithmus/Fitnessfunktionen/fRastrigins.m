function z = fRastrigins(x,y)

    A = 10;
    z = 2*A + (x.^2 - A*cos(2*pi*x)) + (y.^2 - A*cos(2*pi*y));

end