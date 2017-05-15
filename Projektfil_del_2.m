%Räkna ut deltaT

deltaT = zeros(nelm,1);

for i  = 1 : nelm
   node1 = triangle(1, i); node2 = triangle(2, i); node3 = triangle(3, i);
   deltaT =  1/3 * sum([Tstat(node1), Tstat(node2), Tstat(node3)]);
    
end