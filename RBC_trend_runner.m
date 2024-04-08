% RBC news runner
clc,clear;
dynare RBC_trend.mod nolog;

%save steady state
for i=1:length(M_.endo_names)
assignin('base', M_.endo_names{i}, oo_.steady_state(i));
end


%% set initial values for A
A0=1;

cumulativeGrowth_epsg = cumprod(oo_.irfs.g_epsg_surprise+g);
A_epsg=A0*cumulativeGrowth_epsg;
Y_epsg=(oo_.irfs.y_epsg_surprise+y) .* (A_epsg.^(1/alph));
C_epsg=(oo_.irfs.c_epsg_surprise+c) .* (A_epsg.^(1/alph));
I_epsg=(oo_.irfs.i_epsg_surprise+i) .* (A_epsg.^(1/alph));

cumulativeGrowth_epsthet = cumprod(oo_.irfs.g_epsthet_surprise+g);
A_epsthet=A0*cumulativeGrowth_epsthet;
Y_epsthet=(oo_.irfs.y_epsthet_surprise+y) .* (A_epsthet.^(1/alph));
C_epsthet=(oo_.irfs.c_epsthet_surprise+c) .* (A_epsthet.^(1/alph));
I_epsthet=(oo_.irfs.i_epsthet_surprise+i) .* (A_epsthet.^(1/alph));


T=1:length(oo_.irfs.i_epsg_surprise);

h=figure(3);
tcl = tiledlayout(2,2,'TileSpacing','compact','Padding','compact');

nexttile(tcl);
plot(T,A_epsg,'LineWidth',1.5,'color','red'); hold on;
plot(T,A_epsthet,'LineWidth',1.5,'color','blue');
title('A'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,Y_epsg,'LineWidth',1.5,'color','red'); hold on;
plot(T,Y_epsthet,'LineWidth',1.5,'color','blue');
title('Y'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,C_epsg,'LineWidth',1.5,'color','red'); hold on;
plot(T,C_epsthet,'LineWidth',1.5,'color','blue');
title('C'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,I_epsg,'LineWidth',1.5,'color','red'); hold on;
plot(T,I_epsthet,'LineWidth',1.5,'color','blue');
title('I'); set(gca,'FontSize',12);

lg=legend({'Growth shock','Temprary shock'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
hold off;

