clear variables
clc
%% MATLAB
filename = 'InitialGuesses_50_Simulations.xlsx';
sheet = 3;

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

figure(4)
figname = 'figure4';
subplot(2,2,3)
errorbar (exp_time,exp_rel,exp_stdv,'ko')
hold on
set(gca,'ColorOrderIndex',3)
plot (sim_time,sim_average,'-',sim_time,sim_best,'--','LineWidth',2)
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',8)
xlabel('Time (days)','FontName','Arial','FontSize',8)
legend ('Jiang et al. (2020)', 'Average MATLAB', 'Best MATLAB','FontName','Arial','FontSize',8,'Location','southeast')
axis([0,180,0,120])
hold off


xlRange = 'N3:N52';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'M3:M52';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,1)
plot (sim_iteration,sim_error,'ko','LineWidth',1)
yline(457.04,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,50,420,520])

%% COMSOL
sheet = 4;
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
errorbar (exp_time,exp_rel,exp_stdv,'ko')
hold on
set(gca,'ColorOrderIndex',3)
plot (sim_time,sim_average,'-',sim_time,sim_best,'--','LineWidth',2)
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',8)
xlabel('Time (days)','FontName','Arial','FontSize',8)
legend ('Jiang et al. (2020)', 'Average COMSOL', 'Best COMSOL','FontName','Arial','FontSize',8,'Location','southeast')
axis([0,180,0,120])
hold off


xlRange = 'N3:N52';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'M3:M52';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,2)
plot (sim_iteration,sim_error,'ko','LineWidth',1)
yline(457.04,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,50,420,520])


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