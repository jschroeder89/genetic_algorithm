function [ hamming ] = calc_hamming( Gen_coded )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : length(Gen_coded{1,1})                                          % Umwandeln von String zum Array zum Rechnen
    chrom_1{1,1}(1,i) = str2double(Gen_coded{1,1}(1,i));
    chrom_1{2,1}(1,i) = str2double(Gen_coded{2,1}(1,i));
    chrom_2{1,1}(1,i) = str2double(Gen_coded{1,2}(1,i));
    chrom_2{2,1}(1,i) = str2double(Gen_coded{2,2}(1,i));
end

for i = 1 : 2
    sum = 0;
    for j = 1 : length(chrom_1{i,1})                                   
        sum = sum + abs(chrom_1{i,1}(1,j) - chrom_2{i,1}(1,j));             % Berechnung der Hemmingdistanz für X und Y 
    end 
    hamming(i,1) = round(sum);                                              % Runden um Fehler zu vermeiden Bsp. 5.000001...
end

end

