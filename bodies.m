%Tar reda p� vilka kroppar som �r vilka och vilka edges som �r vilka i v�r
%mesh.

%Skapar vektorer med materialkonstanter. Mappar rätt konstant till rätt
%kropp
k = [0 0 0 0];
c = [0 0 0 0];
ro = [0 0 0 0];

%% Hittar SMD-kroppen:
i = 1;
while ~(point(1,i) == 0 && point(2,i) == 6*10^-4)   
    i = i+1;
end
col = 1;
while ~sum(find(triangle(1:3, col) == i))
    col = col+1;
end
k(triangle(4,col)) = ksmd;
c(triangle(4,col)) = csmd;
ro(triangle(4,col)) = rosmd;


%% Hittar PCB-kroppen:
i = 1;
while ~(point(1,i) == 0 && point(2,i) == 0)   
    i = i+1;
end
col = 1;
while ~sum(find(triangle(1:3, col) == i))
    col = col+1;
end
k(triangle(4,col)) = kpcb;
c(triangle(4,col)) = cpcb;
ro(triangle(4,col)) = rpcb;
% k = [ksol kpcb ksmd];
% c = [csol cpcb csmd];
% ro = [rsol rpcb rosmd];


%% Hittar Solder-kroppen
% i = 1;
% while ~(point(1,i) == 1*10^-3 && point(2,i) == 2*10^-4)   
%     i = i+1;
% end 
i = 3; %OBS FULL�SNING F�R INDEXERING FUNKADE INTE PGA MATLAB
col = 1;
while ~sum(find(triangle(1:3, col) == i & k(triangle(4, col)) == 0)) %betyder att den �nnu inte blivit tilldelad v�rde
    col = col+1;
end
k(triangle(4,col)) = ksol;
c(triangle(4,col)) = csol;
ro(triangle(4,col)) = rsol;
% k = [ksol kpcb ksmd];
% c = [csol cpcb csmd];
% ro = [rsol rpcb rosmd];


%% S�tter in v�rdet f�r "den andra" SMD-kroppen.

i = find(not(k));
k(i) = ksmd;