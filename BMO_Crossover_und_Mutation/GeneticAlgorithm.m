function [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, fit, xmin, xmax, ymin, ymax, popsize, fun_sel, fun_cro, fun_mut, fun_rek, opt, dopt)

% Aufruf:    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, fit, xmin, xmax, ymin, ymax, popsize, fun_sep, fun_cro, fun_mut, fun_rek, opt, dopt)
% g_max:     maximale Anzahl Iterationen/Generationen Default: 1000
% fit:       Fitnessfunktion: Funktionsargument Default: @fRosenbrock
% xmin:      minimaler Wert f�r x (Suchbereich in der Funktion) Default: -3
% xmax:      maximaler Wert f�r x (Suchbereich in der Funktion) Default: 3
% ymin:      minimaler Wert f�r y (Suchbereich in der Funktion) Default: -3
% ymax:      maximaler Wert f�r y (Suchbereich in der Funktion) Default: 3
% popsize:   Gr��e der Anfangspopulation Default: 10
% fun_sel:   Selektionsalgortihmus Default: 
% fun_cro:   Cross-Over Algorithmus Default: 
% fun_mut:   Mutations Algorithmus Default: 
% fun_rek:   Rekombinations Algorithmus Default: 'elite' 
% opt:       "optimale" L�sung des Minimierungsproblems (n�herungsweise)
%            Default: [1;,1; 0] --> f�r Rosenbrock
% dopt:      Mindestgenuigkeit zwischen opt und loesung --> Abbruchbedingung Default: -inf
%            --> kein Abbruch

% loesung:   [x_min; x_max; f_min]
% Best_Counter: Iterationen/Generationen f�r N�herung
% accuracy:  Abweichung zwischen gefundener L�sung und "Optimum" -->
%            Genauigekit


%%------------------------------------------------------------------------
%% Einstellungen
%%------------------------------------------------------------------------

%Ausgabe von Plots ein/ausschalten
PLOT = false;

%Abbruchbediengung ein/ausschalten
BREAK = false;


%%------------------------------------------------------------------------
%% Default Werte festlegen
%%------------------------------------------------------------------------

if ~exist('t_max','var') g_max = 1000; end
if ~exist('fit','var') fit = @fRosenbrock; end
if ~exist('xmin','var') xmin = -3; end
if ~exist('xmax','var') xmax = 3; end
if ~exist('ymin','var') ymin = -3; end
if ~exist('ymax','var') ymax = 3; end
if ~exist('popsize','var') popsize = 10; end
if ~exist('fun_sel','var') fun_sel = 'abc'; end
if ~exist('fun_cro','var') fun_cro = 'abc'; end
if ~exist('fun_mut','var') fun_mut = 'abc'; end
if ~exist('fun_rek','var') fun_rek = 'no_elite'; end
if ~exist('opt','var') opt = [1;,1; 0]; end
if ~exist('dopt','var') dopt = 1e-5; end


%%------------------------------------------------------------------------
%% Graphische Ausgabe der zu minimierenden Funktion
%%------------------------------------------------------------------------

if PLOT == true

    %Aufl�sung 
    n = 30;
    %X-Y Ebene aufspannen und Funktionswert f�r jeden Punkt ermitteln
    x = linspace(xmin,xmax,n);
    y = linspace(ymin,ymax,n);
    [X,Y] = meshgrid(x,y);
    Z = fit(X,Y);

    %Funktion plotten
    figure(1);
    subplot(1,2,1);
    mesh(X,Y,Z);
    xlabel('x','FontSize',13,'FontWeight','bold'); 
    ylabel('y','FontSize',13,'FontWeight','bold'); 
    zlabel('z','FontSize',13,'FontWeight','bold'); 
    title('Funktionsplot');
    grid minor;


%%------------------------------------------------------------------------
%% Optimierungsverlauf als Contourplot/H�henlinien visualisieren
%%------------------------------------------------------------------------

    %Kleinsten Funktionswert ermitteln und diesen als kleinste H�henlinie
    %festlegen (floor: auf int abrunden)
    zmin = floor(min(Z(:)));
    %Gr��ten Funktionswert ermitteln und diesen als h�chste H�henlinie
    %festlegen (ceil auf int aufrunden)
    zmax = ceil(max(Z(:)));
    %Anzahl der H�henlinienunterschiede
    n_contour = 50;
    %Schrittweite zwischen den H�henlinien ermitteln
    zinc = (zmax - zmin) / (n_contour-1);
    %H�henlinien ermitteln (auf Z bezogen)
    zlevs = zmin:zinc:zmax;

    %Funktion mit H�henlinien und Startpunkt plotten
    subplot(1,2,2);
    contour(X,Y,Z,zlevs,'Fill','on')
    colorbar;
    xlabel('x','FontSize',13,'FontWeight','bold');  
    ylabel('y','FontSize',13,'FontWeight','bold'); 
    title('H�henlinien');
    grid minor;

