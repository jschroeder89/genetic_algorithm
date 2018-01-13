function [Population_new] = Mutation(Population_old, mut_w, Methode)

%% Default-Werte

if ~exist('cro_w','var') mut_w = 1; end
if ~exist('methode','var') Methode = 'two_wk'; end

%% Je nach Methode die Wahrscheinlichkeiten setzen

if strcmp(Methode,'two_wk') 
    
    %Wahrscheinlichkeit, dass ein Bit mutiert/invertiert wird
    wkeit = 0.3;
    
elseif strcmp(Methode,'one_wk') 
    
    %Wahrscheinlichkeit, dass ein Bit mutiert/invertiert wird
    wkeit = mut_w;
    %Wahrscheinlichkeit, dass überhaupt bei dieser Generation mutiert wird
    mut_w = 1;
    
end
    
%% Mutation Durchführung

if rand(1) <= mut_w

    %% Einstellungen
    
    
    %Anzahl der Chromosomen, die mutiert werden sollen
    n_mut = 2;

    
    %% Chromosomen-Auswahl
    
    rand_num = unique(randi([1 size(Population_old,2)], 1, n_mut));
    %Vermeidung, dass ein Chromosomen doppelt ausgewählt wird
    while size(rand_num,2) ~= n_mut                                         
        rand_num = unique(randi([1 size(Population_old,2)], 1, n_mut));
    end
    
    %Speichern der Ausgewählten Chromosomen
    for i = 1 : length(rand_num)                                        
        tmp_Gen_coded{1,i} = Population_old{1,rand_num(i)};
        tmp_Gen_coded{2,i} = Population_old{2,rand_num(i)};
    end
    
    
    %% Mutations-Algorithmus
    for c = 1: size(tmp_Gen_coded,2)                                 
        for j = 1 : size(tmp_Gen_coded,1)                                                 % Auswahl X, Y
            for i = 1 : length(tmp_Gen_coded{j,c})                                        % Inhalt von X bzw. Y
                tmp_rand = rand(1);
                if tmp_rand > wkeit                                                     % Wahrscheinlichkeitsüberprüfung mit der zufällig erstellten Zahl für jedes Bit
                   if strcmp(tmp_Gen_coded{j,c}(1,i),'1') 
                       tmp_Gen_coded{j,c}(1,i) = '0';
                   else
                       tmp_Gen_coded{j,c}(1,i) = '1';
                   end
                end
            end
        end
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



