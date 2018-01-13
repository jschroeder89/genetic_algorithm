function [Population_next] = Rekombination(Population_cur, Children, Methode)

% Aufruf:           [Population_new] = Rekombination(Population_old, Children, popsize, elite)
% Population_cur:   Aktuellle Poulation
% Children:         Veränderte Population (mit Selektion, Cross-Over,
% method:           String: 1)'no_elite' , 2) 'elite' Default: 'elite'
%
% [Population_next]: Neue Generation
    
if ~exist('method','var') Methode = 'elite'; end


if strcmp(Methode,'no_elite') == 0 && strcmp(Methode,'elite') == 0
   Methode = 'no_elite'; 
end
    
    %Alte Population komplett mit Childern Generation überschreiben
    Population_next = Children;
    
    if strcmp(Methode,'elite') 
        
        %Population aus P und P* (Children und Adult) zusammenfügen und
        %kleinsten Wert ermitteln --> Wird aufjedenfall in die neue Generation
        %übernommen
        Rek_Pop = horzcat(Children,Population_cur);
        [~,minidx] = min(Rek_Pop(3,:));
        
        %Children Generation nur überschreiben, wenn in Adult Generation das
        %momentane Minimum liegt bzw. bester Fitnesswert  
        if minidx > size(Children,2)
            %Besten Wert in neue Generation übernehmen
            Population_next(:,1) = Rek_Pop(:,minidx);
            %Children Generation nach Fitnesswert sortieren
            [~,idx] = sort(Children(3,:)); 
            Children = Children(:,idx);  
            %besten popsize-1 Chromosome der Children Generation in neue
            %Generation stecken
            Population_next(:,2:size(Children,2)) = Children(:,1:size(Children,2)-1);
        end
    
    elseif strcmp(Methode,'no_elite')
        
        return;
        
    end
end