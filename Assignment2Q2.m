%THE COMMENTS ARE FOR MODIFYING THE SIZING OF THE MESHGRID, BOTTLE NECK AND
%RESISTIVITY
%current = zeros(10);
%size = [1 2 3 4 5 6 7 8 9 10];
%for z = 1:1:10
nx = 50;
ny = 75;

G = sparse(nx*ny);
volt = zeros(nx*ny);

s1 = 1 ;
s2 = (1*10^-2)+z/15;
innerX = nx*0.35;
outerX = nx*0.6;
innerY = ny*0.35;
outerY = ny*0.6;

cMap = ones(nx,ny);

for i =1:1:nx
    for j=1:1:ny
        if i > innerX && i < outerX && (j < innerY||j > outerY)
            cMap(i,j) = s2;
        end
    end
end

for i = 1:1:nx
     for j = 1:1:ny
         
         n = j + (i-1)*ny;

         if i == 1
             G(n, :) = 0;
             G(n, n) = 1;
             volt(n) = 1;
         
         elseif i == nx
             G(n, :) = 0;
             G(n, n) = 1;
             volt(n) = 0;
         
         
         elseif j == ny
             
             if i < outerX && i > innerX 
                 G(n, n) = -3;
                 G(n, n+1) = s2;
                 G(n, n+ny) = s2;
                 G(n, n-ny) = s2;

             else
                 G(n, n) = -3;
                 G(n, n+1) = s1;
                 G(n, n+ny) = s1;
                 G(n, n-ny) = s1;
         
             end
             
         elseif j == 1
             if   outerX > i && i > innerX
                 G(n, n) = -3;
                 G(n, n+1) = s2;
                 G(n, n+ny) = s2;
                 G(n, n-ny) = s2;

             else
                 G(n, n) = -3;
                 G(n, n+1) = s1;
                 G(n, n+ny) = s1;
                 G(n, n-ny) = s1;

             end
             
         else
             
             if i > innerX && i < outerX && (j < innerY||j > outerY)
                 G(n, n) = -4;
                 G(n, n+1) = s2;
                 G(n, n-1) = s2;
                 G(n, n+ny) = s2;
                 G(n, n-ny) = s2;
                
                 
                 
             else
                 G(n, n) = -4;
                 G(n, n+1) = s1;
                 G(n, n-1) = s1;
                 G(n, n+ny) = s1;
                 G(n, n-ny) = s1;
                 
             end
         
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
