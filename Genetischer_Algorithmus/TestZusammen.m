clear all;
close all;
clc;

filename_result = 'Testergebnisse0815.mat';

%Testergebnisse aus mat-dateien laden
load('Testergebnisse1_Rosenbrock.mat');
acc_Rosenbrock = acc_storage;
it_Rosenbrock = it_storage;

load('Testergebnisse2_Schwefel.mat');
acc_Schwefel = acc_storage;
it_Schwefel = it_storage;

load('Testergebnisse3_Fuchsbauten.mat');
acc_Fuchsbauten = acc_storage;
it_Fuchsbauten = it_storage;

load('Testergebnisse4_Rastrigins.mat');
acc_Rastrigins = acc_storage;
it_Rastrigins = it_storage;

load('Testergebnisse5_BaecksTreppe.mat');
acc_BaecksTreppe = acc_storage;
it_BaecksTreppe = it_storage;

load('Testergebnisse6_Griewangks.mat');
acc_Griewangks = acc_storage;
it_Griewangks = it_storage;

load('Testergebnisse7_Ackleys.mat');
acc_Ackleys = acc_storage;
it_Ackleys = it_storage;

load('Testergebnisse8_Treppe.mat');
acc_Treppe = acc_storage;
it_Treppe = it_storage;

%Zusammenfügen der Ergebnisse
acc_storage = acc_Rosenbrock;
it_storage = it_Rosenbrock;

acc_storage(:,3) = acc_Schwefel(:,2);
it_storage(:,3) = it_Schwefel(:,2);

acc_storage(:,4) = acc_Fuchsbauten(:,2);
it_storage(:,4) = it_Fuchsbauten(:,2);

acc_storage(:,5) = acc_Rastrigins(:,2);
it_storage(:,5) = it_Rastrigins(:,2);

acc_storage(:,6) = acc_BaecksTreppe(:,2);
it_storage(:,6) = it_BaecksTreppe(:,2);

acc_storage(:,7) = acc_Griewangks(:,2);
it_storage(:,7) = it_Griewangks(:,2);

acc_storage(:,8) = acc_Ackleys(:,2);
it_storage(:,8) = it_Ackleys(:,2);

acc_storage(:,9) = acc_Treppe(:,2);
it_storage(:,9) = it_Treppe(:,2);

%Testergebnisse speichern
save(filename_result,'acc_storage','it_storage','popsize','cro_w','mut_w');