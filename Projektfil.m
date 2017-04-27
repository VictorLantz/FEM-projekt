clear; load('konstanter'); load('uglymesh');

nelm=length(triangle(1,:)) 
edof(:,1)=1:nelm  
edof(:,2:4)=triangle(1:3,:)' 
coord=point' ;
ndof=max(max(triangle(1:3,:))); 
[Ex,Ey]=coordxtr(edof,coord,(1:ndof)',3);
eldraw2(Ex,Ey,[1,4,1]) ;