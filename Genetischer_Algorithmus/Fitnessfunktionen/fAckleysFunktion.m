function z = fAckleysFunktion(x,y)

z = 20 + exp(1) - 20 * exp(-0.2 * sqrt((1/2) .* (x.^2 + y.^2) )) - exp((1/2) .* (cos(2*pi.*x) + cos(2*pi.*y) ));

end