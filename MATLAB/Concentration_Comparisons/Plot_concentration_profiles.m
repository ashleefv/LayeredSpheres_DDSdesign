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
subplot(2,2,1)
plot (t,ode45_r0,'r',t,COMSOL_r0,'--b','LineWidth',4)
ylabel ('Concentration (a.u.)','FontName','Arial','FontSize',12)
legend('MATLAB','COMSOL','FontName','Arial','FontSize',10)
xlim([0 180])

subplot(2,2,2)
plot (t,ode45_hc,'r',t,COMSOL_hc,'--b','LineWidth',4)
legend('MATLAB','COMSOL','FontName','Arial','FontSize',10)
xlim([0 180])
ylim([0 1])

subplot(2,2,3)
plot (t,ode45_in,'r',t,COMSOL_in,'--b','LineWidth',4)
xlabel('Time (days)','FontName','Arial','FontSize',12)
ylabel ('Concentration (a.u.)','FontName','Arial','FontSize',12)
legend('MATLAB','COMSOL','FontName','Arial','FontSize',10)
xlim([0 180])

subplot(2,2,4)
plot (t,ode45_hp,'r',t,COMSOL_hp,'--b','LineWidth',4)
xlabel('Time (days)','FontName','Arial','FontSize',12)
legend('MATLAB','COMSOL','FontName','Arial','FontSize',10)
xlim([0 180])