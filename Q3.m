
%THE COMMENTS ARE FOR MODIFYING THE SIZING OF THE MESHGRID, BOTTLE NECK AND
%RESISTIVITY
%current = zeros(10);
%size = [1 2 3 4 5 6 7 8 9 10];
%for z = 1:1:10
z=1;
nx = 50;
ny = 75;


G = sparse(nx*ny);
volt = zeros(nx*ny);
s1 = 1 ;
s2 = (1*10^-2);
innerX = nx*0.35;
outerX = nx*0.6;
innerY = ny*0.35;
outerY = ny*0.6;

cMap = ones(nx,ny);

s = zeros(nx,ny);

for i =1:1:nx
    for j=1:1:ny
        if i > innerX && i < outerX && (j < innerY||j > outerY)
            cMap(i,j) = s2;
            
            s(i,j) = s2;
        else
            s(i,j) = s1;
            
        end
    end
end

for i = 1:1:nx
     for j = 1:1:ny
         
         
         n = j + (i-1)*ny;
         n1 = j+(i+1-1)*ny;
         n2 = j+(i-1-1)*ny;
         n3 = j + 1 +(i-1)*ny;
         n4 = j -1 +(i-1)*ny;
         
         if i == 1
             G(n, :) = 0;
             G(n, n) = 1;
             volt(n) = 1;
         
         elseif i == nx
             G(n, :) = 0;
             G(n, n) = 1;
             volt(n) = 0;
         
         
         elseif j == ny
             
            G(n, n1) = (s(i+1, j) + s(i,j))/2;
            G(n, n2) = (s(i-1, j) + s(i,j))/2;
            G(n, n4) = (s(i, j-1) + s(i,j))/2;
            G(n, n) = -(G(n,n1)+G(n,n2)+G(n,n4));
 
         elseif j == 1
             
                G(n, n1) = (s(i+1, j) + s(i,j))/2;
                G(n, n2) = (s(i-1, j) + s(i,j))/2;
                G(n, n3) = (s(i, j+1) + s(i,j))/2;            
                G(n, n) = -(G(n,n1)+G(n,n2)+G(n,n3));

        
                 
             else
                    G(n, n1) = (s(i+1, j) + s(i,j))/2;
                    G(n, n2) = (s(i-1, j) + s(i,j))/2;
                    G(n, n3) = (s(i, j+1) + s(i,j))/2;
                    G(n, n4) = (s(i, j-1) + s(i,j))/2;
                    G(n, n) = -(G(n,n1)+G(n,n2)+G(n,n3)+G(n,n4));
                 
             end
         
         end
 end


E = G\volt;

temp = zeros(nx, ny);

for i = 1:1:nx
     for j = 1:1:ny
         n = j + (i-1)*ny;
         temp(i,j) = E(n);
     end
end

%{
[EX,EY] = gradient(temp);

EX = -EX;
EY = -EY;

JX = EX .*cMap;
JY = EY .*cMap;
sumCurrent = 0;

for i = 1:1:ny
    sumCurrent = sumCurrent + ((JX(nx/2,i))^2 + (JY(nx/2,i))^2)^0.5;
end

current(z) = sumCurrent;

%end
figure(1)
surf(temp)
shading interp

figure(2)
quiver(EX',EY');

figure(3) 
quiver(JX,JY);

figure(4) 
surf(cMap);
shading interp


%figure(5)
%plot(size,current);
%}

% figure(1)
% surf(temp)
% axis tight
% view([40 30]);
% title("Surface plot of voltage with bottle neck condition")

[Ex, Ey] = gradient(temp);

%  figure(2)
% quiver(-Ex, -Ey);
% axis tight
% clearvars
% clearvars -GLOBAL
% close all
% format shorte
% 
%start of Q3
set(0, 'DefaultFigureWindowStyle', 'docked')

global x y Vx Vy dt tempx tempy mass 
global numElec
global PlotSize MarkerSize 
t = 0;
tStop = 300;

plotx = 1000;
ploty = 1000;

numElec = 300;
counter =0;
x1 = 450;
x2 = 600;
y1=350;
y2=650;
y3=1000;

flipy = 1;
flipx = 1;
bX1 = [x1, x2, x2, x1, x1];
bY1 = [0, 0, y1, y1, 0];
bX2 = [x1, x2, x2, x1, x1];
bY2 = [y3, y3, y2, y2, y3];

whereElec = zeros(20:20);
tempDensity = zeros(20:20);
vOnX = 0.1;
vonY=0;
mass = 0.26*(9.109*10^-31);
x = randi(plotx,numElec,1);
y = randi(ploty,numElec,1);

%for assignment 3

eFieldx = vOnX/(100*10^-9);
force = eFieldx*1.6021e-19;
accX = force/mass;
accVectorX = ones(numElec,1);

for i = 1:1:numElec
    if x(i) > x1 +2 & x(i) < x2 -2 & (y(i) < y1 - 2 | y(i) > y2 -2)
        x(i) = x(i) + 151;
    end
end  


%eFieldy = vOnY/(100*10^-9);
%force = eFieldy*1.6021e-19;
 accY = force/mass;
 accVectorY = ones(numElec,1);

dCurrent = ones(numElec,0);
V = ones(numElec,1);
sumCurrent = 0;
avgCurrent = 0;
q = 1.6e-19;
p = 10e15;

V = V.*sqrt((1.38*10^-23).*300./mass);
Vx = (randn(numElec,1) .*V./1.41).*(1*10^9);
Vy = (randn(numElec,1).*V./1.41).*(1*10^9);
freeMeanPath = V(1) * 0.2*10^-12;
Vtest = Vx;
FMP = 0;
xTemp = zeros(numElec,1);
yTemp = zeros(numElec,1);
vTemp = zeros(numElec,1);

