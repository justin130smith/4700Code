clearvars
clearvars -GLOBAL
close all
format shorte

set(0, 'DefaultFigureWindowStyle', 'docked')

global x y Vx Vy dt tempx tempy mass 
global numElec
global PlotSize MarkerSize
t = 0;
tStop = 80;

plotx = 100;
ploty = 200;
prevT = 300;

numElec = 100;

whereElec = zeros(20:20)
tempDensity = zeros(20:20)

mass = 0.26*(9.109*10^-31);
x = randi(plotx,numElec,1);
y = randi(ploty,numElec,1);

%for assignment 3

vOnX = 0.1;
vOnY = 0;
eFieldx = vOnX/(100*10^-9);
force = eFieldx*1.6021e-19;
accX = force/mass;
accVectorX = ones(numElec,1).*accX.*1e9;

eFieldy = vOnY/(100*10^-9);
force = eFieldy*1.6021e-19;
accY = force/mass;
accVectorY = ones(numElec,1).*accX.*1e9;

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


didScatter = zeros(numElec,1);
timeSinceScatter = zeros(numElec,1);
%Vy = ones(numElec,1) * V
 averageScatTime = 0;
 numOfScat = 0;
 scatTime = 0;
dt = 0.000000000000006;
probScat = 1 - exp((-dt)/(0.2*10^-12));
%make Vx and Vy have random direction to start
for i = numElec:-1:1
    rx = rand();
    ry = rand();
    fprintf('r = %i\n',rx)
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

    for i = 1:1:numElec
        randNum = rand()
        if randNum < probScat;
            Vx(i) = (randn(1) * V(1)/1.41)*(1*10^9);
            Vy(i) = (randn(1) * V(1)/1.41)*(1*10^9);
            averageScatTime = averageScatTime+timeSinceScatter(i);
            numOfScat = numOfScat +1;
            timeSinceScatter(i) = 0;
        end
    end

    Vx = Vx + dt.*accVectorX;
   
    x = x + dt.*Vx;
    y = y +dt.*Vy;

    x(x>(plotx-2))=1;
    x(x<1)=(plotx-2);

    tempy = y >ploty-2 | y < 1;
    tempy = tempy*-1;
    tempy(tempy>=0)=1;

    Vy = Vy.*tempy;

    Vt = ((Vx.^2 +Vy.^2).^0.5)./(1*10^9);
    T = (mass.*Vt.^2)./(1.38064852*10^-23); 
    a = subplot(2,1,1);
    plot(a,x,y,'.')
    title('Electron Model');

    hold on
    grid on
    drawnow


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
    title('Current over Time');
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
            if x(k) < i*5 & y(k) < j*10
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

