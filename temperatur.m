%Plockar information ur mesh
nelm=length(triangle(1,:)) ;
edof(:,1)=1:nelm  ;
edof(:,2:4)=triangle(1:3,:)' ;
%coord=point' ;
ndof=max(max(triangle(1:3,:))); 
[Ex,Ey]=coordxtr(edof,point',(1:ndof)',3);

%Skapar index f�r kroppar och kanter
bodies;
edges;

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


%Skapar startvärden, storlek på tidssteg och koordinatmatris till plot
T = ones(ndof, 1) * T0;
dt = 1;
time = 0;
extot = [Ex ; -Ex];
eytot = [Ey ; Ey];

%L�ser station�r temperatur
Tstat = solveq((K + fb2),fb1);
ed = extract(edof, Tstat);
edtot = [ed ; ed];
figure(1);
h = fill(extot', eytot', edtot');
if meshlines == 0
       set(h,'EdgeColor','none') 
end
colorbar; title('Station�r Temperaturf�rdelning'); xlabel('x-led, m'); ylabel('y-led, m'); 

% Löser tidsteg och plottar temperaturen.
if runtempstep == 1
    
    figure(2);
    for i = 0:10
    clf;
    ed = extract(edof, T);
    edtot = [ed ; ed];
    h = fill(extot', eytot', edtot');
    if meshlines == 0
       set(h,'EdgeColor','none') 
    end
    colorbar;
    title(['Tidsberoende Temperaturf�rdelning, Tid = ' num2str(time) 'sekunder']);
    xlabel('x-led, m'); ylabel('y-led, m'); 
    T = solveq((C/dt + K + fb2),(C/dt*T + fb1)); %Timestep
    time= time + dt;
    waitforbuttonpress
    end

end



