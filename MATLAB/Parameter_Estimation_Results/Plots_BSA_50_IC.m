clear variables
clc
%% MATLAB
filename = 'InitialGuesses_50_Simulations.xlsx';
sheet = 1;

xlRange = 'P3:P173';
sim_time = xlsread(filename,sheet,xlRange);

xlRange = 'Q3:Q173';
sim_average = xlsread(filename,sheet,xlRange);

xlRange = 'T3:T173';
sim_best = xlsread(filename,sheet,xlRange);

xlRange = 'V3:V13';
exp_time = xlsread(filename,sheet,xlRange);

xlRange = 'W3:W13';
exp_rel = xlsread(filename,sheet,xlRange);

xlRange = 'X3:X13';
exp_stdv = xlsread(filename,sheet,xlRange);

figure(3)
figname = 'figure3';
subplot(2,2,3)

hold on
co = orderedcolors("gem");
    color3 = co(3, :);
    color4 = co(4,:);
plot (sim_time,sim_average,'-','color',color4,'LineWidth',2)
plot(sim_time,sim_best,'--','color',color3,'LineWidth',2)
errorbar (exp_time,exp_rel,exp_stdv,'k^')
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',8)
xlabel('Time (days)','FontName','Arial','FontSize',8)
legend ( 'Average MATLAB', 'Best MATLAB','Jiang et al. (2020)','FontName','Arial','FontSize',8,'Location','southeast')
axis([0,180,0,110])
hold off


xlRange = 'N3:N52';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'M3:M52';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,1)
plot (sim_iteration,sim_error,'k.')
yline(217.35,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,50,200,260])

%% COMSOL
sheet = 2;
xlRange = 'P3:P173';
sim_time = xlsread(filename,sheet,xlRange);

xlRange = 'Q3:Q173';
sim_average = xlsread(filename,sheet,xlRange);

xlRange = 'T3:T173';
sim_best = xlsread(filename,sheet,xlRange);

xlRange = 'V3:V13';
exp_time = xlsread(filename,sheet,xlRange);

xlRange = 'W3:W13';
exp_rel = xlsread(filename,sheet,xlRange);

xlRange = 'X3:X13';
exp_stdv = xlsread(filename,sheet,xlRange);

subplot(2,2,4)

hold on
co = orderedcolors("gem");
    color3 = co(3, :);
    color4 = co(4,:);
plot (sim_time,sim_average,'-','color',color4,'LineWidth',2)
plot(sim_time,sim_best,'--','color',color3,'LineWidth',2)
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',8)
xlabel('Time (days)','FontName','Arial','FontSize',8)
errorbar (exp_time,exp_rel,exp_stdv,'k^')
legend ('Average COMSOL', 'Best COMSOL','Jiang et al. (2020)', 'FontName','Arial','FontSize',8,'Location','southeast')
axis([0,180,0,110])
hold off


xlRange = 'N3:N52';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'M3:M52';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,2)
plot (sim_iteration,sim_error,'k.')
yline(217.35,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,50,200,260])


labelstring = {'a)', 'b)', 'c)', 'd)'};
for v = 1:4
    subplot(2,2,v)
    hold on
    text(-0.225, 1.1, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize',8)
    set(gca,'FontName','Arial','FontSize',8)
end

widthInches = 5;
heightInches = 5;
run('../ScriptForExportingImages.m')