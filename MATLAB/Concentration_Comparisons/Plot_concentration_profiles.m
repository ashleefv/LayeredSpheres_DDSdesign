%Plotting concentration profiles after param estimation of BSA release
%from chitosan-PCL microspheres
%% Time vector
t=xlsread('Concentration_comparison',1,'A4:A174');

%% r=0
ode45_r0=xlsread('Concentration_comparison',1,'B4:B174');
COMSOL_r0=xlsread('Concentration_comparison',1,'D4:D174');

%% r=half chitosan
ode45_hc=xlsread('Concentration_comparison',1,'H4:H174');
COMSOL_hc=xlsread('Concentration_comparison',1,'J4:J174');

%% r=interface
ode45_in=xlsread('Concentration_comparison',1,'N4:N174');
COMSOL_in=xlsread('Concentration_comparison',1,'P4:P174');

%% r=half PCL
ode45_hp=xlsread('Concentration_comparison',1,'T4:T174');
COMSOL_hp=xlsread('Concentration_comparison',1,'V4:V174');

%% Plotting
figure(52) %figureS2
figname = 'figureS2';
subplot(2,2,1)
set(gca,'ColorOrderIndex',6)
co = get(gca, 'ColorOrder'); % Get the default color order
 
color6 = co(6, :);  
color7 = co(7, :); 
hold on
plot(t,ode45_r0,'-','Color',color7,'LineWidth',2)
plot(t,COMSOL_r0,'--','Color',color6,'LineWidth',2)
xlabel('Time (days)','FontName','Arial','fontsize',8)
ylabel ('Concentration (a.u.)','FontName','Arial','fontsize',8)
legend('MATLAB','COMSOL','FontName','Arial','fontsize',8)
xlim([0 180])

subplot(2,2,2)
hold on
plot (t,ode45_hc,'-','Color',color7,'LineWidth',2)
plot (t,COMSOL_hc,'--','Color',color6,'LineWidth',2)
xlabel('Time (days)','FontName','Arial','fontsize',8)
ylabel ('Concentration (a.u.)','FontName','Arial','fontsize',8)

legend('MATLAB','COMSOL','FontName','Arial','fontsize',8)
xlim([0 180])
ylim([0 1])

subplot(2,2,3)
hold on
plot (t,ode45_in,'-','Color',color7,'LineWidth',2)
plot(t,COMSOL_in,'--','Color',color6,'LineWidth',2)
xlabel('Time (days)','FontName','Arial','fontsize',8)
ylabel ('Concentration (a.u.)','FontName','Arial','fontsize',8)
legend('MATLAB','COMSOL','FontName','Arial','fontsize',8)
xlim([0 180])

subplot(2,2,4)
hold on
plot (t,ode45_hp,'-','Color',color7,'LineWidth',2)
plot(t,COMSOL_hp,'--','Color',color6,'LineWidth',2)
xlabel('Time (days)','FontName','Arial','fontsize',8)
ylabel ('Concentration (a.u.)','FontName','Arial','fontsize',8)

legend('MATLAB','COMSOL','FontName','Arial','fontsize',8)
xlim([0 180])

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