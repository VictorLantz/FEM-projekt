%Hitta ränders index:
indexL3v = find(edge(5, :) == 3 & edge(4, :) >= 2/3);
indexL3h = find(edge(5, :) == 3 & edge(4, :) < 2/3);
indexL4 = find(edge(5, :) == 4);