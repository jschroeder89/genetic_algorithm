function [Population_next] = Rekombination(Population_cur, Children, popsize, elite, random)

% Aufruf:           [Population_new] = Rekombination(Population_old, Children, popsize, elite)
% Population_cur:   Aktuellle Poulation
% Children:         Veränderte Population (mit Selektion, Cross-Over,
%                   Mutation)
% popsize:          Größe der Anfangspopulation Default: 10
% elite:            Anzahl der besten Individuen, welche aus der aktuellen
%                   Population in die nächste übernommen weren sollen
%                   Default:1
% random:           [0,1] zufällige Auswahl aus der Children Generation für
%                   die nächste Generation ein/ausschalten. Default: 0
%
% [Population_next]: Neue Generation
    
if ~exist('popsize','var') popsize = 10; end
if ~exist('elite','var') elite = 1; end
if ~exist('random','var') random = 0; end
    
    %Sortiere aktuelle Generation nach Größe der letzten Zeile (Fitnesswerte) von klein nach
    %groß
    [~,idx] = sort(Population_cur(3,:)); 
    Population_cur = Population_cur(:,idx);   
    
    %Die Chromosomen mit bester Fitness aufjedenfall übernehmen in die
    %nächste
    Population_next = Population_cur(:,1:elite);
    
    %Restlichen Chromosomen aus Veränderter Population (Children) wählen
    %Methode1: Zufällig aus Children Individuen
    %Methode2: besten der Children Individuen
    if random == 1
        random_vek = rand(1,popsize);
        [~,idx] = sort(random_vek(:),'descend'); 
        Children = Children(:,idx);
    else
        [~,idx] = sort(Children(3,:)); 
        Children = Children(:,idx);  
    end
    Population_next = horzcat(Population_next, Children(:,1:popsize-elite));   
end