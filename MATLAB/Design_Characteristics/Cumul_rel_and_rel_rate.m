clear all
clc
close all
file_name = 'Bilayered_MPs_Prediction.xlsx'; %Reading spreadsheet

%% Cumulative drug release
% Constant PCL layer (0.5*1.25 um thickness), varying chitosan radius
sheet_num = 1;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

cuml_rel = "B3:B183";
cuml_rel_rate_0_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "F3:F183";
cuml_rel_rate_0_5 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "J3:J183";
cuml_rel_rate_0_75 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "N3:N183";
cuml_rel_rate_1 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "R3:R183";
cuml_rel_rate_1_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "V3:V183";
cuml_rel_rate_1_5 = xlsread(file_name,sheet_num,cuml_rel);

%Cumulative release figure
fig = figure(5);
figname = 'figure5';
threshold = 90; % %
Rcore_string = '$5.10 \mu m$ '; % string for the R_{core} value in microns
DeltaR_string = '$1.25 \mu m$'; % string for the R_{shell} - R_{core} value in microns
axisvector = [0 180 0 100];
xtickvector = [0 30 60 90 120 150 180];
ytickvector = [0 25 50 75 100];


subplot(4,6,1)
plot(trange, cuml_rel_rate_0_25)
hold on
title("$0.25R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,2)
plot(trange, cuml_rel_rate_0_5)
hold on
title("$0.5R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,3)
plot(trange, cuml_rel_rate_0_75)
hold on
title("$0.75R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,4)
plot(trange, cuml_rel_rate_1)
hold on
title("$R_{core} = 5.10 \mu m$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,5)
plot(trange, cuml_rel_rate_1_25)
hold on
title("$1.25R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,6)
plot(trange, cuml_rel_rate_1_5)
hold on
text(1.1, 0.5, "$0.5 \Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
text(1.1, 1.1, ["$\Delta R = $", DeltaR_string], 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
title("$1.5R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Constant PCL layer (1.25 um thickness), varying chitosan radius
sheet_num = 2;

time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

cuml_rel = "B3:B183";
cuml_rel_rate_0_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "F3:F183";
cuml_rel_rate_0_5 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "J3:J183";
cuml_rel_rate_0_75 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "N3:N183";
cuml_rel_rate_1 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "R3:R183";
cuml_rel_rate_1_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "V3:V183";
cuml_rel_rate_1_5 = xlsread(file_name,sheet_num,cuml_rel);

%Experimental data
file = "MPs_release_6_months.xlsx";
n_sheet = 1;

xlRange = 'A3:A13';
exp_time = xlsread(file,n_sheet,xlRange);
xlRange = 'B3:B13';
exp_rel = xlsread(file,n_sheet,xlRange);
xlRange = 'C3:C13';
exp_stdv = xlsread(file,n_sheet,xlRange);

subplot(4,6,7)
plot(trange, cuml_rel_rate_0_25)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,8)
plot(trange, cuml_rel_rate_0_5)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,9)
plot(trange, cuml_rel_rate_0_75)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,10)
errorbar (exp_time,exp_rel,exp_stdv,'ko')
hold on
set(gca,'ColorOrderIndex',1)
plot(trange, cuml_rel_rate_1,'-')
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

%Overall legends
legend('Jiang et al. (2020)','Simulation results', [num2str(threshold) '% threshold'],'FontName','Arial','FontSize',8)
h = legend('Location','northoutside', 'Orientation', 'horizontal');
p = [0.5 0.96 0.03 0.03];
set(h,'Position', p,'Units', 'normalized');

subplot(4,6,11)
plot(trange, cuml_rel_rate_1_25)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,12)
plot(trange, cuml_rel_rate_1_5)
hold on
text(1.1, 0.5, "$\Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')

xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Constant PCL layer (5*1.25 um thickness), varying chitosan radius
sheet_num = 3;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

cuml_rel = "B3:B183";
cuml_rel_rate_0_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "F3:F183";
cuml_rel_rate_0_5 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "J3:J183";
cuml_rel_rate_0_75 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "N3:N183";
cuml_rel_rate_1 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "R3:R183";
cuml_rel_rate_1_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "V3:V183";
cuml_rel_rate_1_5 = xlsread(file_name,sheet_num,cuml_rel);

subplot(4,6,13)
plot(trange, cuml_rel_rate_0_25)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,14)
plot(trange, cuml_rel_rate_0_5)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,15)
plot(trange, cuml_rel_rate_0_75)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,16)
plot(trange, cuml_rel_rate_1)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,17)
plot(trange, cuml_rel_rate_1_25)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,18)
plot(trange, cuml_rel_rate_1_5)
hold on
text(1.1, 0.5, "$5 \Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')

xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Constant PCL layer (10*1.25 um thickness), varying chitosan radius
sheet_num = 4;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

cuml_rel = "B3:B183";
cuml_rel_rate_0_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "F3:F183";
cuml_rel_rate_0_5 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "J3:J183";
cuml_rel_rate_0_75 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "N3:N183";
cuml_rel_rate_1 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "R3:R183";
cuml_rel_rate_1_25 = xlsread(file_name,sheet_num,cuml_rel);
cuml_rel = "V3:V183";
cuml_rel_rate_1_5 = xlsread(file_name,sheet_num,cuml_rel);

subplot(4,6,19)
plot(trange, cuml_rel_rate_0_25)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,20)
plot(trange, cuml_rel_rate_0_5)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,21)
plot(trange, cuml_rel_rate_0_75)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,22)
plot(trange, cuml_rel_rate_1)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,23)
plot(trange, cuml_rel_rate_1_25)
hold on
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,24)
plot(trange, cuml_rel_rate_1_5)
hold on
text(1.1, 0.5, "$10 \Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Common y-axis label
han = axes(fig, 'visible', 'off'); 
han.YLabel.Visible = 'on';
ylabel(han, 'Cumulative drug release (%)',"Position",[-0.03,0.5,1],'FontName','Arial','FontSize',8);

% Common x-axis label
han = axes(fig, 'visible', 'off'); 
han.XLabel.Visible = 'on';
xlabel(han, 'Time (days)','FontName','Arial','FontSize',8);

% res=600;
% set(gcf,'paperunits','centimeters','PaperPosition',[0 0 32 18]);
% print('CumulRel.tiff','-dtiff',['-r' num2str(res)], '-vector'); % still need to crop some white space on the left

widthInches = 8;
heightInches = 5;
run('../ScriptForExportingImages.m')

%% Release rate
% Constant PCL layer (0.5*1.25 um thickness), varying chitosan radius
sheet_num = 1;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

rel_rate = "C3:C183";
rel_rate_0_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "G3:G183";
rel_rate_0_5 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "K3:K183";
rel_rate_0_75 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "O3:O183";
rel_rate_1 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "S3:S183";
rel_rate_1_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "W3:W183";
rel_rate_1_5 = xlsread(file_name,sheet_num,rel_rate);

% Release rate figure
fig = figure(6);
figname = 'figure6';
threshold = 2; % micrograms/day
tolerance = 0.1;
axisvector = [0 180 1e-2 400];
xtickvector = [0 30 60 90 120 150 180];
ytickvector = [1e-2 1e-1 1 10 100 1000];

subplot(4,6,1)
semilogy(trange, rel_rate_0_25)
hold on
plotfill(trange, rel_rate_0_25,threshold,tolerance)
title("$0.25R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,2)
semilogy(trange, rel_rate_0_5)
hold on
plotfill(trange, rel_rate_0_5,threshold,tolerance)
title("$0.5R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,3)
semilogy(trange, rel_rate_0_75)
hold on
plotfill(trange, rel_rate_0_75,threshold,tolerance)
title("$0.75R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,4)
semilogy(trange, rel_rate_1)
hold on
plotfill(trange, rel_rate_1,threshold,tolerance)
title("$R_{core} = 5.10 \mu m$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,5)
semilogy(trange, rel_rate_1_25)
hold on
plotfill(trange, rel_rate_1_25,threshold,tolerance)
title("$1.25R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,6)
semilogy(trange, rel_rate_1_5)
hold on
plotfill(trange, rel_rate_1_5,threshold,tolerance)
text(1.1, 0.5, "$0.5 \Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
text(1.1, 1.1, ["$\Delta R = $", DeltaR_string], 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
title("$1.5R_{core}$",'FontWeight','Normal', "FontSize", 8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Constant PCL layer (1.25 um thickness), varying chitosan radius
sheet_num = 2;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

rel_rate = "C3:C183";
rel_rate_0_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "G3:G183";
rel_rate_0_5 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "K3:K183";
rel_rate_0_75 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "O3:O183";
rel_rate_1 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "S3:S183";
rel_rate_1_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "W3:W183";
rel_rate_1_5 = xlsread(file_name,sheet_num,rel_rate);

subplot(4,6,7)
semilogy(trange, rel_rate_0_25)
hold on
plotfill(trange, rel_rate_0_25,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,8)
semilogy(trange, rel_rate_0_5)
hold on
plotfill(trange, rel_rate_0_5,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,9)
semilogy(trange, rel_rate_0_75)
hold on
plotfill(trange, rel_rate_0_75,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,10)
semilogy(trange, rel_rate_1)
hold on
plotfill(trange, rel_rate_1,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,11)
semilogy(trange, rel_rate_1_25)
hold on
plotfill(trange, rel_rate_1_25,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,12)
semilogy(trange, rel_rate_1_5)
hold on
plotfill(trange, rel_rate_1_5,threshold,tolerance)
text(1.1, 0.5, "$\Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Constant PCL layer (5*1.25 um thickness), varying chitosan radius
sheet_num = 3;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

rel_rate = "C3:C183";
rel_rate_0_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "G3:G183";
rel_rate_0_5 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "K3:K183";
rel_rate_0_75 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "O3:O183";
rel_rate_1 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "S3:S183";
rel_rate_1_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "W3:W183";
rel_rate_1_5 = xlsread(file_name,sheet_num,rel_rate);

subplot(4,6,13)
semilogy(trange, rel_rate_0_25)
hold on
plotfill(trange, rel_rate_0_25,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,14)
semilogy(trange, rel_rate_0_5)
hold on
plotfill(trange, rel_rate_0_5,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,15)
semilogy(trange, rel_rate_0_75)
hold on
plotfill(trange, rel_rate_0_75,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,16)
semilogy(trange, rel_rate_1)
hold on
plotfill(trange, rel_rate_1,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,17)
semilogy(trange, rel_rate_1_25)
hold on
plotfill(trange, rel_rate_1_25,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,18)
semilogy(trange, rel_rate_1_5)
hold on
plotfill(trange, rel_rate_1_5,threshold,tolerance)
text(1.1, 0.5, "$5 \Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

% Constant PCL layer (10*1.25 um thickness), varying chitosan radius
sheet_num = 4;
time = "A3:A183";
trange = xlsread(file_name,sheet_num,time);

rel_rate = "C3:C183";
rel_rate_0_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "G3:G183";
rel_rate_0_5 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "K3:K183";
rel_rate_0_75 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "O3:O183";
rel_rate_1 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "S3:S183";
rel_rate_1_25 = xlsread(file_name,sheet_num,rel_rate);
rel_rate = "W3:W183";
rel_rate_1_5 = xlsread(file_name,sheet_num,rel_rate);

subplot(4,6,19)
semilogy(trange, rel_rate_0_25)
hold on
plotfill(trange, rel_rate_0_25,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,20)
semilogy(trange, rel_rate_0_5)
hold on
plotfill(trange, rel_rate_0_5,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,21)
semilogy(trange, rel_rate_0_75)
hold on
plotfill(trange, rel_rate_0_75,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,22)
semilogy(trange, rel_rate_1)
hold on
plotfill(trange, rel_rate_1,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,23)
semilogy(trange, rel_rate_1_25)
hold on
plotfill(trange, rel_rate_1_25,threshold,tolerance)
xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

subplot(4,6,24)
semilogy(trange, rel_rate_1_5)
hold on
plotfill(trange, rel_rate_1_5,threshold,tolerance)
text(1.1, 0.5, "$10 \Delta R$", 'Units', 'normalized', 'FontWeight', 'Normal','FontSize',8,'interpreter','latex')

xticks(xtickvector)
yticks(ytickvector)
axis(axisvector)
grid on

%Overall legend
legend('Simulation results', [num2str(threshold) ' \mug/day threshold'],['Days within +/-' num2str(tolerance*100) '% of ' num2str(threshold) ' \mug/day threshold'],'FontName','Arial','FontSize',8)
h = legend('Location','northoutside', 'Orientation', 'horizontal');
p = [0.5 0.96 0.03 0.03];
set(h,'Position', p,'Units', 'normalized');

% Common y-axis label
han = axes(fig, 'visible', 'off'); 
han.YLabel.Visible = 'on';
ylabel(han, 'Drug release rate (\mug/day)',"Position",[-0.03,0.5,1],'FontName','Arial','FontSize',8);

% Common x-axis label
han = axes(fig, 'visible', 'off'); 
han.XLabel.Visible = 'on';
xlabel(han, 'Time (days)','FontName','Arial','FontSize',8);

% res=600;
% set(gcf,'paperunits','centimeters','PaperPosition',[0 0 32 18]);
% print('RelRate.tiff','-dtiff',['-r' num2str(res)], '-vector'); % still need to crop some white space on the left
% 
widthInches = 8;
heightInches = 5;
run('../ScriptForExportingImages.m')
