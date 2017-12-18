clear all;
close all;
clc;


%%------------------------------------------------------------------------
%% Parameter
%%------------------------------------------------------------------------

%----Parameter f�r genetischen Algorithmus-------
%Startpopulation
popsize = 10;

%Max Iterationen/Generationen pro Ducrhlauf des genetischen Algorithmus
g_max = 100;

%Abbruchbedingung: Mindestgenauigkeit der L�sungen
dopt = 1e-5;

%----Parameter f�r Testumgebung-------
%Testdurchl�ufe pro Einstellparameter 
Max_It = 100;


%%------------------------------------------------------------------------
%% Funktionshandler anlegen 
%%------------------------------------------------------------------------

%Ordnerpfade einbinden
addpath('Fitnessfunktionen');

%Funktions Handler f�r Codierungs Funktion als cell array anlegen
fun_cod = {};
numfun_co = length(fun_cod);

%Funktions Handler f�r Dekodierungs Funktion als cell array anlegen
fun_dec = {};
numfun_d = length(fun_dec);

%Funktions Handler f�r Selektions Funktion als cell array anlegen
fun_sep = {};
numfun_s = length(fun_sep);

%Funktions Handler f�r Cross_Over Funktion als cell array anlegen
fun_cro = {};
numfun_cr = length(fun_cro);

%Funktions Handler f�r Mutations Funktion als cell array anlegen
fun_mut = {};
numfun_m = length(fun_mut);

%Funktions Handler f�r Rekombinations Funktion als cell array anlegen
fun_rek = {};
numfun_r = length(fun_rek);


%%------------------------------------------------------------------------
%% Testdurchl�ufe
%%------------------------------------------------------------------------
%Ziel: Durchlaufen aller Optimier


% %Schleife f�r Selektion
% for s=1:1:numfun_s
%     %Schleife f�r Cross-Over
%     for c=1:1:numfun_cro
%         %Schleife f�r Mutation
%         for m=1:1:numfun_m
%             %Schleife f�r Rekombination
%             for r=1:1:numfun_r
%                 
%                 %Schleife f�r mehrere Testreihen mit gleicher
%                 %Funktionsmethoden
%                 for i=1:1:Max_It


                    %-------------------
                    % 1. Rosenbrock Sattel
                    %-------------------
                    xmin = -2; xmax = 2; ymin = -2; ymax = 2;
                    opt = [1, 1, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fRosenbrock, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    


                    %-------------------
                    % 2. Schwefels Funktion
                    %-------------------
                    xmin = -450; xmax = 450; ymin = -450; ymax = 450;
                    opt = [420.9687, 420.9687, -837.9658];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fSchwefel, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    

                    %-------------------
                    % 3. Shekels Fuchsbauten
                    %-------------------
                    xmin = -40; xmax = 40; ymin = -40; ymax = 40;
                    opt = [-31.978, -31.978, 1.002];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fShekelsFuchsbauten, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    

                    %-------------------
                    % 4. Rastrigins Funktion
                    %-------------------
                    xmin = -5; xmax = 5; ymin = -5; ymax = 5;
                    opt = [0, 0, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fRastrigins, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    

                    %-------------------
                    % 5. B�cks Treppenfunktion
                    %-------------------
                    xmin = -5; xmax = 5; ymin = -5; ymax = 5;
                    opt = [0, 0, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fBaecksTreppenfunktion, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    

                    %-------------------
                    % 6. Griewangks Funktion
                    %-------------------
                    xmin = -100; xmax = 100; ymin = -100; ymax = 100;
                    opt = [0, 0, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fGriewangks, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    

                    %-------------------
                    % 7. Ackleys Funktion
                    %-------------------
                    xmin = -30; xmax = 30; ymin = -30; ymax = 30;
                    opt = [0, 0, 0];
                     
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fAckleysFunktion, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                   


                    %-------------------
                    % 8. Treppenfunktion
                    %-------------------
                    xmin = -5; xmax = 5; ymin = -5; ymax = 5;
                    opt = [-5, -5, -10];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fTreppenfunktion, xmin, xmax, ymin, ymax, popsize,opt,dopt)

                    
                    
                    
%                 end
%             end
%         end
%     end
% end
    






