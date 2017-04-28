%Make FB1
fb1 = zeros(ndof, 1);

%Hitta r�nders index:
Lsmdv = find(edge(5, :) == 3 & edge(4, :) >= 2/3);
Lsmdh = find(edge(5, :) == 3 & edge(4, :) < 2/3);
Lsol = find(edge(5, :) == 4);

%Hitta integral L3v
for i = Lsmdv(1) : Lsmdv(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) + qel * l / 2;
    fb1(node2) = fb1(node2) + qel * l / 2;
    
end

%Hitta integral L3h
for i = Lsmdh(1) : Lsmdh(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) - ac * Tinf * ksmd * l / 2;
    fb1(node2) = fb1(node2) - ac * Tinf * ksmd * l / 2;
    
end

%Hitta integral L4
for i = Lsol(1) : Lsol(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) - ac * Tinf * ksol * l / 2;
    fb1(node2) = fb1(node2) - ac * Tinf * ksol * l / 2;
    
end