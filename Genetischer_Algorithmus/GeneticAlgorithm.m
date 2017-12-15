function [loesung,Max_Gen] = GeneticAlgorithm(g_max, fit, xmin, xmax, ymin, ymax, popsize)

% Aufruf:    [loesung] = GeneticAlgorithm(g_max, fit, xmin, xmax, ymin, ymax, popsize, sel_fun, cro_fun, mut_fun)
% g_max:     maximale Anzahl Iterationen/Generationen Default: 1000
% fit:       Fitnessfunktion: Funktionsargument Default: @fRosenbrock
% xmin:      minimaler Wert f�r x (Suchbereich in der Funktion) Default: -3
% xmax:      maximaler Wert f�r x (Suchbereich in der Funktion) Default: 3
% ymin:      minimaler Wert f�r y (Suchbereich in der Funktion) Default: -3
% ymax:      maximaler Wert f�r y (Suchbereich in der Funktion) Default: 3
% popsize:   Gr��e der Anfangspopulation Default: 10
% sel_fun:   Selektionsalgortihmus Default: @fRoulette
% cro_fun:   Cross-Over Algorithmus Default: @f
% mut_fun:   Mutations Algorithmus Default: @f

% loesung:   [x_min; x_max; f_min]


%%------------------------------------------------------------------------
%% Default Werte festlegen
%%------------------------------------------------------------------------

if ~exist('t_max','var') g_max = 1000; end
if ~exist('func','var') fit = @fRosenbrock; end
if ~exist('xmin','var') xmin = -3; end
if ~exist('xmax','var') xmax = 3; end
if ~exist('ymin','var') ymin = -3; end
if ~exist('ymax','var') ymax = 3; end
if ~exist('popsize','var') popsize = 10; end
%if ~exist('sel_fun','var') sel_fun = @; end
%if ~exist('cro_fun','var') cro_fun = @; end
%if ~exist('mut_fun','var') mut_fun = @; end


%%------------------------------------------------------------------------
%% Graphische Ausgabe der zu minimierenden Funktion
%%------------------------------------------------------------------------

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


%%------------------------------------------------------------------------
%% Anfangspopulation festlegen und plotten
%%------------------------------------------------------------------------

Population = zeros(3,popsize);
best = [0,0,inf];

for i=1:1:popsize
    
    %x- und y-Wert zuf�llig gleichverteilt ermitteln innerhalb des
    %Suchraums
    Population(1,i) = random('unif',xmin,xmax);
    Population(2,i) = random('unif',ymin,ymax);
    
    %Fitnesswerte berechnen
    Population(3,1) = fit(Population(1,i),Population(2,i));
    
    %Anfangspopulation plotten
    subplot(1,2,1);
    hold on;
    plot3(Population(1,i),Population(2,i),Population(3,i),'k+','MarkerSize',8);
    
    subplot(1,2,2);
    hold on;
    plot(Population(1,i),Population(2,i),'k+','MarkerSize',8);
    
    %Beste Fitness suchen
    if Population(3,i) < best(3)
       best(:) = Population(:,i);
    end
    
end
%Beste Fitness plotten
subplot(1,2,1);
hold on;
plot3(best(1),best(2),best(3),'r+','MarkerSize',20);
subplot(1,2,2);
hold on;
plot(best(1),best(2),'r+','MarkerSize',20);



%%------------------------------------------------------------------------
%% Hauptschleife: Mehrere Generationen durchlaufen
%%------------------------------------------------------------------------

%Anzahl der Ausgabeunterbrechungen der Schritte
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
    %Sp�ter l�schen:
    Children = Population;
    
    %Selektiosalgorithmus: Roulette !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Children = sel_fun(Population);
    
    %-------------------
    % 3. Cross-Over
    %-------------------
    
    %Cross-Over Algorithmus:  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Children = cro_fun(Children);
    
    %-------------------
    % 4. Mutation
    %-------------------
    
    %Mutation Algorithmus:  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Children = mut_fun(Children);
    
    
    %-------------------
    % 5. Dekodierung
    %-------------------
    
    
    
    %-------------------
    % 6. Neue Fitnesswerte berechnen und Population �berschreiben
    %-------------------
    Children(3,i) = fit(Children(1,i),Children(1,i));
    Population = Children;
    
    %Beste Fitness suchen 
    for i=1:1:popsize
      if Population(i,3) < best(3)
       best(:) = Population(i,:);
       %Iterationschritte/Generationen bis Divergenz speichern
       Max_Gen = g;
      end 
    end
 
    %-------------------
    % Ausgaben/Plots
    %-------------------
    
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
        plot3(Population(:,1),Population(:,2),Population(:,3),'k+','MarkerSize',8);
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
        plot(Population(:,1),Population(:,2),'k+','MarkerSize',8);
        hold on
        plot(best(1),best(2),'r+','MarkerSize',20);
        hold off
        %pause(1);
    end
    
    %-------------------
    % 7. Abbruchbedingung
    %-------------------
    
end

% Ausgabe des bisher besten Punkts
loesung = best(:);
