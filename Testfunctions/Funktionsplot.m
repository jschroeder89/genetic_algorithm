clear all;
close all;
clc;

%% Ackleys Funktion
xAckleys = linspace(-30,30,500);
yAchleys = linspace(-30,30,500);
[XAckleys,YAckleys] = meshgrid(xAckleys,yAchleys);
ZAckleys = fAckleysFunktion(XAckleys,YAckleys);

subplot(3,3,1);
mesh(XAckleys,YAckleys,ZAckleys);
title('Ackleys Funktion');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Shekels Fuchsbauten
xShekels = linspace(-40,40,200);
yShekels = linspace(-40,40,200);
[XShekels,YShekels] = meshgrid(xShekels,yShekels);
ZShekels = fShekelsFuchsbauten(XShekels,YShekels);

subplot(3,3,2);
mesh(XShekels,YShekels,ZShekels);
title('Shekels Fuchsbauten');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Rosenbrocks Sattel
xRosenbrock = linspace(-2,2,200);
yRosenbrock = linspace(-2,2,200);
[XRosenbrock,YRosenbrock] = meshgrid(xRosenbrock,yRosenbrock);
ZRosenbrock = fRosenbrock(XRosenbrock,YRosenbrock);

subplot(3,3,3);
mesh(XRosenbrock,YRosenbrock,ZRosenbrock);
title('Rosenbrocks Sattel');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Schwefels Funktion
xSchwefel = linspace(-450,450,200);
ySchwefel = linspace(-450,450,200);
[XSchwefel,YSchwefel] = meshgrid(xSchwefel,ySchwefel);
ZSchwefel = fSchwefel(XSchwefel,YSchwefel);

subplot(3,3,4);
mesh(XSchwefel,YSchwefel,ZSchwefel);
title('Schwefels Funktion');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% x^4 mit Rauschen
x4 = linspace(-400,400,200);
y4 = linspace(-400,400,200);
[X4,Y4] = meshgrid(x4,y4);
Z4 = fx4WithNoise(X4,Y4);

subplot(3,3,5);
mesh(X4,Y4,Z4);
title('x^4 mit Rauschen');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Treppenfunktion
xTreppe = linspace(-5,5,200);
yTreppe = linspace(-5,5,200);
[XTreppe,YTreppe] = meshgrid(xTreppe,yTreppe);
ZTreppe = fTreppenfunktion(XTreppe,YTreppe);

subplot(3,3,6);
mesh(XTreppe,YTreppe,ZTreppe);
title('Treppenfunktion');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Bäcks Treppenfunktion
xBTreppe = linspace(-5,5,200);
yBTreppe = linspace(-5,5,200);
[XBTreppe,YBTreppe] = meshgrid(xBTreppe,yBTreppe);
ZBTreppe = fBaecksTreppenfunktion(XBTreppe,YBTreppe);

subplot(3,3,7);
mesh(XBTreppe,YBTreppe,ZBTreppe);
title('Baecks Treppenfunktion');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Rastrigins Funktion
xRastrigins = linspace(-5,5,200);
yRastrigins = linspace(-5,5,200);
[XRastrigins,YRastrigins] = meshgrid(xRastrigins,yRastrigins);
ZRastrigins = fRastrigins(XRastrigins,YRastrigins);

subplot(3,3,8);
mesh(XRastrigins,YRastrigins,ZRastrigins);
title('Rastrigins Funktion');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

%% Griewangks Funktion
xGriewangk = linspace(-100,100,200);
yGriewangk = linspace(-100,100,200);
[XGriewangk,YGriewangk] = meshgrid(xGriewangk,yGriewangk);
ZGriewangk = fGriewangks(XGriewangk,YGriewangk);

subplot(3,3,9);
mesh(XGriewangk,YGriewangk,ZGriewangk);
title('Griewangks Funktion');
xlabel('x');
ylabel('y');
zlabel('z');
grid minor;
axis square;

