%Make FB1
fb1 = zeros(ndof, 1);

%% R�kna ut smd v�nster
for i = 1 : length(Lsmdv)
   
    node1 = edge(1, Lsmdv(i)); node2 = edge(2, Lsmdv(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) + qel * l / 2;
    fb1(node2) = fb1(node2) + qel * l / 2;
    
end

%% R�kna ut smd h�ger
for i = 1 : length(Lsmdh)
   
    node1 = edge(1, Lsmdh(i)); node2 = edge(2, Lsmdh(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) + ac * Tinf * l / 2;
    fb1(node2) = fb1(node2) + ac * Tinf * l / 2;
    
end

%% R�kna ut integral solder
for i = 1: length(Lsol)
   
    node1 = edge(1, Lsol(i)); node2 = edge(2, Lsol(i));
    l = sqrt( (point(1, node1)-point(1, node2))^2 + (point(2, node1)-point(2, node2))^2);
    fb1(node1) = fb1(node1) + ac * Tinf * l / 2;
    fb1(node2) = fb1(node2) + ac * Tinf * l / 2;
    
end