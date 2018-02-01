sizex = 10
sizey = 10
V = zeros(sizex, sizey)
V(:,1) = 1
V(:,sizex) = 1

iterations = 7
loopVar = 0

while loopVar < iterations
    
    for i = 2:1:sizex-1
    for j = 2:1:sizey-1  
    V(i,j) = (V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1))/4
    
    end
    
    end
    
    
    
    loopVar = loopVar +1
end

surf(V)
view(2)
shading interp