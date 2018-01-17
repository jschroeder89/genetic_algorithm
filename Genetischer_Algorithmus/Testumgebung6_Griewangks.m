clear all;
close all;
clc;


%%------------------------------------------------------------------------
%% Parameter
%%------------------------------------------------------------------------

% Parallel Computing on
delete(gcp('nocreate'));
pool = parpool('local');

tic;
%----Parameter für genetischen Algorithmus-------
%Startpopulation
popsize = 10;

%Max Iterationen/Generationen pro Ducrhlauf des genetischen Algorithmus
g_max = 1000;

%Abbruchbedingung: Mindestgenauigkeit der Lösungen
dopt = 1e-2;

%Cross-Over und Mutationswahrscheinlichkeit 
cro_w = 0.6;
mut_w = 0.1;


%----Parameter für Testumgebung-------
%Testdurchläufe pro Einstellparameter 
Max_It = 10;

%Mat-File Name, in welchem die Testergebnisse gespeichert werden
filename_result = 'Testergebnisse6_Griewangks.mat';

%%------------------------------------------------------------------------
%% Funktionshandler und Methodenstrings anlegen
%%------------------------------------------------------------------------

%Ordnerpfade einbinden
addpath('Fitnessfunktionen');

%Fitnessfunktionen 
fun_fit = {'fGriewangks'};

%Funktions Handler für Codierungs Funktion anlegen
fun_cod = 0;

%Funktions Handler für Dekodierungs Funktion anlegen
fun_dec = 0;

%Methoden-Strings für Selektions Funktion als cell array anlegen
fun_sel = {'rank_base','elite','prop_selection'};
numfun_s = length(fun_sel);

%Methoden-Strings für Cross_Over Funktion als cell array anlegen
fun_cro = {'n_point_crossover','uniform_crossover','shuffle_crossover'};
numfun_cr = length(fun_cro);

%Methoden-Strings für Mutation Funktion als cell array anlegen
fun_mut = {'one_wk','two_wk'};
numfun_m = length(fun_mut);

%Funktions Handler für Rekombinations Funktion als cell array anlegen
fun_rek = {'no_elite','elite'};
numfun_r = length(fun_rek);

n_methoden = numfun_s*numfun_cr*numfun_m*numfun_r;


%%------------------------------------------------------------------------
%% Speicher für Testergebnisse
%%------------------------------------------------------------------------

%Speicher für Ergebnisse aller kombinierten Methoden für die Genauigkeit
%Zeilen: Methodenzusammensetzung
%Spalten: Funktionen
acc_storage = [{'Methoden-Kombination'}, fun_fit];
[Zeilen_acc,Spalten_acc] = size(acc_storage);


%Speicher für Ergebnisse aller kombinierten Methoden für die durchlaufenen
%Iterationen
%Zeilen: Methodenzusammensetzung
%Spalten: Funktionen
it_storage = [{'Methoden-Kombination'}, fun_fit];
[Zeilen_it,Spalten_it] = size(it_storage);



%%------------------------------------------------------------------------
%% Testdurchläufe
%%------------------------------------------------------------------------
%Index für die Anzahl der Methoden-Kombinationen
idx = 1;

%Schleife für Selektion
for s=1:1:numfun_s
    %Schleife für Cross-Over
    for c=1:1:numfun_cr
        %Schleife für Mutation
        for m=1:1:numfun_m
            %Schleife für Rekombination          
            for r=1:1:numfun_r

                %Methode anlegen in Speicher
                idx = idx+1;
                Methodenstring = strcat('sel: ', fun_sel(s), ' + cro: ', fun_cro(c), ' +  mut: ', fun_mut(m), ' +  rek: ', fun_rek(r));
                %clc;
                fprintf('\nMethoden-Kombination %d/%d \n mit--> %s \n\n',idx-1,n_methoden,char(Methodenstring));
                acc_storage(idx,1) = {Methodenstring};
                it_storage(idx,1) = {Methodenstring};

                acc_sum = 0;
                it_sum = 0;


                 %Schleife für mehrere Testreihen mit gleicher
                 %Funktionsmethoden
                 parfor i=1:1:Max_It

 
                    %-------------------
                    % 6. Griewangks Funktion
                    %-------------------
                    xmin = -100; xmax = 100; ymin = -100; ymax = 100;
                    opt = [0, 0, 0];

                    [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fGriewangks, xmin, xmax, ymin, ymax, popsize, fun_sel(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_w, mut_w, opt, dopt);

                    %acc_sum = acc_sum + accuracy;
                    %it_sum = it_sum + Best_Counter;
                    acc_vek(i) = accuracy;
                    it_vek(i) = Best_Counter;
                    disp(i);

                    fprintf('\n6. Griewangks Funktion done mit Lösung - Optimal:\n');
                    disp(horzcat(loesung,opt'));
                    fprintf('It: %d \t acc: %f\n',Best_Counter,accuracy);

                    
                 end

             %Werte mitteln
             %acc_sum = acc_sum(:)*(1/Max_It);
             %it_sum = it_sum(:)*(1/Max_It);
             acc_sum = sum(acc_vek(:))*(1/Max_It);
             it_sum = sum(it_sum(:))*(1/Max_It);

             %Ergebnisse in Speicher schreiben
             acc_storage(idx,2:Spalten_acc) = num2cell(acc_sum);
             it_storage(idx,2:Spalten_it) = num2cell(it_sum);

            end
        end
    end
end
toc;
%Ergebnisse auf Festplatte speichern
save(filename_result,'acc_storage','it_storage','popsize','cro_w','mut_w');
    
%Threads schließen
delete(gcp('nocreate'));







