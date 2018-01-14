clear all;
close all;
clc

%% Einstellungen

%Ordner für Testergebnisse erstellen
DirName = ['Test01'];
mkdir(DirName);


%Testergebnisse aus mat-datei laden
load('Testergebnisse2.mat');

%Anzahl an Fitnessfunktionen und Kombinationen der Methoden
[KombiNum,FitnessNum] = size(acc_storage);
FitnessNum = FitnessNum-1;
KombiNum = KombiNum-1;

%Parameter in Titeltext wandeln
title_str = [newline,newline,'popsize = ',num2str(popsize),'     -     mut. wahr.= ',num2str(mut_w),'     -     cro. wahr.= ',num2str(cro_w)];

%Farbeinstellungen für die Balkendiagramme
colors = hsv(KombiNum);



%% Plotten 
cd(DirName)
for fun=1:FitnessNum
    
    %-------------------
    %Neues Fenster für Funktion erstellen
    %-------------------
    figure_str = ['Name der Funktion/Fitnessfunktion : ',char(acc_storage(1,fun+1))];
    fig = figure('Name',figure_str);
    
    %-------------------
    %Genauigkeit plotten
    %-------------------
    sub1 = subplot(2,1,1);
    for i=2:KombiNum+1
        %Kehrwert der Genauigkeit --> höchster Wert am besten
        acc = cell2mat(acc_storage(i,fun+1));
        %Plotten in Balkendiagramm
        h = bar(i-1,acc,'facecolor', colors(i-1,:),'BarWidth',0.5);
        legend_str(i-1) = acc_storage{i,1};
        hold on;
    end
    l = legend(legend_str{:},'Location','bestoutside');
    l.FontSize = 6;
    set(l,'Interpreter','none')
    xlabel('Methodenkombinationen');
    ylabel('Genauigekit - Abweichung vom Optimum');
    title(strcat(figure_str,title_str));
    grid minor;

    %------------------- 
    %Iterationen plotten
    %-------------------
    subplot(2,1,2);
    for i=2:KombiNum+1
        %Kehrwert der Genauigkeit --> höchster Wert am besten
        it = cell2mat(it_storage(i,fun+1));
        %Plotten in Balkendiagramm
        h = bar(i-1,it,'facecolor', colors(i-1,:),'BarWidth',0.5);
        legend_str(i-1) = it_storage{i,1};
        hold on;
    end
    %legend(legend_str{:},'Location','bestoutside');
    xlabel('Methodenkombinationen');
    ylabel('Anzahl an Iterationen');
    grid minor;
    
    saveas(fig,strcat(char(acc_storage(1,fun+1)),'.fig'))

        
end
cd ..
