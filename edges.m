%Hitta r�nders index:

%% Hitta index f�r Lsol genom att hitta noder som uppfyller specifika positionskrav
%Loopen stegar igenom edges tills den hittar det index i edges som anv�nds
%f�r att identifiera den rand vi s�ker.
i = 1;
xkrav1 = (point(1, edge(1, i)) > 0.61 * 10^-3) && (point(1, edge(1, i)) < 1.0 * 10^-3);
ykrav1 = (point(2, edge(1, i)) > 0.2 * 10^-3) && (point(2, edge(1, i)) < 0.6 * 10^-3);
xkrav2 = (point(1, edge(2, i)) > 0.61 * 10^-3) && (point(1, edge(2, i)) < 1.0 * 10^-3);
ykrav2 = (point(2, edge(2, i)) > 0.2 * 10^-3) && (point(2, edge(2, i)) < 0.6 * 10^-3);

while ~((xkrav1 && ykrav1) || (xkrav2 && ykrav2))
    i = i + 1;
    xkrav1 = (point(1, edge(1, i)) > 0.61 * 10^-3) && (point(1, edge(1, i)) < 1.0 * 10^-3);
    ykrav1 = (point(2, edge(1, i)) > 0.2 * 10^-3) && (point(2, edge(1, i)) < 0.6 * 10^-3);
    xkrav2 = (point(1, edge(2, i)) > 0.61 * 10^-3) && (point(1, edge(2, i)) < 1.0 * 10^-3);
    ykrav2 = (point(2, edge(2, i)) > 0.2 * 10^-3) && (point(2, edge(2, i)) < 0.6 * 10^-3);
end
%En vektor skapas som inneh�ller index f�r alla de bitar i vektorn "edges"
%som h�r till den intressanta randen.
indexLsol = edge(5, i);

%% Hitta index f�r Lsmdv

i = 1;
xkrav1 = (point(1, edge(1, i)) > 0) && (point(1, edge(1, i)) < 0.2 * 10^-3);
ykrav1 = (point(2, edge(1, i)) == 6 * 10^-4);
xkrav2 = (point(1, edge(2, i)) > 0) && (point(1, edge(2, i)) < 0.2 * 10^-3);
ykrav2 = (point(2, edge(2, i)) == 6 * 10^-4);

while ~((xkrav1 && ykrav1) && (xkrav2 && ykrav2))
    i = i + 1;
    xkrav1 = (point(1, edge(1, i)) > 0) && (point(1, edge(1, i)) < 0.2 * 10^-3);
    ykrav1 = (point(2, edge(1, i)) == 6 * 10^-4);
    xkrav2 = (point(1, edge(2, i)) > 0) && (point(1, edge(2, i)) < 0.2 * 10^-3);
    ykrav2 = (point(2, edge(2, i)) == 6 * 10^-4);
end
indexLsmdv = edge(5, i);


%% Hitta index f�r Lsmdh

i = 1;
xkrav1 = (point(1, edge(1, i)) > 0.2 * 10^-3) && (point(1, edge(1, i)) < 1 * 10^-3);
ykrav1 = (point(2, edge(1, i)) == 6 * 10^-4);
xkrav2 = (point(1, edge(2, i)) > 0.2 * 10^-3) && (point(1, edge(2, i)) < 1 * 10^-3);
ykrav2 = (point(2, edge(2, i)) == 6 * 10^-4);

while ~((xkrav1 && ykrav1) && (xkrav2 && ykrav2))
    i = i + 1;
    xkrav1 = (point(1, edge(1, i)) > 0.2 * 10^-3) && (point(1, edge(1, i)) < 1 * 10^-3);
    ykrav1 = (point(2, edge(1, i)) == 6 * 10^-4);
    xkrav2 = (point(1, edge(2, i)) > 0.2 * 10^-3) && (point(1, edge(2, i)) < 1 * 10^-3);
    ykrav2 = (point(2, edge(2, i)) == 6 * 10^-4);
end
indexLsmdh = edge(5, i);

Lsmdv = find(edge(5, :) == indexLsmdv);
Lsmdh = find(edge(5, :) == indexLsmdh);
Lsol = find(edge(5, :) == indexLsol);

%% Hitta nodindex f�r PCB
%Detta anv�nds f�rst i sp�nningsbiten, d� dessa vektorer inneh�ller index
%f�r de frihetsgrader som har randvillkor f�r f�rskjutning.
nodex = point(1,:);
nodey = point(2,:);
sidepcb = find( nodex > 0.00099999999999);
bottompcb = find(nodey == 0) + ndof;
middle = find( nodex == 0 );