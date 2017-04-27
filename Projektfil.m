clear; load('konstanter'); load('uglymesh');

%Skapar vektorer för att lätt plocka ut konstanter till rätt kropp.
% 1 är sol, 2 är pcb och 3 är smd.
k = [0 ksol kpcb ksmd];
c = [0 csol cpcb csmd];
ro = [0 rsol rpcb rosmd];


%Plocka ut mög ur mesh
nelm=length(triangle(1,:)) ;
edof(:,1)=1:nelm  ;
edof(:,2:4)=triangle(1:3,:)' ;
coord=point' ;
ndof=max(max(triangle(1:3,:))); 
[Ex,Ey]=coordxtr(edof,coord,(1:ndof)',3);
%eldraw2(Ex,Ey,[1,4,1]) ;

K = zeros(ndof);
C = zeros(ndof);
%Skapa K-matris och C-matris
for i = 1:nelm
    Ke = flw2te(Ex(i, :), Ey(i, :), 1, k(triangle(4,i)));
    K = assem(edof(i, :), K, Ke);
    
    Ce = plantml(Ex(i, :), Ey(i, :), ro(triangle(4,i))*c(triangle(4,i)));
    C = assem(edof(i, :), C, Ce);
end

%Skapa fB1
makeFB1;


%Skapa fB2
makeFB2;