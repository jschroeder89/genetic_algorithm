function [Population_new] = CrossOver(Population_old, Methode, cro_w)

%% Default-Werte

if ~exist('Methode','var') Methode = 'n_point_crossover'; end
if ~exist('cro_w','var') cro_w = 1; end


%% Cross-Over Durchführung?

if rand(1) <= cro_w 
    

    %% Einstellungen

    n = 1;
    wkeit = 0.5;


    %% Chromosomen-Auswahl
    hamming = zeros(2,1);                                                   % Zum Start der Hammingfunktion wird auf 0 gesetzt

    while norm(hamming - zeros(2,1)) < 0.00001                              % Hammingdistanz zwischen den Chromosomen muss größer 0 sein

        rand_num = unique(randi([1 size(Population_old,2)],1,2));
        while size(rand_num,2) ~= 2                                         % Vermeidung, dass ein Chromosomen doppelt ausgewählt wird
              rand_num = unique(randi([1 size(Population_old,2)],1,2));
        end

        for i = 1 : length(rand_num)                                        % Speichern der Ausgewählten Chromosomen
            tmp_Gen_coded{1,i} = Population_old{1,rand_num(i)};
            tmp_Gen_coded{2,i} = Population_old{2,rand_num(i)};
        end

        [ hamming ] = calc_hamming(tmp_Gen_coded);                          % Überprüfung der Hammingdistanz der ausgewählten Chromosomen

    end


    %% Cross-Over Algorithmus

    switch(Methode)
        case 'n_point_crossover'
            [tmp_Gen_coded] = n_point_crossover(tmp_Gen_coded, n); 

        case 'uniform_crossover'
            [tmp_Gen_coded] = uniform_crossover(tmp_Gen_coded, wkeit);

        case 'shuffle_crossover'
            [tmp_Gen_coded] = shuffle_crossover(tmp_Gen_coded);
    end

    
    %% Neue Population nach Cross-Over bilden
    
    Population_new = Population_old;
    for i = 1 : length(rand_num)                                            % Die ausgewählten Chromosomen werden ersetzt durch die veränderten Chromosomen im Crossover und der Mutation
        Population_new{1,rand_num(i)} = tmp_Gen_coded{1,i}; 
        Population_new{2,rand_num(i)} = tmp_Gen_coded{2,i};
    end

    
else
    Population_new = Population_old;
end

end