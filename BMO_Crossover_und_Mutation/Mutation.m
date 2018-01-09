function [ Gen_coded ] = Mutation( Gen_coded, m )

rand_num = randi([1 2],1,1);                                                % Zuf�llige Auswahl eines Chromosoms f�r die Mutation
chrom_1{1,1} = Gen_coded{1,rand_num}(1,:);                                  % X
chrom_1{2,1} = Gen_coded{2,rand_num}(1,:);                                  % Y

for j = 1 : length(chrom_1)                                                 % Auswahl X, Y
    for i = 1 : length(chrom_1{j,1})                                        % Inhalt von X bzw. Y
        tmp_rand = rand(1);
        if tmp_rand > m                                                     % Wahrscheinlichkeits�berpr�fung mit der zuf�llig erstellten Zahl f�r jedes Bit
           if strcmp(chrom_1{j,1}(1,i),'1') 
               chrom_1{j,1}(1,i) = '0';
           else
               chrom_1{j,1}(1,i) = '1';
           end
        end
    end
end

Gen_coded{1,rand_num} = chrom_1{1,1};                                       % Abspeichern der neuen Werte f�r X und Y und �bergabe
Gen_coded{2,rand_num} = chrom_1{2,1};



