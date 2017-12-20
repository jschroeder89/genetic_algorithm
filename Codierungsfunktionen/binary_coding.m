function [Gen_coded] = binary_conding(Gen, xmax, xmin, ymax, ymin)
%%Init
Gen_coded = cell(size(Gen));
Sx = abs(xmin) + abs(xmax);
Sy = abs(ymin) + abs(ymax);
gitsize = get_gitsize(Sx);
maxbits = length(dec2bin(gitsize));

%%Coding of Generation Gen 
for i = 1:size(Gen(1,:), 2)
    Cxg = (Gen(1, i) + xmax)/Sx*gitsize;
    Cyg = (Gen(2, i) + ymax)/Sy*gitsize;
    Cxb = dec2bin(Cxg, maxbits);
    Cyb = dec2bin(Cyg, maxbits);
    Gen_coded(1, i) = cellstr(Cxb);
    Gen_coded(2, i) = cellstr(Cyb);
end

end