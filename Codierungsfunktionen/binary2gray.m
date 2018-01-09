function [gray_pop] = binary2gray(pop)
    popsize = length(pop(1,:));
    nbits = length(pop(1,1));
    gray_pop = pop;
    for j = 1:2        
        for i = 1:popsize
            C = pop(j,i);
            if class(C) == 'cell'
                C = char(C);
            end

            nbits = length(C);
            C = bin2dec(C);

            mask = bitshift(C, -1);
            C = dec2bin(C, nbits);
            mask = dec2bin(mask, nbits);

            for k = 1:nbits
                Cg = str2num(C(k));
                mask_g = str2num(mask(k));
                gray_coded(k) = num2str(xor(Cg, mask_g));
            end
            gray_pop(j, i) = cellstr(gray_coded);
        end
    end
end