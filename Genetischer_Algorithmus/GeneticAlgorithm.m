function [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, fit, xmin, xmax, ymin, ymax, popsize, fun_sel, fun_cro, fun_mut, fun_rek, cro_w, mut_w, opt, dopt)

% Aufruf:    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, fit, xmin, xmax, ymin, ymax, popsize, fun_sep, fun_cro, fun_mut, fun_rek, cro_w, mut_w, opt, dopt);
% g_max:     maximale Anzahl Iterationen/Generationen Default: 1000
% fit:       Fitnessfunktion: Funktionsargument Default: @fRosenbrock
% xmin:      minimaler Wert f�r x (Suchbereich in der Funktion) Default: -3
% xmax:      maximaler Wert f�r x (Suchbereich in der Funktion) Default: 3
% ymin:      minimaler Wert f�r y (Suchbereich in der Funktion) Default: -3
% ymax:      maximaler Wert f�r y (Suchbereich in der Funktion) Default: 3
% popsize:   Gr��e der Anfangspopulation Default: 10
% fun_sel:   Selektionsalgortihmus Default: 
% fun_cro:   Cross-Over Algorithmus Default: 'n_point_crossover'
% fun_mut:   Mutations Algorithmus Default: 'two_wk'
% fun_rek:   Rekombinations Algorithmus Default: 'elite' 
% cro_w:     Cross-Over Wahrscheinlichkeit Default: 1
% mut_w:     Mutationswahrscheinlichekit Default: 1
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
PLOT = true;

%Abbruchbediengung ein/ausschalten
BREAK = true;

%GIF Erstellen ein/ausschalten
GIF = false;


%%------------------------------------------------------------------------
%% Default Werte festlegen
%%------------------------------------------------------------------------

if ~exist('g_max','var') g_max = 1000; end
if ~exist('fit','var') fit = @fRosenbrock; end
if ~exist('xmin','var') xmin = -3; end
if ~exist('xmax','var') xmax = 3; end
if ~exist('ymin','var') ymin = -3; end
if ~exist('ymax','var') ymax = 3; end
if ~exist('popsize','var') popsize = 10; end
if ~exist('fun_sel','var') fun_sel = 'rank_base'; end
if ~exist('fun_cro','var') fun_cro = 'n_point_crossover'; end
if ~exist('fun_mut','var') fun_mut = 'two_wk'; end
if ~exist('fun_rek','var') fun_rek = 'elite'; end
if ~exist('cro_w','var') cro_w = 0.6; end
if ~exist('mut_w','var') mut_w = 0.1; end
if ~exist('opt','var') opt = [1;,1; 0]; end
if ~exist('dopt','var') dopt = 1e-5; end


%%------------------------------------------------------------------------
%% Relative Pfade angeben f�r Codierung/Selektion/Cross-Over/Mutation/Rekombination
%%------------------------------------------------------------------------

addpath('../Codierungsfunktionen');
addpath('../Selektionsfunktionen');
addpath('../BMO_Crossover_und_Mutation');


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
    figurehandler = figure(1);
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
Population(3,:) = fit(Population(1,:),Population(2,:));

%Beste Fitness suchen
[bestVal,bestIdx] = min(Population(3,:));
if bestVal < best(3)
    best(:) = Population(:,bestIdx);
end
         

if PLOT == true
    
    %optimales globales Minimum plotten
    subplot(1,2,1);
    hold on;
    plot3(opt(1),opt(2),opt(3),'wo','MarkerSize',6,'MarkerFaceColor','w');
    subplot(1,2,2);
    hold on;
    plot(opt(1),opt(2),'wo','MarkerSize',6,'MarkerFaceColor','w');
    
    %Beste Fitness plotten
    subplot(1,2,1);
    hold on;
    plot3(best(1),best(2),best(3),'r+','MarkerSize',20);
    subplot(1,2,2);
    hold on;
    plot(best(1),best(2),'r+','MarkerSize',20);
    
    %Anfangspopulation plotten
    subplot(1,2,1);
    hold on;
    plot3(Population(1,:),Population(2,:),Population(3,:),'k+','MarkerSize',8);

    subplot(1,2,2);
    hold on;
    plot(Population(1,:),Population(2,:),'k+','MarkerSize',8);

    
    %GIF erstellen
    if GIF == true
        filenameGIF = 'AnimatedImage.gif';
        image = getframe(figurehandler);
        gifimage = frame2im(image); 
        [imind,cm] = rgb2ind(gifimage,256); 
        imwrite(imind,cm,filenameGIF,'gif', 'Loopcount',inf); 
    end