end


%%------------------------------------------------------------------------
%% Anfangspopulation festlegen und plotten
%%------------------------------------------------------------------------

Population = zeros(3,popsize);
%               |      |      |       |            |  
%_______________|__c1__|__c2__|__c..__|__cpopsize__|
%               |      |      |       |            |
%_x-Koordinate*_|__x1__|__x2__|__x..__|__xpopsize__|
%               |      |      |       |            |
%_y-Koordinate*_|__y1__|__y2__|__y..__|__ypopsize__|
%               |      |      |       |            |
%__Fitnesswert__|__f1__|__f2__|__f..__|__fpopsize__|
%
%*=Koordinate im Suchraum der Funktion (Scalar) oder
%Codierter Bitstring 

%Speicher f�r besten Fitnesswert
best = [0,0,inf];

%x- und y-Werte zuf�llig gleichverteilt ermitteln innerhalb des
%Suchraums (popsize-mal)
Population(1,:) = random('unif',xmin,xmax,1,popsize);
Population(2,:) = random('unif',ymin,ymax,1,popsize);

%Fitnesswerte berechnen
% Population(3,:) = fit(Population(1,:),Population(2,:));

%Beste Fitness suchen
[bestVal,bestIdx] = min(Population(3,:));
if bestVal < best(3)
    best(:) = Population(:,bestIdx);
end
         

if PLOT == true
    %Anfangspopulation plotten
    subplot(1,2,1);
    hold on;
    plot3(Population(1,:),Population(2,:),Population(3,:),'k+','MarkerSize',8);

    subplot(1,2,2);
    hold on;
    plot(Population(1,:),Population(2,:),'k+','MarkerSize',8);

    %Beste Fitness plotten
    subplot(1,2,1);
    hold on;
    plot3(best(1),best(2),best(3),'r+','MarkerSize',20);
    subplot(1,2,2);
    hold on;
    plot(best(1),best(2),'r+','MarkerSize',20);
end



%%------------------------------------------------------------------------
%% Hauptschleife: Mehrere Generationen durchlaufen
%%------------------------------------------------------------------------

%Abbruchbedingung: Bei wievielen Generationswechseln ohne Verbesserung der
%Fitness
Max_Gen = 50;
%Z�hler f�r Generationen ohne Fitnessverbesserung
Gen_Counter = 0;
%Merker f�r Anzahl der Generationen bis gute N�herung erreicht wird 
Best_Counter = g_max;

%Anzahl der Ausgabeupdtaes pro Funktionsaufrauf
update_steps = 10;

%Children Population anlegen
Children = zeros(3,popsize);

