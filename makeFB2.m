%Make FB2
fb2 = zeros(ndof);

%% Räkna ut integral LSMDh
for i = 1 : length(Lsmdh)
   
    node1 = edge(1, Lsmdh(i)); node2 = edge(2, Lsmdh(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb2(node1, node2) = fb2(node1, node2) + ac * l / 6;
    fb2(node2, node1) = fb2(node2, node1) + ac * l / 6;
    fb2(node1, node1) = fb2(node1, node1) + ac * l / 3;
    fb2(node2, node2) = fb2(node2, node2) + ac * l / 3;
    
end

%% Räkna ut integral Lsolder
for i = 1: length(Lsol)
   
    node1 = edge(1, Lsol(i)); node2 = edge(2, Lsol(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb2(node1, node2) = fb2(node1, node2) + ac * l / 6;
    fb2(node2, node1) = fb2(node2, node1) + ac * l / 6;
    fb2(node1, node1) = fb2(node1, node1) + ac * l / 3;
    fb2(node2, node2) = fb2(node2, node2) + ac * l / 3;
    
end