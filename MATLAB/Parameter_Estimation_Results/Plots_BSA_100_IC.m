clear variables
clc
%% MATLAB
filename = 'InitialGuesses_100_Simulations.xlsx';
sheet = 1;

xlRange = 'S3:S173';
sim_time = xlsread(filename,sheet,xlRange);

xlRange = 'T3:T173';
sim_average = xlsread(filename,sheet,xlRange);

xlRange = 'W3:W173';
sim_best = xlsread(filename,sheet,xlRange);

xlRange = 'Y3:Y13';
exp_time = xlsread(filename,sheet,xlRange);

xlRange = 'Z3:Z13';
exp_rel = xlsread(filename,sheet,xlRange);

xlRange = 'AA3:AA13';
exp_stdv = xlsread(filename,sheet,xlRange);

figure(54) %Figure S4
figname = 'figureS4';
subplot(2,2,3)
errorbar (exp_time,exp_rel,exp_stdv,'ko','LineWidth',3)
hold on
plot (sim_time,sim_average,'b',sim_time,sim_best,'r--','LineWidth',4)
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',12)
xlabel('Time (days)','FontName','Arial','FontSize',12)
legend ('Jiang et al. (2020)', 'Average MATLAB model', 'Best MATLAB model','FontName','Arial','FontSize',10,'Location','southeast')
axis([0,170,0,110])
hold off


xlRange = 'Q3:Q102';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'P3:P102';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,1)
plot (sim_iteration,sim_error,'ko','LineWidth',1)
yline(217.35,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',12)
xlabel('Completed multi-start run','FontName','Arial','FontSize',12)
legend('Simulation','Threshold','Location','northwest')
axis([0,100,200,260])

%% COMSOL
sheet = 2;
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
errorbar (exp_time,exp_rel,exp_stdv,'ko','LineWidth',3)
hold on
plot (sim_time,sim_average,'b',sim_time,sim_best,'r--','LineWidth',4)
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',12)
xlabel('Time (days)','FontName','Arial','FontSize',12)
legend ('Jiang et al. (2020)', 'Average COMSOL model', 'Best COMSOL model','FontName','Arial','FontSize',10,'Location','southeast')
axis([0,170,0,110])
hold off


xlRange = 'Q3:Q102';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'P3:P102';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,2)
plot (sim_iteration,sim_error,'ko','LineWidth',1)
yline(217.35,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',12)
xlabel('Completed multi-start run','FontName','Arial','FontSize',12)
legend('Simulation','Threshold','Location','northwest')
axis([0,100,200,260])

labelstring = {'a)', 'b)', 'c)', 'd)'};
for v = 1:4
    subplot(2,2,v)
    hold on
    text(-0.25, 1.1, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize', 12)
end

ScriptForExportingImages