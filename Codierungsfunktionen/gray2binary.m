function [binary_pop] = gray2binary(Cg)
popsize = length(pop(1,:));
nbits = length(pop(1,1));
    for j = 1:2
        for i = 1:popsize
            Cg = pop(j, i);
            if class(Cg) == 'cell'
                Cg = char(Cg);
            end

            nbits = length(Cg);
            binary_coded(1) = Cg(1);

            for k = 2:nbits
                Cgray = str2num(Cg(k));
                Cbin = str2num(binary_coded(k-1));   
                binary_coded(k) = num2str(xor(Cgray, Cbin)); 
            end
            binary_pop(j,i) = binary_coded;         
        end
    end
end