for g=2:1:g_max
    
    %-------------------
    % 1. Codierung der Generation
    %-------------------
    
    
    %-------------------
    % 2. Selektion
    %-------------------
    
    %Gesamtfitness berechnen aller Chromosome
    tot_fit = sum(Population(3,:));
    
    %Sp�ter l�schen/ersetzen:
    Children = Population;
    
    %Selektiosalgorithmus: Roulette !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Children = sel_fun(Population);
    
    %-------------------
    % 3. Cross-Over
    %-------------------
                                                                             % 4 Beliebige Gene mit einem X und Y Anteil
    Gen_coded{1,1} = '11111111110000000';
    Gen_coded{2,1} = '11111111111111111';
    
    Gen_coded{1,2} = '00000000001111111';
    Gen_coded{2,2} = '10000000000000000';
    
    Gen_coded{1,3} = '11111111111111111';
    Gen_coded{2,3} = '00000000000000000';
    
    Gen_coded{1,4} = '11111111111111111';
    Gen_coded{2,4} = '00000000000000000';
    
    hamming = zeros(2,1);                                                   % Zum Start der Hammingfunktion wird auf 0 gesetzt
    
    while norm(hamming - zeros(2,1)) < 0.00001                              % Hammingdistanz zwischen den Chromosomen muss gr��er 0 sein
        
        rand_num = unique(randi([1 size(Gen_coded,2)],1,2));
        while size(rand_num,2) ~= 2                                         % Vermeidung, dass ein Chromosomen doppelt ausgew�hlt wird
              rand_num = unique(randi([1 size(Gen_coded,2)],1,2));
        end

        for i = 1 : length(rand_num)                                        % Speichern der Ausgew�hlten Chromosomen
            tmp_Gen_coded{1,i} = Gen_coded{1,rand_num(i)};
            tmp_Gen_coded{2,i} = Gen_coded{2,rand_num(i)};
        end

        [ hamming ] = calc_hamming(tmp_Gen_coded);                          % �berpr�fung der Hammingdistanz der ausgew�hlten Chromosomen
    
    end
                                                                            % Auswahl des Crossovers
    % [ tmp_Gen_coded ] = n_point_crossover(tmp_Gen_coded, 4); 
    % [ tmp_Gen_coded ] = uniform_crossover(tmp_Gen_coded, 0.6);
    
    [ tmp_Gen_coded ] = shuffle_crossover(tmp_Gen_coded);
    
    %Cross-Over Algorithmus:  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Children = cro_fun(Children);
    
    %-------------------
    % 4. Mutation
    %-------------------
     
    [ tmp_Gen_coded ] = Mutation(tmp_Gen_coded, 0.5);                       % Aufrufen der Funktion f�r die Mutation eines Chromosomens mit �bergabe der Wahrscheinlichkeit
    
    for i = 1 : length(rand_num)                                            % Die ausgew�hlten Chromosomen werden ersetzt durch die ver�nderten Chromosomen im Crossover und der Mutation
        Gen_coded{1,rand_num(i)} = tmp_Gen_coded{1,i}; 
        Gen_coded{2,rand_num(i)} = tmp_Gen_coded{2,i};
    end
    %Mutation Algorithmus:  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Children = mut_fun(Children);
    
    
    %-------------------
    % 5. Dekodierung
    %-------------------
    
    
    
    %-------------------
    % 6. Neue Fitnesswerte berechnen &
    % Rekombination 
    %-------------------
    
    %Neue Fitnesswerte berechnen
    %Children(3,:) = fit(Children(1,:),Children(2,:));
    
    %Erstellen einer neuen Generation aus alter und children Generation
    %Population = Rekombination(Population, Children, popsize,fun_rek,1,0);
    
    %Beste Fitness suchen aus neuer Population 
    [bestVal,bestIdx] = min(Population(3,:));
    if bestVal < best(3)
        best(:) = Population(:,bestIdx);
        Best_Counter = g;
        Gen_Counter = 0;
    else
        Gen_Counter = Gen_Counter + 1;
    end
    
 
    %-------------------
    % Ausgaben/Plots
    %-------------------
    if PLOT == true
        if (mod(g,floor(g_max/update_steps))==0) 
            figure(1);
            %Funktion plotten mit neuer Generation
            subplot(1,2,1);
            mesh(X,Y,Z);
            xlabel('x','FontSize',13,'FontWeight','bold'); 
            ylabel('y','FontSize',13,'FontWeight','bold'); 
            zlabel('z','FontSize',13,'FontWeight','bold'); 
            title('Funktionsplot');
            grid minor;
            hold on;
            plot3(Population(1,:),Population(2,:),Population(3,:),'k+','MarkerSize',8);
            hold on;
            plot3(best(1),best(2),best(3),'r+','MarkerSize',20);
            hold off;


            %H�henlinien plotten mit neuer Generation
            subplot(1,2,2);
            contour(X,Y,Z,zlevs,'Fill','on')
            colorbar;
            xlabel('x','FontSize',13,'FontWeight','bold');  
            ylabel('y','FontSize',13,'FontWeight','bold'); 
            title('H�henlinien');
            grid minor;
            hold on;
            plot(Population(1,:),Population(2,:),'k+','MarkerSize',8);
            hold on
            plot(best(1),best(2),'r+','MarkerSize',20);
            hold off
            %pause(1);
        end
    end
    
    %-------------------
    % 7. Abbruchbedingung
    %-------------------
    
    %Euklidischer Abstand zwischen optimaler L�sung und gefundener L�sung
    %distance = sqrt((opt(1)-best(1)^2) + (opt(2)-best(2)^2) + (opt(3)-best(3)^2));
    
    %Abstand der Fitness
    accuracy = abs(opt(3)-best(3));
    
    if ((accuracy <= dopt) || (Gen_Counter > Max_Gen)) && BREAK == true
       break; 
    end
    
end

% Ausgabe des bisher besten Punkts
loesung = best(:);
