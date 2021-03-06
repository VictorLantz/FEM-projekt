%% Plockar information ur mesh och skapar edof f�r temperaturf�rdelning:
nelm=length(triangle(1,:)) ;
edof(:,1)=1:nelm  ;
edof(:,2:4)=triangle(1:3,:)' ;
ndof=max(max(triangle(1:3,:))); 
[Ex,Ey]=coordxtr(edof,point',(1:ndof)',3);

%% Skapar index f�r kroppar och r�nder:
bodies;
edges;


%% Skapa K-matris och C-matris
K = zeros(ndof);
C = zeros(ndof);
for i = 1:nelm
    Ke = flw2te(Ex(i, :), Ey(i, :), 1, k(triangle(4,i)));
    K = assem(edof(i, :), K, Ke);
    
    Ce = plantml(Ex(i, :), Ey(i, :), ro(triangle(4,i))*c(triangle(4,i)));
    C = assem(edof(i, :), C, Ce);
end
%% Skapa fB1 enligt ekvationer
makeFB1;

%% Skapa fB2 enligt ekvationer
makeFB2;


%% Skapar startv�rden, storlek p� tidssteg och koordinatmatris till plot
T = ones(ndof, 1) * T0;
dt = 0.2;
time = 0;
extot = [Ex ; -Ex];
eytot = [Ey ; Ey];
deg = sprintf('%c', char(176));

%% L�ser station�r temperatur
Tstat = solveq((K + fb2),fb1);
ed = extract(edof, Tstat);
edtot = [ed ; ed];
figure(1);
h = fill(extot', eytot', edtot');
if meshlines == 0
       set(h,'EdgeColor','none') 
end
colorbar; title('Station�r Temperaturf�rdelning'); xlabel('x-led, m'); ylabel('y-led, m'); 

%% L�ser tidsteg och plottar temperaturen. Observera att main avg�r om detta steg utf�rs eller inte.
if runtempstep == 1
    
    figure(2);
    for i = 0:50
    clf;
    ed = extract(edof, T);
    edtot = [ed ; ed];
    h = fill(extot', eytot', edtot');
    if meshlines == 0
       set(h,'EdgeColor','none') 
    end
    if time == 0
       caxis([30 34]); 
    end
    colorbar;
    title(['Temperaturf�rdelning (' deg 'C), Tid = ' num2str(time) ' s']);
    xlabel('x-led, m'); ylabel('y-led, m'); 
    T = solveq((C/dt + K + fb2),(C/dt*T + fb1)); %Timestep
    time= time + dt;
    waitforbuttonpress
    end

end



