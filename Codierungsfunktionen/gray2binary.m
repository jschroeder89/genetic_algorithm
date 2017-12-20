function [binary_coded] = gray2binary(Cg)

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

end