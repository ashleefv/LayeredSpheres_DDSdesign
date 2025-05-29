clear variables
clc
%% MATLAB
filename = 'InitialGuesses_100_Simulations.xlsx';
sheet = 3;

xlRange = 'S3:S174';
sim_time = xlsread(filename,sheet,xlRange);

xlRange = 'T3:T174';
sim_average = xlsread(filename,sheet,xlRange);

xlRange = 'W3:W174';
sim_best = xlsread(filename,sheet,xlRange);

xlRange = 'Y3:Y13';
exp_time = xlsread(filename,sheet,xlRange);

xlRange = 'Z3:Z13';
exp_rel = xlsread(filename,sheet,xlRange);

xlRange = 'AA3:AA13';
exp_stdv = xlsread(filename,sheet,xlRange);

figure(55) %Figure S5
figname = 'figureS5';
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


xlRange = 'Q3:Q102';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'P3:P102';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,1)
plot (sim_iteration,sim_error,'ko','LineWidth',1)
yline(457.04,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,100,420,600])

%% COMSOL
sheet = 4;
xlRange = 'S3:S174';
sim_time = xlsread(filename,sheet,xlRange);

xlRange = 'T3:T174';
sim_average = xlsread(filename,sheet,xlRange);

xlRange = 'W3:W174';
sim_best = xlsread(filename,sheet,xlRange);

xlRange = 'Y3:Y13';
exp_time = xlsread(filename,sheet,xlRange);

xlRange = 'Z3:Z13';
exp_rel = xlsread(filename,sheet,xlRange);

xlRange = 'AA3:AA13';
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


xlRange = 'Q3:Q102';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'P3:P102';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,2)
plot (sim_iteration,sim_error,'ko','LineWidth',1)
yline(457.04,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,100,420,600])

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