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
%----Parameter f�r genetischen Algorithmus-------
%Startpopulation
popsize = [10 20 40];
num_pop = length(popsize);

%Max Iterationen/Generationen pro Ducrhlauf des genetischen Algorithmus
g_max = 1000;

%Abbruchbedingung: Mindestgenauigkeit der L�sungen
dopt = 1e-2;

%Cross-Over und Mutationswahrscheinlichkeit 
cro_wk = 0.6;
mut_wk = 0.1;

%----Parameter f�r Testumgebung-------
%Testdurchl�ufe pro Einstellparameter 
Max_It = 10;

%Mat-File Name, in welchem die Testergebnisse gespeichert werden
filename_result = 'Testergebnisse2_Schwefel_pop.mat';

%%------------------------------------------------------------------------
%% Funktionshandler und Methodenstrings anlegen
%%------------------------------------------------------------------------

%Ordnerpfade einbinden
addpath('Fitnessfunktionen');

%Fitnessfunktionen 
fun_fit = {'fSchwefel'};

%Funktions Handler f�r Codierungs Funktion anlegen
fun_cod = 0;

%Funktions Handler f�r Dekodierungs Funktion anlegen
fun_dec = 0;

%Methoden-Strings f�r Selektions Funktion als cell array anlegen
fun_sel = {'rank_base','elite','prop_selection'};
numfun_s = length(fun_sel);
s = 2;

%Methoden-Strings f�r Cross_Over Funktion als cell array anlegen
fun_cro = {'n_point_crossover','uniform_crossover','shuffle_crossover'};
numfun_cr = length(fun_cro);
c = 1;

%Methoden-Strings f�r Mutation Funktion als cell array anlegen
fun_mut = {'one_wk','two_wk'};
numfun_m = length(fun_mut);
m = 2;

%Funktions Handler f�r Rekombinations Funktion als cell array anlegen
fun_rek = {'no_elite','elite'};
numfun_r = length(fun_rek);
r = 2;

n_methoden = numfun_s*numfun_cr*numfun_m*numfun_r;


%%------------------------------------------------------------------------
%% Speicher f�r Testergebnisse
%%------------------------------------------------------------------------

%Speicher f�r Ergebnisse aller getesteten popsize f�r die Genauigkeit
%Zeilen: Popsize
%Spalten: Funktion
acc_storage = [{'popsize'}, fun_fit];
acc_storage(2:num_pop+1,1) = [num2cell(popsize(:))];
[Zeilen_acc,Spalten_acc] = size(acc_storage);


%Speicher f�r Ergebnisse aller getesteten popsize f�r die durchlaufenen Iterationen 
%Zeilen: Popsize
%Spalten: Funktion
it_storage = [{'popsize'}, fun_fit];
it_storage(2:num_pop+1,1) = [num2cell(popsize(:))];
[Zeilen_it,Spalten_it] = size(it_storage);



%%------------------------------------------------------------------------
%% Testdurchl�ufe
%%------------------------------------------------------------------------
%Index f�r die Anzahl der Methoden-Kombinationen
idx = 1;

%Schleife f�r Cross-Over Wahrscheinlichkeiten
for p=1:1:num_pop


    %Methode anlegen in Speicher
    idx = idx+1;
    Methodenstring = strcat('sel: ', fun_sel(s), ' + cro: ', fun_cro(c), ' +  mut: ', fun_mut(m), ' +  rek: ', fun_rek(r));
    fprintf('\nWahrscheinlichkeits-Kombination %d/%d \n mit--> popsize = %d cro_wk = %d und mut_wk = %d \n Methoden-Kombi: %s \n\n',idx-1,num_pop,popsize(p),cro_wk,mut_wk,char(Methodenstring));

    acc_sum = 0;
    it_sum = 0;

     %Schleife f�r mehrere Testreihen mit gleicher
     %Funktionsmethoden
     parfor i=1:1:Max_It


        %-------------------
        % 1. Rosenbrock Sattel
        %-------------------
        xmin = -450; xmax = 450; ymin = -450; ymax = 450;
        opt = [420.9687, 420.9687, -837.9658];

        [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fSchwefel, xmin, xmax, ymin, ymax, popsize(p), fun_sel(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_wk, mut_wk, opt, dopt);

        %acc_sum = acc_sum + accuracy;
        %it_sum = it_sum + Best_Counter;
        acc_vek(i) = accuracy;
        it_vek(i) = Best_Counter;
        disp(i);

        fprintf('\n2. Schwefel done mit L�sung - Optimal:\n');
        disp(horzcat(loesung,opt'));
        fprintf('It: %d \t acc: %f\n',Best_Counter,accuracy);

     end

 %Werte mitteln
 %acc_sum = acc_sum(:)*(1/Max_It);
 %it_sum = it_sum(:)*(1/Max_It);
 acc_sum = sum(acc_vek(:))*(1/Max_It);
 it_sum = sum(it_vek(:))*(1/Max_It);


 %Ergebnisse in Speicher schreiben
 acc_storage(mw+1,cw+1) = num2cell(acc_sum);
 it_storage(mw+1,cw+1) = num2cell(it_sum);


    
end
toc;
%Ergebnisse auf Festplatte speichern
save(filename_result,'acc_storage','it_storage','cro_wk','mut_wk','Methodenstring','fun_fit');
    
%Threads schlie�en
delete(gcp('nocreate'));







