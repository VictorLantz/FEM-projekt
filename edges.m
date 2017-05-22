%Hitta ränders index:

%% Hitta index för Lsol genom att hitta noder som uppfyller specifika positionskrav
%Loopen stegar igenom edges tills den hittar det index i edges som används
%för att identifiera den rand vi söker.
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
%En vektor skapas som innehåller index för alla de bitar i vektorn "edges"
%som hör till den intressanta randen.
indexLsol = edge(5, i);

%% Hitta index för Lsmdv

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


%% Hitta index för Lsmdh

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

%% Hitta nodindex för PCB
%Detta används först i spänningsbiten, då dessa vektorer innehåller index
%för de frihetsgrader som har randvillkor för förskjutning.
nodex = point(1,:);
nodey = point(2,:);
sidepcb = find( nodex > 0.00099999999999);
bottompcb = find(nodey == 0) + ndof;
middle = find( nodex == 0 );