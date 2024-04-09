%start
clc,clear;
dynare RBC_newsshock.mod nolog

%% 赋值
str_thet= struct();
str_g=struct();
for ii=1:length(M_.endo_names)
    str_thet.(M_.endo_names{ii})=y1(ii,:);
    str_g.(M_.endo_names{ii})=y2(ii,:);
end


%% 作图
T=2:length(str_thet.y);
h=figure(1);
tcl = tiledlayout(2,3,'TileSpacing','compact','Padding','compact');

nexttile(tcl);
plot(T,str_thet.thet(2:length(str_thet.y)),'LineWidth',1.5,'color','red'); hold on;
plot(T,str_g.g(2:length(str_thet.y)),'LineWidth',1.5,'color','blue');
title('g and theta'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,str_thet.y(2:length(str_thet.y)),'LineWidth',1.5,'color','red'); hold on;
plot(T,str_g.y(2:length(str_thet.y)),'LineWidth',1.5,'color','blue');
title('y'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,str_thet.l(2:length(str_thet.y)),'LineWidth',1.5,'color','red'); hold on;
plot(T,str_g.l(2:length(str_thet.y)),'LineWidth',1.5,'color','blue');
title('l'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,str_thet.c(2:length(str_thet.y)),'LineWidth',1.5,'color','red'); hold on;
plot(T,str_g.c(2:length(str_thet.y)),'LineWidth',1.5,'color','blue');
title('c'); set(gca,'FontSize',12);

nexttile(tcl);
plot(T,str_thet.i(2:length(str_thet.y)),'LineWidth',1.5,'color','red'); hold on;
plot(T,str_g.i(2:length(str_thet.y)),'LineWidth',1.5,'color','blue');
title('i'); set(gca,'FontSize',12);

lg=legend({'news shock of temparary','news shock of growth'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
hold off;

