function [ Gen_coded ] = uniform_crossover( Gen_coded, wkeit )

for i = 1 : length(Gen_coded{1,1})                                          % Umwandeln von String zum Array zum Rechnen
    chrom_1{1,1}(1,i) = str2double(Gen_coded{1,1}(1,i));
    chrom_1{2,1}(1,i) = str2double(Gen_coded{2,1}(1,i));
    chrom_2{1,1}(1,i) = str2double(Gen_coded{1,2}(1,i));
    chrom_2{2,1}(1,i) = str2double(Gen_coded{2,2}(1,i));
end

tmp_chrom_1 = chrom_1;                                                      % Chromosom 1 und 2 mit X und Y
tmp_chrom_2 = chrom_2;

for i = 1 : length(tmp_chrom_1{1,1})
    tmp_rand = rand(1);                                                     % Zufälliger Wert verglichen mit einer vorgegeben Wahrscheinlichkeit führt zum Crossover für jedes einzelne Bit
    if tmp_rand > wkeit
        tmp_chrom_1{1,1}(1,i) = tmp_chrom_2{1,1}(1,i);
        tmp_chrom_1{2,1}(1,i) = tmp_chrom_2{2,1}(1,i);
        tmp_chrom_2{1,1}(1,i) = chrom_1{1,1}(1,i);
        tmp_chrom_2{2,1}(1,i) = chrom_1{2,1}(1,i);
    end
end    

for i = 1 : length(Gen_coded{1,1})                                          % Umwandeln der Chromosom Arrays in Strings
    tmp_Gen_coded{1,1}(1,i) = num2str(tmp_chrom_1{1,1}(1,i));
    tmp_Gen_coded{2,1}(1,i) = num2str(tmp_chrom_1{2,1}(1,i));
    tmp_Gen_coded{1,2}(1,i) = num2str(tmp_chrom_2{1,1}(1,i));
    tmp_Gen_coded{2,2}(1,i) = num2str(tmp_chrom_2{2,1}(1,i));
end

Gen_coded = tmp_Gen_coded;

end

