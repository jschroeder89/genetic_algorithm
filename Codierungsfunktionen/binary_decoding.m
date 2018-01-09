function [Gen_decoded] = binary_decoding(Gen_coded, xmax, xmin, ymax, ymin)
%%Init
Gen_decoded = zeros(size(Gen_coded));
Sx = abs(xmin) + abs(xmax);
Sy = abs(ymin) + abs(ymax);
gitsize = get_gitsize(Sx);
maxbits = length(dec2bin(gitsize));

for i = 1:size(Gen_coded(1,:), 2)
    Cx = char(Gen_coded(1, i)); 
    Cy = char(Gen_coded(2, i));
    Cx = (bin2dec(Cx)/gitsize * Sx) - xmax;
    Cy = (bin2dec(Cy)/gitsize * Sy) - ymax;
    Gen_decoded(1, i) = Cx;
    Gen_decoded(2, i) = Cy;
end

for i = 1:length(Gen_decoded(3,:))
    Gen_decoded(3, i) = str2double(Gen_coded(3, i));
end

end