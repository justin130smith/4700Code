
nx = 50;
ny = 75;
G = sparse(nx*ny);
volt = zeros(nx*ny);

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
         volt(n) = 1;
         
     elseif j == 1
         G(n, :) = 0;
         G(n, n) = 1;
         
     elseif j == ny
         G(n, :) = 0;
         G(n, n) = 1;
         
     else
         G(n, n) = -4;
         G(n, n+1) = 1;
         G(n, n-1) = 1;
         G(n, n+ny) = 1;
         G(n, n-ny) = 1;
     end
 end
end

E = G\volt;
figure(1)
spy(G);


temp = zeros(nx, ny);

for i = 1:1:nx
     for j = 1:1:ny
        n = j + (i-1)*ny;
        temp(i,j) = E(n);
     end
end

figure(2)
surf(temp)
shading interp

analytical = zeros(50,50);

x = linspace(-10, 10, 50);
y = linspace(0, 30, 50);
[x1, y2] = meshgrid(x,y);

a = 30;
b = 10;

for n = 1:2:600
    
 analytical = analytical + cosh(n*pi*x1/a)./(n*cosh(n*pi*b/a)).*sin(n*pi*y2/a);
 realAnalytical = analytical*4/pi
 figure(3)
 
 surf(x, y, realAnalytical)
 shading interp
 pause(0.005);
 
end