end



%%------------------------------------------------------------------------
%% Hauptschleife: Mehrere Generationen durchlaufen
%%------------------------------------------------------------------------

%Abbruchbedingung: Bei wievielen Generationswechseln ohne Verbesserung der
%Fitness
Max_Gen = g_max;
%Z�hler f�r Generationen ohne Fitnessverbesserung
Gen_Counter = 0;
%Merker f�r Anzahl der Generationen bis gute N�herung erreicht wird 
Best_Counter = g_max;

%Anzahl der Ausgabeupdtaes pro Funktionsaufrauf
update_steps = 100;

%Children Population anlegen
Children = zeros(3,popsize);


for g=2:1:g_max
    
    
    %-------------------
    % 1. Codierung der Generation
    %-------------------
    
    [Population_coded] = binary_coding(Population, xmax, xmin, ymax, ymin);
    [Population_coded] = binary2gray(Population_coded);
    
    %-------------------
    % 2. Selektion
    %-------------------
    
    Turnierteilnehmer = 0.2;
    Population_coded
    Children_coded = selection(fun_sel, Turnierteilnehmer, Population_coded);
   
    %-------------------
    % 3. Cross-Over
    %-------------------
    
    [Children_coded] = CrossOver(Children_coded, fun_cro, cro_w);
    
    %-------------------
    % 4. Mutation
    %-------------------
    
    [Children_coded] = Mutation(Children_coded, fun_mut, mut_w);                       
       
    %-------------------
    % 5. Dekodierung
    %-------------------
    
    [Children_coded] = gray2binary(Children_coded);
    [Children] = binary_decoding(Children_coded, xmax, xmin, ymax, ymin);
    
    %Punkte innerhalb des Suchraums setzen (falls durch CrossOver etc
    %au�erhalb)
    for i = 1:size(Children,2)
    
        if Children(1,i) > xmax
            Children(1,i) = xmax;
        elseif Children(1,i) < xmin
            Children(1,i) = xmin;
        end
        
        if Children(2,i) > ymax
            Children(2,i) = ymax;
        elseif Children(2,i) < ymin
            Children(2,i) = ymin;
        end
        
    end
    
    %-------------------
    % 6. Neue Fitnesswerte berechnen &
    % Rekombination 
    %-------------------
    
    %Neue Fitnesswerte berechnen
    Children(3,:) = fit(Children(1,:),Children(2,:));
    
    %Erstellen einer neuen Generation aus alter und children Generation
    Population = Rekombination(Population, Children, fun_rek);
    
    %Beste Fitness suchen aus neuer Population 
    [bestVal,bestIdx] = min(Population(3,:));
    if bestVal < best(3)
        best(:) = Population(:,bestIdx);
        Best_Counter = g;
        Gen_Counter = 0;
    else
        Gen_Counter = Gen_Counter+1;
    end
    Best_Counter = g;
 
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
            plot3(opt(1),opt(2),opt(3),'wo','MarkerSize',6,'MarkerFaceColor','w');
            hold on;
            plot3(best(1),best(2),best(3),'r+','MarkerSize',20);
            hold on;
            plot3(Population(1,:),Population(2,:),Population(3,:),'k+','MarkerSize',8);
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
            plot(opt(1),opt(2),'wo','MarkerSize',6,'MarkerFaceColor','w');
            hold on
            plot(best(1),best(2),'r+','MarkerSize',20);
            hold on;
            plot(Population(1,:),Population(2,:),'k+','MarkerSize',8);
            hold off
            
            %GIF erstellen
            if GIF == true
                image = getframe(figurehandler);
                gifimage = frame2im(image); 
                [imind,cm] = rgb2ind(gifimage,256); 
                imwrite(imind,cm,filenameGIF,'gif','WriteMode','append','DelayTime',0.2);
            end
   
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

