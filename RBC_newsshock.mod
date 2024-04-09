var g thet l;
trend_var(growth_factor=g) A;

parameters alph;
var(deflator=A^(1/alph)) y c i k;


varexo epsthet_news epsthet_surprise epsg_news epsg_surprise;

parameters bet delt v0 gs rhothet rhog;
bet=0.96;
delt=0.025;
alph=0.65;
v0=0.1;    %%recalibrated
gs=0.01/4+1; %%gross TFP growth rate
rhothet=0.8;
rhog=0.8;

model;
%1
log(g)=rhog*log(g(-1))+(1-rhog)*log(steady_state(gs))
       +epsg_surprise + epsg_news(-3);
%2
log(thet)=rhothet*log(thet(-1))+epsthet_surprise+epsthet_news(-4);
%3
v0=1/c * alph*y/l;
%4
1=bet* c/c(+1) * (y(+1)/k*(1-alph)+1-delt);
%5
k=(1-delt)*k(-1)+i;
%6
c+i=y;
%7
y=thet*A*k(-1)^(1-alph)*l^alph;
end;

steady;
check;

shocks;
var epsthet_surprise=0.01;
var epsg_surprise=0.01;
end;

stoch_simul(order=1,irf=20,nograph);

%initialize IRF generation
initial_condition_states = repmat(oo_.dr.ys,1,M_.maximum_lag);
shock_matrix1 = zeros(options_.irf,M_.exo_nbr); 
shock_matrix2 = zeros(options_.irf,M_.exo_nbr);

% set shocks for pure news 
shock_matrix1(1,strmatch('epsthet_news',M_.exo_names,'exact')) = 1; 
shock_matrix1(1+4,strmatch('epsthet_surprise',M_.exo_names,'exact')) = -1; 
shock_matrix2(1,strmatch('epsg_news',M_.exo_names,'exact')) = 1; 
shock_matrix2(1+3,strmatch('epsg_surprise',M_.exo_names,'exact')) = -1; 

y1 = simult_(M_,options_,initial_condition_states,oo_.dr,shock_matrix1,1);
y2 = simult_(M_,options_,initial_condition_states,oo_.dr,shock_matrix2,1);
