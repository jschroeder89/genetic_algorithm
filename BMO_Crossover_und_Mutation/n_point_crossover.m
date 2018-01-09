function [ Gen_coded ] = n_point_crossover( Gen_coded, n )

for i = 1 : length(Gen_coded{1,1})                                          % Umwandeln von String zum Array zum Rechnen
    chrom_1{1,1}(1,i) = str2double(Gen_coded{1,1}(1,i));
    chrom_1{2,1}(1,i) = str2double(Gen_coded{2,1}(1,i));
    chrom_2{1,1}(1,i) = str2double(Gen_coded{1,2}(1,i));
    chrom_2{2,1}(1,i) = str2double(Gen_coded{2,2}(1,i));
end

tmp_chrom_1 = chrom_1;                                                      % Umgewandelte Chromosomen 1 und 2 mit x und y Werten
tmp_chrom_2 = chrom_2;

rand_number = unique(randi([1 17],1,n));                                    % Setzen von n Schnittpunkten beim Crossover
while length(rand_number) ~= n                                              % Keine doppelten Schnittpunkte und das Erreichen von n wird mit dieser Schleife generiert
   rand_number = unique(randi([1 17],1,n));
end

k = 1;

while k <= length(rand_number) 
    
    tmp_rand_number = rand_number(k);
    
    if mod(k,2) == 1                                                         % Tausch der Chromosomen findet immer nur bei ungeraden Zahlen statt
        if k < length(rand_number)   
            tmp_chrom_1{1,1}(1,[tmp_rand_number : rand_number(k+1)-1]) = tmp_chrom_2{1,1}(1,[tmp_rand_number : rand_number(k+1)-1]);
            tmp_chrom_1{2,1}(1,[tmp_rand_number : rand_number(k+1)-1]) = tmp_chrom_2{2,1}(1,[tmp_rand_number : rand_number(k+1)-1]);
            tmp_chrom_2{1,1}(1,[tmp_rand_number : rand_number(k+1)-1]) = chrom_1{1,1}(1,[tmp_rand_number : rand_number(k+1)-1]);
            tmp_chrom_2{2,1}(1,[tmp_rand_number : rand_number(k+1)-1]) = chrom_1{2,1}(1,[tmp_rand_number : rand_number(k+1)-1]);
        else
            tmp_chrom_1{1,1}(1,[tmp_rand_number : end]) = tmp_chrom_2{1,1}(1,[tmp_rand_number : end]);
            tmp_chrom_1{2,1}(1,[tmp_rand_number : end]) = tmp_chrom_2{2,1}(1,[tmp_rand_number : end]);
            tmp_chrom_2{1,1}(1,[tmp_rand_number : end]) = chrom_1{1,1}(1,[tmp_rand_number : end]);
            tmp_chrom_2{2,1}(1,[tmp_rand_number : end]) = chrom_1{2,1}(1,[tmp_rand_number : end]);

        end
    end
    
    k = k + 1;
    
end

for i = 1 : length(Gen_coded{1,1})                                          % Zurückwandeln in einen String
    tmp_Gen_coded{1,1}(1,i) = num2str(tmp_chrom_1{1,1}(1,i));
    tmp_Gen_coded{2,1}(1,i) = num2str(tmp_chrom_1{2,1}(1,i));
    tmp_Gen_coded{1,2}(1,i) = num2str(tmp_chrom_2{1,1}(1,i));
    tmp_Gen_coded{2,2}(1,i) = num2str(tmp_chrom_2{2,1}(1,i));
end

Gen_coded = tmp_Gen_coded;

end

