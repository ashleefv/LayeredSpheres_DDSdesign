%Plotting cumulative release profiles
%% Time vector for k=1
t=xlsread('Cumul_rel_comparison',1,'A5:A175');

% Analytical solution
cumul_rel_analytical=xlsread('Cumul_rel_comparison',1,'B5:B175');

% COMSOL solution
cumul_rel_COMSOL=xlsread('Cumul_rel_comparison',1,'H5:H175');

% MATLAB solution
cumul_rel_MATLAB=xlsread('Cumul_rel_comparison',1,'E5:E175');

% Plotting
figure(53) %figureS3
figname = 'figureS3';
subplot(1,2,1)
set(gca,'ColorOrderIndex',6)
co = get(gca, 'ColorOrder'); % Get the default color order

color3 = co(3, :);
color6 = co(6, :);  
color7 = co(7, :); 
hold on
plot(t,cumul_rel_MATLAB,'-','Color',color7,'LineWidth',2)
plot(t,cumul_rel_COMSOL,'--','Color',color6,'LineWidth',2)
plot(t,cumul_rel_analytical,':','Color',color3,'LineWidth',2)
xlabel('Time (days)','FontName','Arial','fontsize',8)
ylabel ('Cumulative drug release (%)','FontName','Arial','fontsize',8)
legend('MATLAB', 'COMSOL', 'Analytical', 'FontName','Arial','fontsize',8, 'location','Southeast')
xticks([0 50 100 150])
xlim([0 180])
ylim([0 70])

%% Time vector for k=8

% Analytical solution
cumul_rel_analytical=xlsread('Cumul_rel_comparison',1,'K5:K175');

% COMSOL solution
cumul_rel_COMSOL=xlsread('Cumul_rel_comparison',1,'Q5:Q175');

% MATLAB solution
cumul_rel_MATLAB=xlsread('Cumul_rel_comparison',1,'N5:N175');

% Plotting
subplot(1,2,2)
set(gca,'ColorOrderIndex',6)
co = get(gca, 'ColorOrder'); % Get the default color order

color3 = co(3, :);
color6 = co(6, :);  
color7 = co(7, :); 
hold on
plot(t,cumul_rel_MATLAB,'-','Color',color7,'LineWidth',2)
plot(t,cumul_rel_COMSOL,'--','Color',color6,'LineWidth',2)
plot(t,cumul_rel_analytical,':','Color',color3,'LineWidth',2)
xlabel('Time (days)','FontName','Arial','fontsize',8)
ylabel ('Cumulative drug release (%)','FontName','Arial','fontsize',8)
legend('MATLAB', 'COMSOL', 'Analytical', 'FontName','Arial','fontsize',8, 'location','Southeast')
xticks([0 50 100 150])
xlim([0 180])

labelstring = {'(a)', '(b)'};
for v = 1:2
    subplot(1,2,v)
    hold on
    text(-0.225, 1.05, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize',8)
     set(gca,'FontName','Arial','FontSize',8)
end

widthInches = 5;
heightInches = 2.5;
run('../ScriptForExportingImages.m')