function z = fx4WithNoise(x,y)
    
    sigma = 20;
    m = 0;
    noise = sigma.*randn(200,200) + m;

    z = x.^4 +  2.*y.^4 + noise;
    
end