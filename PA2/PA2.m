clearvars
clearvars -GLOBAL
close all
format shorte

set(0, 'DefaultFigureWindowStyle', 'docked')

global x y Vx force mass
global numElec
global MarkerSize
t = 0
tStop = 20
MarkerSize = 14

x = 0
y = 0
Vx = 0

while t < tStop
r = rand*20
a = subplot(2,1,1)
Vx = Vx+0.2
x = x + Vx

plot(a,t,x,'o')
hold on
grid on
drawnow

b = subplot(2,1,2)

plot(b,t,Vx,'o')

axis([a,b],[0 80 0 30])
t = t+1
hold on
grid on
drawnow
if r < 1
   Vx = 0 
end
pause(0.005)

end