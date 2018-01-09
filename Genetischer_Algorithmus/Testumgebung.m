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

%Cross-Over und Mutationswahrscheinlichkeit 
cro_w = 0.4;
mut_w = 0.5;

%----Parameter f�r Testumgebung-------
%Testdurchl�ufe pro Einstellparameter 
Max_It = 2;


%%------------------------------------------------------------------------
%% Funktionshandler und Methodenstrings anlegen
%%------------------------------------------------------------------------

%Ordnerpfade einbinden
addpath('Fitnessfunktionen');

%Fitnessfunktionen 
fun_fit = {'fRosenbrock','fSchwefel','fShekelsFuchsbauten','fRastrigins','fBaecksTreppenfunktion','fGriewangks','fAckleysFunktion','Treppenfunktion'};

%Funktions Handler f�r Codierungs Funktion anlegen
fun_cod = 0;

%Funktions Handler f�r Dekodierungs Funktion anlegen
fun_dec = 0;

%Methoden-Strings f�r Selektions Funktion als cell array anlegen
fun_sep = {'abc','def'};
numfun_s = length(fun_sep);

%Methoden-Strings f�r Cross_Over Funktion als cell array anlegen
fun_cro = {'ghi','jkl'};
numfun_cr = length(fun_cro);

%Methoden-Strings f�r Mutations Funktion als cell array anlegen
fun_mut = {'mno','pqr'};
numfun_m = length(fun_mut);

%Funktions Handler f�r Rekombinations Funktion als cell array anlegen
fun_rek = {'no_elite','elite'};
numfun_r = length(fun_rek);


%% Speicher f�r Testergebnisse

%Speicher f�r Ergebnisse aller kombinierten Methoden f�r die Genauigkeit
%Zeilen: Methodenzusammensetzung
%Spalten: Funktionen
acc_storage = [{'Methoden-Kombination'}, fun_fit];
[Zeilen_acc,Spalten_acc] = size(acc_storage);


%Speicher f�r Ergebnisse aller kombinierten Methoden f�r die durchlaufenen
%Iterationen
%Zeilen: Methodenzusammensetzung
%Spalten: Funktionen
it_storage = [{'Methoden-Kombination'}, fun_fit];
[Zeilen_it,Spalten_it] = size(it_storage);



%%------------------------------------------------------------------------
%% Testdurchl�ufe
%%------------------------------------------------------------------------
%Index f�r die Anzahl der Methoden-Kombinationen
idx = 1;

%Schleife f�r Selektion
for s=1:1:numfun_s
    %Schleife f�r Cross-Over
    for c=1:1:numfun_cr
         %Schleife f�r Mutation
         for m=1:1:numfun_m
            %Schleife f�r Rekombination          
            for r=1:1:numfun_r
                
                %Methode anlegen in Speicher
                idx = idx+1;
                Methodenstring = strcat(fun_sep(s), ' + ', fun_cro(c), ' + ', fun_mut(m), ' + ', fun_rek(r));
                acc_storage(idx,1) = {Methodenstring};
                it_storage(idx,1) = {Methodenstring};
                
                acc_sum = zeros(1,Spalten_acc-1);
                it_sum = zeros(1,Spalten_it-1);


                 %Schleife f�r mehrere Testreihen mit gleicher
                 %Funktionsmethoden
                 for i=1:1:Max_It
                    
                   
                    %-------------------
                    % 1. Rosenbrock Sattel
                    %-------------------
                    xmin = -2; xmax = 2; ymin = -2; ymax = 2;
                    opt = [1, 1, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fRosenbrock, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);
                    
                    acc_sum(1) = acc_sum(1) + accuracy;
                    it_sum(1) = it_sum(1) + Best_Counter;

                    


                    %-------------------
                    % 2. Schwefels Funktion
                    %-------------------
                    xmin = -450; xmax = 450; ymin = -450; ymax = 450;
                    opt = [420.9687, 420.9687, -837.9658];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fSchwefel, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);

                    acc_sum(2) = acc_sum(2) + accuracy;
                    it_sum(2) = it_sum(3) + Best_Counter;
                    
                    

                    %-------------------
                    % 3. Shekels Fuchsbauten
                    %-------------------
                    xmin = -40; xmax = 40; ymin = -40; ymax = 40;
                    opt = [-31.978, -31.978, 1.002];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fShekelsFuchsbauten, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);

                    acc_sum(3) = acc_sum(3) + accuracy;
                    it_sum(3) = it_sum(3) + Best_Counter;
                    
                    

                    %-------------------
                    % 4. Rastrigins Funktion
                    %-------------------
                    xmin = -5; xmax = 5; ymin = -5; ymax = 5;
                    opt = [0, 0, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fRastrigins, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);

                    acc_sum(4) = acc_sum(4) + accuracy;
                    it_sum(4) = it_sum(4) + Best_Counter;
                    
                    
                    
                    %-------------------
                    % 5. B�cks Treppenfunktion
                    %-------------------
                    xmin = -5; xmax = 5; ymin = -5; ymax = 5;
                    opt = [0, 0, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fBaecksTreppenfunktion, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);
                    
                    acc_sum(5) = acc_sum(5) + accuracy;
                    it_sum(5) = it_sum(5) + Best_Counter;

                    

                    %-------------------
                    % 6. Griewangks Funktion
                    %-------------------
                    xmin = -100; xmax = 100; ymin = -100; ymax = 100;
                    opt = [0, 0, 0];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fGriewangks, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);
                    
                    acc_sum(6) = acc_sum(6) + accuracy;
                    it_sum(6) = it_sum(6) + Best_Counter;

                    

                    %-------------------
                    % 7. Ackleys Funktion
                    %-------------------
                    xmin = -30; xmax = 30; ymin = -30; ymax = 30;
                    opt = [0, 0, 0];
                     
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fAckleysFunktion, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);
                    
                    acc_sum(7) = acc_sum(7) + accuracy;
                    it_sum(7) = it_sum(7) + Best_Counter;

                   


                    %-------------------
                    % 8. Treppenfunktion
                    %-------------------
                    xmin = -5; xmax = 5; ymin = -5; ymax = 5;
                    opt = [-5, -5, -10];
                    
                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fTreppenfunktion, xmin, xmax, ymin, ymax, popsize, fun_sep(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);
                    
                    acc_sum(8) = acc_sum(8) + accuracy;
                    it_sum(8) = it_sum(8) + Best_Counter;

                    
                    
                    
                 end
            
             %Werte mitteln
             acc_sum = acc_sum(:)*(1/Max_It);
             it_sum = it_sum(:)*(1/Max_It);
             
             %Ergebnisse in Speicher schreiben
             acc_storage(idx,2:Spalten_acc) = num2cell(acc_sum);
             it_storage(idx,2:Spalten_it) = num2cell(it_sum);
                
             end
        end
    end
end

%Ergebnisse auf Festplatte speichern
save('Testergebnisse.mat','acc_storage','it_storage','popsize','cro_w','mut_w');
    





