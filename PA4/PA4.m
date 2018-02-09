ny = 50;
nx = 50;
G = sparse(nx*ny,nx*ny);
remap = sparse(nx,ny);
for i =1:1: nx
    for j =1:1:ny
        n = j + (i-1) *ny;
        
        if i == 1
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j == 1
            G(n,:) = 0;
            G(n,n) = 1;
        elseif i == nx
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j == ny
            G(n,:) = 0;
            G(n,n) = 1;
            
        else
            
            nxm = j + (i-2) *ny;
            nxp = j + i*ny;
            nym = j-1 +(i-1)*ny;
            nyp = j+1 +(i-1)*ny;
            
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
            
        end
    end
end

spy(G)

[E,D] = eigs(G,9,'SM')


F = E(:,2);
for i = 1:1:nx
    for j = 1:1:ny
         n = j + (i-1) *ny;
        Remap(i,j)= F(n);
    end
end


% plot(D,'o')
% [X,Y]=meshgrid(1:1:10,1:1:10)
% for k = 1:1:9
%     for i = 1:1:nx
%         for j = 1:1:ny
%             Remap(i,j)= E(k)
%         end
%     end
% end
% 
%     surf(X,Y,Remap)
%     shading interp