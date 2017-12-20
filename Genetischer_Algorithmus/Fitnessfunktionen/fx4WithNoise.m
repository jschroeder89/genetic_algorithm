function z = fx4WithNoise(x,y)
    
    sigma = 10;
    m = 0;
    noise = sigma.*randn(length(x),length(y)) + m;

    z = x.^4 +  2*y.^4 + noise;
    
end