
edof = [edof(:, 1), edof(:,2), edof(:,2)+ndof, edof(:, 3), edof(:, 3)+ndof, edof(:, 4), edof(:, 4) + ndof];
ndof = 2 * ndof;

%Räkna ut deltaT
deltaT = zeros(nelm,1);

for i  = 1 : nelm
   node1 = triangle(1, i); node2 = triangle(2, i); node3 = triangle(3, i);
   deltaT(i) =  1/3 * sum([Tstat(node1), Tstat(node2), Tstat(node3)]);
end


%Räkna ut K-matris:
K = zeros(ndof);
f = zeros(ndof, 1);
for i = 1:nelm
    Etemp = E(triangle(4,i));
    vtemp = v(triangle(4,i));
    alfatemp = alfa(triangle(4,i));
    
    D = Etemp/((1+vtemp)*(1-2*vtemp))*[1 - vtemp, vtemp, 0 ; vtemp, 1-vtemp, 0 ; 0, 0, 1/2*(1-2*vtemp)];

    Ke = plante(Ex(i, :), Ey(i, :), [2, 1], D);
    
    es = alfatemp * deltaT(i) / (1 - 2 * vtemp) * [1 1 0];
    fe = plantf(Ex(i, :), Ey(i, :), [2, 1], es);
    
    [K, f] = assem(edof(i, :), K, Ke,f, fe);
end

bc = [bottompcb' , zeros(size(bottompcb,2),1) ; sidepcb' , zeros(size(sidepcb,2),1)];

a = solveq(K, f, bc);
