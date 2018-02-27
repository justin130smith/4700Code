
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
            volt(n) = 0;
        
        elseif j == ny
            G(n, n) = -3;
            G(n, n-1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
            
        elseif j == 1
            G(n, :) = 0;
            G(n, n) = -3;
            G(n, n+1) = 1;
            G(n, n-ny) = 1;
            G(n, n+ny) = 1;
        else
            G(n, n) = -4;
            G(n, n-1) = 1;
            G(n, n+1) = 1;
            G(n, n-ny) = 1;
            G(n, n+ny) = 1;
            
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

figure(2)
surf(temp)
shading interp

