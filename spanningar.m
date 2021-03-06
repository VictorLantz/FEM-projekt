%% Skapa ny edof med fler frihetsgrader. X-komponenterna i noderna ges samma
%index som tidigare. Y-komponenterna ges samma index som sina noder men +
%ndof f�r att inte f� index-�verlapp.
edofold = edof;
edof = [edof(:, 1), edof(:,2), edof(:,2)+ndof, edof(:, 3), edof(:,3)+ndof, edof(:, 4), edof(:, 4) + ndof];
ndof = 2 * ndof;

%% R�kna ut deltaT
deltaT = zeros(nelm,1);
for i  = 1 : nelm
   node1 = triangle(1, i); node2 = triangle(2, i); node3 = triangle(3, i);
   deltaT(i) =  1/3 * sum([Tstat(node1), Tstat(node2), Tstat(node3)]);
end
deltaT = deltaT - T0;


%% R�kna ut K-matris och f-vektor:
K = zeros(ndof);
f = zeros(ndof, 1);
for i = 1:nelm
    Etemp = E(triangle(4,i));
    vtemp = v(triangle(4,i));
    alfatemp = alfa(triangle(4,i));
    
    D = Etemp * [1 - vtemp, vtemp, 0 ; vtemp, 1-vtemp, 0 ; 0, 0, 1/2*(1-2*vtemp)] /((1+vtemp)*(1-2*vtemp));
    
    Ke = plante(Ex(i, :), Ey(i, :), [2, 1], D);
    
    %Notera att e0 h�r �r D*Epsilon_0 i rapporten. Den �r kort och gott e0
    %h�r f�r att det �r snyggare att skriva.
    e0 = Etemp * alfatemp * deltaT(i) / (1 - 2 * vtemp) * [1 1 0];
    fe = plantf(Ex(i, :), Ey(i, :), [2, 1], e0);
    
    [K, f] = assem(edof(i, :), K, Ke,f, fe);
end

%% L�s ut f�rskjutningar
bc = [bottompcb' , zeros(size(bottompcb,2),1) ; sidepcb' , zeros(size(sidepcb,2),1) ; middle' , zeros(size(middle,2),1)];
a = solveq(K, f, bc);

%% Rita upp f�rskjutningar
figure(3);
ad = extract(edof, a);
plotpar = [1, 4, 2];
xlabel('x-led, m'); ylabel('y-led, m'); title('F�rskjutningar i Kroppen, skala 1:1000');
eldisp2(Ex, Ey, ad, plotpar, 1000);

%% R�kna ut sp�nningar es och t�jningar ed
vm_el = zeros(nelm, 1);
for i = 1:nelm
    Etemp = E(triangle(4,i));
    vtemp = v(triangle(4,i));
    
    D = Etemp * [1 - vtemp, vtemp, 0 ; vtemp, 1-vtemp, 0 ; 0, 0, 1/2*(1-2*vtemp)] /((1+vtemp)*(1-2*vtemp));%D = Etemp/(1-vtemp^2) * [1 v 0 ; v 1 0 ; 0 0 1/2*(1-v)];
    e0 = Etemp * alfatemp * deltaT(i) / (1 - 2 * vtemp) * [1 1 0];
    [es, et] = plants(Ex(i,:), Ey(i,:), [2,1], D, ad(i,:)); 
    es = es-e0;
    ez = Etemp * vtemp * (et(1) + et(2))/((1+vtemp)*(1-2*vtemp)) - Etemp * alfatemp * deltaT(i) / (1 - 2 * vtemp);
    vm_el(i) = sqrt(es(1)^2 + es(2)^2 + ez^2 + 3 * es(3)^2 - es(1) * es(2) - es(1) * ez - ez * es(2));
end

%% Plocka ut nod-sp�nningar och t�jningar
vm_node = zeros(size(point',1),1);
for i=1:size(point',1) 
    [c0,c1]=find(edofold(:,2:4)==i); 
    vm_node(i,1)=sum(vm_el(c0))/size(c0,1); 
end

vm = extract(edofold, vm_node);
vmtot = [vm ;vm];
figure(4);
h = fill(extot', eytot', vmtot');
colorbar;
if meshlines == 0
       set(h,'EdgeColor','none') 
end
xlabel('x-led, m'); ylabel('y-led, m'); title('Von-Mise-Sp�nningar i Kroppen (N/m^2)');



