% This script is written and read by pdetool and should NOT be edited.
% There are two recommended alternatives:
 % 1) Export the required variables from pdetool and create a MATLAB script
 %    to perform operations on these.
 % 2) Define the problem completely using a MATLAB script. See
 %    http://www.mathworks.com/help/pde/examples/index.html for examples
 %    of this approach.
function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
pdetool('snapon','on');
set(ax,'DataAspectRatio',[1 0.50000000000000011 1]);
set(ax,'PlotBoxAspectRatio',[2.9999999999999996 1.9999999999999996 2500]);
set(ax,'XLim',[-0.0011999999999999999 0.0011999999999999999]);
set(ax,'YLim',[-0 0.00080000000000000004]);
set(ax,'XTick',[ -0.0011999999999999999,...
 -0.0009999999999999998,...
 -0.00079999999999999993,...
 -0.00059999999999999984,...
 -0.00039999999999999986,...
 -0.00019999999999999987,...
 0,...
 0.00019999999999999987,...
 0.00039999999999999986,...
 0.00059999999999999984,...
 0.00079999999999999993,...
 0.0009999999999999998,...
 0.0011999999999999999,...
]);
set(ax,'YTick',[ 0,...
 0.0001,...
 0.00020000000000000001,...
 0.00030000000000000003,...
 0.00040000000000000002,...
 0.00050000000000000001,...
 0.00060000000000000006,...
 0.00069999999999999999,...
 0.00080000000000000004,...
]);
pdetool('gridon','on');

% Geometry description:
pderect([0.0009999999999999998 0 0.00020000000000000001 0],'R1');
pderect([0 0.00059999999999999984 0.00020000000000000001 0.00060000000000000006],'R2');
pdepoly([ 0.00059999999999999984,...
 0.0009999999999999998,...
 0.00039999999999999986,...
 0.00039999999999999986,...
 0.00059999999999999984,...
],...
[ 0.00060000000000000006,...
 0.00020000000000000001,...
 0.00020000000000000001,...
 0.00030000000000000003,...
 0.00030000000000000003,...
],...
 'P1');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','R1+R2+P1')

% Boundary conditions:
pdetool('changemode',0)
pdetool('removeb',[12 ]);
pdesetbd(8,...
'dir',...
1,...
'1',...
'0')
pdesetbd(7,...
'dir',...
1,...
'1',...
'0')
pdesetbd(4,...
'dir',...
1,...
'1',...
'0')
pdesetbd(3,...
'dir',...
1,...
'1',...
'0')
pdesetbd(2,...
'dir',...
1,...
'1',...
'0')
pdesetbd(1,...
'dir',...
1,...
'1',...
'0')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
setappdata(pde_fig,'MesherVersion','preR2013a');
pdetool('initmesh')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'0.0',...
'10.0',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0 ';...
'0.0 ';...
'10.0';...
'1.0 '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');