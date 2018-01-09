function z = fShekelsFuchsbauten(x,y)

a = [-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;...
    -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
    
z = 0.002;
for i=1:1:25
   
    z = z + 1 ./ (i + (x - a(1,i)).^6 + (y - a(2,i)).^6);
    
end

z = z.^-1;
    
end