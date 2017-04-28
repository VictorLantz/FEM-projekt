%Hitta ränders index:

%Hitta index för Lsol
i = 1;
xkrav1 = (point(1, edges(1, i)) > 0.61 * 10^-3) && (point(1, edges(1, i)) < 1.0 * 10^-3);
ykrav1 = (point(2, edges(1, i)) > 0.2 * 10^-3) && (point(2, edges(1, i)) < 0.6 * 10^-3);
xkrav2 = (point(1, edges(2, i)) > 0.61 * 10^-3) && (point(1, edges(2, i)) < 1.0 * 10^-3);
ykrav2 = (point(2, edges(2, i)) > 0.2 * 10^-3) && (point(2, edges(2, i)) < 0.6 * 10^-3);

while ~((xkrav1 && ykrav1) || (xkrav2 && ykrav2))
    i = i + 1;
    xkrav1 = (point(1, edges(1, i)) > 0.61 * 10^-3) && (point(1, edges(1, i)) < 1.0 * 10^-3);
    ykrav1 = (point(2, edges(1, i)) > 0.2 * 10^-3) && (point(2, edges(1, i)) < 0.6 * 10^-3);
    xkrav2 = (point(1, edges(2, i)) > 0.61 * 10^-3) && (point(1, edges(2, i)) < 1.0 * 10^-3);
    ykrav2 = (point(2, edges(2, i)) > 0.2 * 10^-3) && (point(2, edges(2, i)) < 0.6 * 10^-3);
end
indexLsol = edge(5, i);

% Lsmdv = find(edge(5, :) == indexLsmdv);
% Lsmdh = find(edge(5, :) == indexLsmdh);
% Lsol = find(edge(5, :) == indexLsol);