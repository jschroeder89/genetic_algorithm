clear all;
close all;
clc

%% Einstellungen

%Ordner für Testergebnisse erstellen
DirName = ['TestFinal'];
%mkdir(DirName);
copyfile action2.m TestFinal;


%Testergebnisse aus mat-datei laden
Teststring = 'Testergebnisse8_Treppe_cro_mut_wk.mat';
load(Teststring);

%Anzahl an Fitnessfunktionen und Kombinationen der Methoden
[MutNum,CrosNum] = size(acc_storage);
CrosNum = CrosNum-1;
MutNum = MutNum-1;

%Parameter in Titeltext wandeln
title_str = ['popsize = ',num2str(popsize),'Funktion= ',fun_fit,'Kombi = ',Methodenstring];

%Farbeinstellungen für die Balkendiagramme
colors = hsv(MutNum*CrosNum);



%% Plotten 
cd(DirName);


    
%-------------------
%Neues Fenster für Funktion erstellen
%-------------------
figure_str = strcat('Name der Funktion/Fitnessfunktion : ',string(fun_fit));
fig = figure('Name',figure_str);

%-------------------
%Genauigkeit plotten
%-------------------
sub1 = subplot(2,1,1);
idx = 1;
for m=2:MutNum+1
    for c=2:CrosNum+1 
        %Genauigkeit --> niedrigster Wert am besten
        acc = cell2mat(acc_storage(m,c));
        %Plotten in Balkendiagramm
        h = bar(idx,acc,'facecolor', colors(idx,:),'BarWidth',0.5);
        legend_str(idx) = {strcat('cro_wk: ',mat2str(acc_storage{1,c}),' mut_wk: ',mat2str(acc_storage{m,1}))};
        hold on;
        idx = idx+1;
    end
end
xlabel('Parametervariation');
ylabel('Genauigekit - Abweichung vom Optimum');
t = title(title_str);
set(t,'Interpreter','none')
grid minor;

subplot(2,1,1);
l = legend(legend_str{:},'Location','bestoutside');
l.FontSize = 14;
l.ItemHitFcn = @action2;
set(l,'Interpreter','none')

%------------------- 
%Iterationen plotten
%-------------------
sub2 = subplot(2,1,2);
idx = 1;
for m=2:MutNum+1
    for c=2:CrosNum+1 
        %Genauigkeit --> niedrigster Wert am besten
        acc = cell2mat(it_storage(m,c));
        %Plotten in Balkendiagramm
        h = bar(idx,acc,'facecolor', colors(idx,:),'BarWidth',0.5);
        legend_str(idx) = {strcat('cro_wk: ',mat2str(acc_storage{1,c}),' mut_wk: ',mat2str(acc_storage{m,1}))};
        hold on;
        idx = idx+1;
    end
end
%legend(legend_str{:},'Location','bestoutside');
xlabel('Parametervariation');
ylabel('Anzahl an Iterationen');
grid minor;

pos2 = get(sub2, 'Position');
pos2(3) = pos2(3)*0.75;
set(sub2, 'Position',pos2)


saveas(fig,strcat(Teststring,'.fig'))

cd ..
