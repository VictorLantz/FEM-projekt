
edofold = edof;
edof = [edof(:, 1), edof(:,2), edof(:,2)+ndof, edof(:, 3), edof(:, 3)+ndof, edof(:, 4), edof(:, 4) + ndof];
ndof = 2 * ndof;

%R�kna ut deltaT
deltaT = zeros(nelm,1);
for i  = 1 : nelm
   node1 = triangle(1, i); node2 = triangle(2, i); node3 = triangle(3, i);
   deltaT(i) =  1/3 * sum([Tstat(node1), Tstat(node2), Tstat(node3)]);
end


%R�kna ut K-matris och f-vektor:
K = zeros(ndof);
f = zeros(ndof, 1);
for i = 1:nelm
    Etemp = E(triangle(4,i));
    vtemp = v(triangle(4,i));
    alfatemp = alfa(triangle(4,i));
    
    D = Etemp/((1+vtemp)*(1-2*vtemp))*[1 - vtemp, vtemp, 0 ; vtemp, 1-vtemp, 0 ; 0, 0, 1/2*(1-2*vtemp)];

    Ke = plante(Ex(i, :), Ey(i, :), [2, 1], D);
    
    es = Etemp * alfatemp * deltaT(i) / (1 - 2 * vtemp) * [1 1 0];
    fe = plantf(Ex(i, :), Ey(i, :), [2, 1], es);
    
    [K, f] = assem(edof(i, :), K, Ke,f, fe);
end

%L�s ut t�jningar
bc = [bottompcb' , zeros(size(bottompcb,2),1) ; sidepcb' , zeros(size(sidepcb,2),1) ; middle' , zeros(size(middle,2),1)];
a = solveq(K, f, bc);

%Rita upp f�rskjutningar
ad = extract(edof, a);
plotpar = [1, 4, 2];
eldisp2(Ex, Ey, ad, plotpar, 1000);

%R�kna ut sp�nningar es och t�jningar ed
vm_el = zeros(nelm, 1);
for i = 1:nelm
    Etemp = E(triangle(4,i));
    vtemp = v(triangle(4,i));
    
    D = Etemp/((1+vtemp)*(1-2*vtemp))*[1 - vtemp, vtemp, 0 ; vtemp, 1-vtemp, 0 ; 0, 0, 1/2*(1-2*vtemp)];
    
    [es, et] = plants(Ex(i,:), Ey(i,:), [2,1], D, ad(i,:)); 
    vm_el(i) = sqrt(es(1)^2 + es(2)^2 + 3 * es(3)^2 - es(1) * es(2));
end

%Plocka nod-sp�nningar och t�jningar
vm_node = zeros(size(point',1),1);
for i=1:size(point',1) 
    [c0,c1]=find(edofold(:,2:4)==i); 
    vm_node(i,1)=sum(vm_el(c0))/size(c0,1); 
end

vm = extract(edofold, vm_node);
vmtot = [vm ;vm];
fill(extot', eytot', vmtot');

