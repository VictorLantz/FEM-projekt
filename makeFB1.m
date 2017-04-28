%Make FB1
fb1 = zeros(ndof, 1);

%Hitta ränders index:
indexL3v = find(edge(5, :) == 3 & edge(4, :) >= 2/3);
indexL3h = find(edge(5, :) == 3 & edge(4, :) < 2/3);
indexL4 = find(edge(5, :) == 4);

%Hitta integral L3v
for i = indexL3v(1) : indexL3v(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) + qel * l / 2;
    fb1(node2) = fb1(node2) + qel * l / 2;
    
end

%Hitta integral L3h
for i = indexL3h(1) : indexL3h(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) - ac * Tinf * ksmd * l / 2;
    fb1(node2) = fb1(node2) - ac * Tinf * ksmd * l / 2;
    
end

%Hitta integral L4
for i = indexL4(1) : indexL4(end)
   
    node1 = edge(1, i); node2 = edge(2, i);
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) - ac * Tinf * ksol * l / 2;
    fb1(node2) = fb1(node2) - ac * Tinf * ksol * l / 2;
    
end