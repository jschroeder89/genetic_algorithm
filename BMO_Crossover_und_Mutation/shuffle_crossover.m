function [ Gen_coded ] = shuffle_crossover( Gen_coded )

for i = 1 : length(Gen_coded{1,1})                                          % Umwandeln von String zum Array zum Rechnen
    chrom_1{1,1}(1,i) = str2double(Gen_coded{1,1}(1,i));
    chrom_1{2,1}(1,i) = str2double(Gen_coded{2,1}(1,i));
    chrom_2{1,1}(1,i) = str2double(Gen_coded{1,2}(1,i));
    chrom_2{2,1}(1,i) = str2double(Gen_coded{2,2}(1,i));
end

tmp_chrom_1 = chrom_1;                                                      % Chromosom 1 und 2
tmp_chrom_2 = chrom_2;

tmp_arr = [1 : length(Gen_coded{1,1})];                                     % Feststellung der Anzahl der Bits des Chromosoms

tmp_arr = tmp_arr(randperm(length(tmp_arr)));                               % Abhängig von der Länge der Bits wird ein mischen der Reihenfolge durchgeführt

for i = 1 : length(tmp_arr)                                                 % Ordnung des Chromosomens nach der zufällig erstellten neuen Reihenfolge
    tmp_chrom_1{1,1}(1,i) = chrom_1{1,1}(1,tmp_arr(i));                     % BSP: 1,2,3,4,5 -> 2,1,5,3,4
    tmp_chrom_1{2,1}(1,i) = chrom_1{2,1}(1,tmp_arr(i));
    tmp_chrom_2{1,1}(1,i) = chrom_2{1,1}(1,tmp_arr(i));
    tmp_chrom_2{2,1}(1,i) = chrom_2{2,1}(1,tmp_arr(i));
end

for i = 1 : length(Gen_coded{1,1})                                          % Zurückwandeln in einen String
    tmp_Gen_coded{1,1}(1,i) = num2str(tmp_chrom_1{1,1}(1,i));
    tmp_Gen_coded{2,1}(1,i) = num2str(tmp_chrom_1{2,1}(1,i));
    tmp_Gen_coded{1,2}(1,i) = num2str(tmp_chrom_2{1,1}(1,i));
    tmp_Gen_coded{2,2}(1,i) = num2str(tmp_chrom_2{2,1}(1,i));
end

[ tmp_Gen_coded ] = n_point_crossover(tmp_Gen_coded, 1);                    % Übergabe an n-Point Crossover

tmp_chrom_1{1,1} = zeros(1,length(tmp_Gen_coded{1,1}));                     % Initialisierung auf 0
tmp_chrom_1{2,1} = zeros(1,length(tmp_Gen_coded{1,1})); 
tmp_chrom_2{1,1} = zeros(1,length(tmp_Gen_coded{1,1})); 
tmp_chrom_2{2,1} = zeros(1,length(tmp_Gen_coded{1,1}));

for i = 1 : length(Gen_coded{1,1})                                          % Umwandeln des Strings in einen Array
    chrom_1{1,1}(1,i) = str2double(tmp_Gen_coded{1,1}(1,i));                
    chrom_1{2,1}(1,i) = str2double(tmp_Gen_coded{2,1}(1,i));
    chrom_2{1,1}(1,i) = str2double(tmp_Gen_coded{1,2}(1,i));
    chrom_2{2,1}(1,i) = str2double(tmp_Gen_coded{2,2}(1,i));
end

for i = 1 : length(tmp_arr)                                                 % Die alte Reihenfolge wird wiederhergestellt
    tmp_chrom_1{1,1}(1,tmp_arr(i)) = chrom_1{1,1}(1,i);                     % BSP: 2,1,5,3,4 -> 1,2,3,4,5
    tmp_chrom_1{2,1}(1,tmp_arr(i)) = chrom_1{2,1}(1,i);
    tmp_chrom_2{1,1}(1,tmp_arr(i)) = chrom_2{1,1}(1,i);
    tmp_chrom_2{2,1}(1,tmp_arr(i)) = chrom_2{2,1}(1,i);
end

tmp_Gen_coded = [];                                                          
for i = 1 : length(Gen_coded{1,1})                                          % Umwandlung Array in String
    tmp_Gen_coded{1,1}(1,i) = num2str(tmp_chrom_1{1,1}(1,i));
    tmp_Gen_coded{2,1}(1,i) = num2str(tmp_chrom_1{2,1}(1,i));
    tmp_Gen_coded{1,2}(1,i) = num2str(tmp_chrom_2{1,1}(1,i));
    tmp_Gen_coded{2,2}(1,i) = num2str(tmp_chrom_2{2,1}(1,i));
end

Gen_coded = tmp_Gen_coded;

end

