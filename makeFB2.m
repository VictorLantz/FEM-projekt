%Make FB2
fb2 = zeros(ndof);

%Hitta ränders index:
Lsmdh = find(edge(5, :) == 3 & edge(4, :) < 2/3);
Lsol = find(edge(5, :) == 4);

%Hitta integral L3h
for i = Lsmdh(1) : Lsmdh(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb2(node1, node2) = fb2(node1, node2) - ac * ksmd * l / 6;
    fb2(node2, node1) = fb2(node2, node1) - ac * ksmd * l / 6;
    
end

%Hitta integral L4
for i = Lsol(1) : Lsol(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb2(node1, node2) = fb2(node1, node2) - ac * ksol * l / 2;
    fb2(node2, node1) = fb2(node2, node1) - ac * ksol * l / 2;
    
end