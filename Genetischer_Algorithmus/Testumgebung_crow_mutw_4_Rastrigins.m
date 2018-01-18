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
cro_wk = [0.4 0.6 0.8];
num_crow = length(cro_wk);
mut_wk = [0.05 0.1 0.15];
num_mutw = length(mut_wk);
num_wk = num_crow*num_mutw;


%----Parameter für Testumgebung-------
%Testdurchläufe pro Einstellparameter 
Max_It = 10;

%Mat-File Name, in welchem die Testergebnisse gespeichert werden
filename_result = 'Testergebnisse4_Rastrigins_cro_mut_wk.mat';

%%------------------------------------------------------------------------
%% Funktionshandler und Methodenstrings anlegen
%%------------------------------------------------------------------------

%Ordnerpfade einbinden
addpath('Fitnessfunktionen');

%Fitnessfunktionen 
fun_fit = {'fRastrigins'};

%Funktions Handler für Codierungs Funktion anlegen
fun_cod = 0;

%Funktions Handler für Dekodierungs Funktion anlegen
fun_dec = 0;

%Methoden-Strings für Selektions Funktion als cell array anlegen
fun_sel = {'rank_base','elite','prop_selection'};
numfun_s = length(fun_sel);
s = 2;

%Methoden-Strings für Cross_Over Funktion als cell array anlegen
fun_cro = {'n_point_crossover','uniform_crossover','shuffle_crossover'};
numfun_cr = length(fun_cro);
c = 2;

%Methoden-Strings für Mutation Funktion als cell array anlegen
fun_mut = {'one_wk','two_wk'};
numfun_m = length(fun_mut);
m = 2;

%Funktions Handler für Rekombinations Funktion als cell array anlegen
fun_rek = {'no_elite','elite'};
numfun_r = length(fun_rek);
r = 2;

n_methoden = numfun_s*numfun_cr*numfun_m*numfun_r;


%%------------------------------------------------------------------------
%% Speicher für Testergebnisse
%%------------------------------------------------------------------------

%Speicher für Ergebnisse aller kombinierten Cross-Over und Mutations Wahrscheinlichkeiten für die Genauigkeit
%Zeilen: Cross-Over Wahrscheinlichkeiten
%Spalten: Mutation Wahrscheinlichkeiten
acc_storage = [{'Zeilen: cro_w, Spalten mut_w'}, num2cell(cro_wk(:)')];
acc_storage(2:num_mutw+1,1) = [num2cell(mut_wk(:))];
[Zeilen_acc,Spalten_acc] = size(acc_storage);


%Speicher für Ergebnisse aller kombinierten Cross-Over und Mutations Wahrscheinlichkeiten für die
%durchlaufenen Iterationen 
%Zeilen: Cross-Over Wahrscheinlichkeiten
%Spalten: Mutation Wahrscheinlichkeiten
it_storage = [{'Zeilen: cro_w, Spalten mut_w'}, num2cell(cro_wk(:)')];
it_storage(2:num_mutw+1,1) = [num2cell(mut_wk(:))];
[Zeilen_it,Spalten_it] = size(it_storage);



%%------------------------------------------------------------------------
%% Testdurchläufe
%%------------------------------------------------------------------------
%Index für die Anzahl der Methoden-Kombinationen
idx = 1;

%Schleife für Cross-Over Wahrscheinlichkeiten
for cw=1:1:num_crow
    %Schleife für Mutations Wahrscheinlichkeiten
    for mw=1:1:num_mutw

        %Methode anlegen in Speicher
        idx = idx+1;
        Methodenstring = strcat('sel: ', fun_sel(s), ' + cro: ', fun_cro(c), ' +  mut: ', fun_mut(m), ' +  rek: ', fun_rek(r));
        fprintf('\nWahrscheinlichkeits-Kombination %d/%d \n mit--> cro_wk = %d und mut_wk = %d \n Methoden-Kombi: %s \n\n',idx-1,num_wk,cro_wk(cw),mut_wk(mw),char(Methodenstring));

        acc_sum = 0;
        it_sum = 0;

         %Schleife für mehrere Testreihen mit gleicher
         %Funktionsmethoden
         parfor i=1:1:Max_It


            %-------------------
            % 4. Rastrigins Funktion
            %-------------------
            xmin = -5; xmax = 5; ymin = -5; ymax = 5;
            opt = [0, 0, 0];

            [loesung,Best_Counter,accuracy] = GeneticAlgorithm(g_max, @fRastrigins, xmin, xmax, ymin, ymax, popsize, fun_sel(s), fun_cro(c), fun_mut(m), fun_rek(r), cro_wk(cw), mut_wk(mw), opt, dopt);

            %acc_sum = acc_sum + accuracy;
            %it_sum = it_sum + Best_Counter;
            acc_vek(i) = accuracy;
            it_vek(i) = Best_Counter;
            disp(i);

            fprintf('\n2. Schwefel done mit Lösung - Optimal:\n');
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
end
toc;
%Ergebnisse auf Festplatte speichern
save(filename_result,'acc_storage','it_storage','popsize', 'Methodenstring','fun_fit');
    
%Threads schließen
delete(gcp('nocreate'));







