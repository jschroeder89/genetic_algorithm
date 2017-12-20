function [Population_next] = Rekombination(Population_cur, Children, popsize, method, nelite, random)

% Aufruf:           [Population_new] = Rekombination(Population_old, Children, popsize, elite)
% Population_cur:   Aktuellle Poulation
% Children:         Ver�nderte Population (mit Selektion, Cross-Over,
%                   Mutation)
% popsize:          Gr��e der Anfangspopulation Default: 10
% method:           String: 1)'no_elite' , 2) 'elite' Default: 'elite'
% elite:            Anzahl der besten Individuen, welche aus der aktuellen
%                   Population in die n�chste �bernommen weren sollen
%                   Default:1
% random:           [0,1] zuf�llige Auswahl aus der Children Generation f�r
%                   die n�chste Generation ein/ausschalten. Default: 0
%
% [Population_next]: Neue Generation
    
if ~exist('popsize','var') popsize = 10; end
if ~exist('method','var') method = 'elite'; end
if ~exist('elite','var') nelite = 1; end
if ~exist('random','var') random = 0; end

if strcmp(method,'no_elite') == 0 && strcmp(method,'elite') == 0
   method = 'no_elite'; 
end
    
    if strcmp(method,'elite') 
        
        %Sortiere aktuelle Generation nach Gr��e der letzten Zeile (Fitnesswerte) von klein nach
        %gro�
        [~,idx] = sort(Population_cur(3,:)); 
        Population_cur = Population_cur(:,idx);   

        %Die Chromosomen mit bester Fitness aufjedenfall �bernehmen in die
        %n�chste Population
        Population_next = Population_cur(:,1:nelite);

        %Restlichen Chromosomen aus Ver�nderter Population (Children) w�hlen
        %Methode1: Zuf�llig aus Children Individuen
        %Methode2: besten der Children Individuen
        if random == 1
            random_vek = rand(1,popsize);
            [~,idx] = sort(random_vek(:),'descend'); 
            Children = Children(:,idx);
        else
            [~,idx] = sort(Children(3,:)); 
            Children = Children(:,idx);  
        end
        Population_next = horzcat(Population_next, Children(:,1:popsize-nelite));  
    
    elseif strcmp(method,'no_elite')
        
        %Alte Population komplett mit Childern Generation �berschreiben
        Population_next = Children;
        
    end
end