tempX = zeros(numElec,1);
tempY = zeros(numElec,1);

didScatter = zeros(numElec,1);
timeSinceScatter = zeros(numElec,1);
%Vy = ones(numElec,1) * V
 averageScatTime = 0;
 numOfScat = 0;
 scatTime = 0;
dt = 0.000000000000025;
probScat = 0.05;
%make Vx and Vy have random direction to start
for i = numElec:-1:1
    rx = rand();
    ry = rand();
    
    if rx < 0.5 
        Vx(i) = Vx(i) * -1;
    end 
    if ry < 0.5 
        Vy(i) = Vy(i) * -1;
    end
end


%main loop 
while t < tStop


    timeSinceScatter = timeSinceScatter +1;

    tempX = x;
    tempY=y;
    for i = 1:1:numElec
        
        for j = 1:1:50
            for k =1:1:75
                %add E field acceleration
               if (tempX(i)/13.3333) < k && (tempY(i)/40)<j
                   accVectorX(i) = Ex(j,k);
                   accVectorY(i) = Ey(j,k);
                   accVectorX(i)=accVectorX(i)*1.6021e-19*1e9/mass;
                   accVectorY(i)=accVectorY(i)*1.6021e-19*1e9/mass;
                   tempX(i) = 10000;
                   tempY(i) = 10000;
               end
            end
        end
    end
        
   
        
        randNum = rand();
        if randNum < probScat;
            Vx(i) = (randn(1) * V(1)/1.41)*(1*10^9);
            Vy(i) = (randn(1) * V(1)/1.41)*(1*10^9);
            averageScatTime = averageScatTime+timeSinceScatter(i);
            numOfScat = numOfScat +1;
            timeSinceScatter(i) = 0;
        end
        
        
   

    Vx = Vx + dt.*accVectorX.*1e7;
    Vy = Vy +dt.*accVectorY.*1e7;
    x = x + dt.*Vx;
    y = y +dt.*Vy;

    x(x>(plotx-2))=1;
    x(x<1)=(plotx-2);

    tempy = y >ploty-2 | y < 1;
    tempy = tempy*-1;
    tempy(tempy>=0)=1;

    Vy = Vy.*tempy;

    
    x(x>(plotx-2))=1;
x(x<1)=(plotx-2);
tempy = y >ploty-2 | y < 1; 
tempy = tempy*-1;
tempy(tempy>=0)=1;

%the following code is for specular reflection. This is where the diffusive
%code should be put if wanted
flipy = (y < y1-3 & x > x1-2 & x < x2+2 & Vy < 0 )|(y > y2-3 & y < y2+3 & x > x1-2 & x < x2+2 & Vy>0);
flipy = flipy*-1;
flipy(flipy>=0)=1;


flipx = (x>x1-4 & x<x2+4 & y >y2-2 & y > y2+5)|(x>x1-4 & y<y1+3 & x<x2+4 & y < y1-5);
flipx = flipx*-1;
flipx(flipx>=0)=1;

Vy = Vy.*tempy;
Vy = Vy.*flipy;
Vx = Vx.*flipx;

    Vt = ((Vx.^2 +Vy.^2).^0.5)./(1*10^9);
    T = (mass.*Vt.^2)./(1.38064852*10^-23); 
    a = subplot(2,1,1);
    plot(a,x,y,'.')
    title('Electron Model');

    hold on
    grid on
    drawnow

    plot(bX1, bY1, 'b-', 'LineWidth', 3);
hold on;

plot(bX2, bY2, 'b-', 'LineWidth', 3);
hold on;
drawnow

axis(a,[0 plotx 0 ploty])


    %step through next cycle
    t = t+1;

    prevT = (sum(T)/numElec);

    scatTime = averageScatTime/numOfScat;
    xTemp = Vx.^2;
    yTemp = Vy.^2;
    vTemp = ((xTemp + yTemp).^0.5)./(1*10^9);

    vTemp = sum(vTemp)/numElec;

    FMP = vTemp*scatTime*(dt);

    sumCurrent = 0;
    avgCurrent = 0;

    %assignment 3
    for r = 1:1:numElec
        dCurrent(r) = Vx(r)*p*q/1e9;
        sumCurrent = dCurrent(r)+sumCurrent;
    end

    avgCurrent = sumCurrent/numElec;

    b = subplot(2,1,2);
    title('Temperature Over Time');
    plot(b,dt*t,avgCurrent,'.');
    hold on
    grid on
    drawnow
    axis(a,[0 plotx 0 ploty]);
    axis(b,[0 dt*100 0 1000]);
    
    end

x1= ones(numElec,0);
y1= ones(numElec,0);
x1 = x;
y1 = y;
for i = 1: 1: 20
    for j = 1: 1: 20
        for k = 1: 1: numElec
            if x(k) < i*50 & y(k) < j*50
                whereElec(j,i) = whereElec(j,i) +1
                Vt = ((Vx(k)^2 +Vy(k)^2).^0.5)
                tempDensity(j,i) = (mass*Vt^2)/(1.38064852*10^-23) +tempDensity(j,i) 
                %to erase point
                x(k) = 10000
                y(k) = 10000
            end
        end
    end
end

c = subplot(2,2,3)

surf(c,whereElec)
title('Electron Density')
view(2)
shading interp
hold on
grid on
drawnow

d = subplot(2,2,4)

surf(d,tempDensity)
title('Temperature Density')
view(2)
shading interp
hold on
grid on
drawnow


