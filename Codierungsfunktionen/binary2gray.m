function [gray_pop] = gray_coding(pop)
    popsize = length(pop(1,:));
    nbits = length(pop(1,1));
    for j = 1:2        
        for i = 1:popsize
            C = pop(i,j);
            if class(C) == 'cell'
                C = char(C);
            end

            nbits = length(C);
            C = bin2dec(C);

            mask = bitshift(C, -1);
            C = dec2bin(C, nbits);
            mask = dec2bin(mask, nbits);

            for i = 1:nbits
                Cg = str2num(C(i));
                mask_g = str2num(mask(i));
                gray_coded(i) = num2str(xor(Cg, mask_g));
            end
            gray_pop(i, j) = gray_coded;
        end
    end
end