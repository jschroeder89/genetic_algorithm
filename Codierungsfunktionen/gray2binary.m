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

            for i = 2:nbits
                Cgray = str2num(Cg(i));
                Cbin = str2num(binary_coded(i-1));   
                binary_coded(i) = num2str(xor(Cgray, Cbin)); 
            end
            binary_pop(j,i) = binary_coded;         
        end
    end
end