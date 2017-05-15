%Make FB2
fb2 = zeros(ndof);

%Hitta integral L3h
for i = 1 : length(Lsmdh)
   
    node1 = edge(1, Lsmdh(i)); node2 = edge(2, Lsmdh(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb2(node1, node2) = fb2(node1, node2) + ac * ksmd * l / 6;
    fb2(node2, node1) = fb2(node2, node1) + ac * ksmd * l / 6;
    
end

%Hitta integral L4
for i = 1: length(Lsol)
   
    node1 = edge(1, Lsol(i)); node2 = edge(2, Lsol(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb2(node1, node2) = fb2(node1, node2) + ac * ksol * l / 6;
    fb2(node2, node1) = fb2(node2, node1) + ac * ksol * l / 6;
    
end