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


xlRange = 'Q3:Q102';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'P3:P102';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,1)
plot (sim_iteration,sim_error,'k.')
yline(217.35,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
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

hold on
co = orderedcolors("gem");
    color3 = co(3, :);
    color4 = co(4,:);
plot (sim_time,sim_average,'-','color',color4,'LineWidth',2)
plot(sim_time,sim_best,'--','color',color3,'LineWidth',2)
errorbar (exp_time,exp_rel,exp_stdv,'k^')
ylabel('Cumulative drug release (%)','FontName','Arial','FontSize',8)
xlabel('Time (days)','FontName','Arial','FontSize',8)
legend ( 'Average COMSOL', 'Best COMSOL','Jiang et al. (2020)','FontName','Arial','FontSize',8,'Location','southeast')
axis([0,180,0,110])
hold off


xlRange = 'Q3:Q102';
sim_iteration = xlsread(filename,sheet,xlRange);

xlRange = 'P3:P102';
sim_error = xlsread(filename,sheet,xlRange);

subplot(2,2,2)
plot (sim_iteration,sim_error,'k.')
yline(217.35,'--k','LineWidth',2)
ylabel('Sum of squared errors','FontName','Arial','FontSize',8)
xlabel('Completed multi-start run','FontName','Arial','FontSize',8)
legend('Simulation','Threshold','Location','northwest')
axis([0,100,200,260])

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