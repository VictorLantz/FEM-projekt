clear; load('konstanter'); load('uglymesh');

%Skapar vektorer f�r att l�tt plocka ut konstanter till r�tt kropp.
% 1 �r sol, 2 �r pcb och 3 �r smd.
k = [ksol kpcb ksmd];
c = [csol cpcb csmd];
ro = [rsol rpcb rosmd];


%Plocka ut m�g ur mesh
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

T = ones(ndof, 1) * T0;
dt = 0.001;
extot = [Ex ; -Ex];
eytot = [Ey ; Ey];

for i = 0:100
clf;
ed = extract(edof, T);
edtot = [ed ; ed];

fill(extot', eytot', edtot');
colorbar;
timestep;
waitforbuttonpress
end