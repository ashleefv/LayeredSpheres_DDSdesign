clear variables
clc

%% Core-limited diffusion
load("core_limited_diffusion.mat")

figure(56) %Figure S6
figname = 'figureS6';

%plot 7 different time steps
subplot(2,3,1)
plot(r,c(:,1),'k-')
hold on
plot(r,c(:,11),r,c(:,21),r,c(:,31),r,c(:,41),r,c(:,51),r,c(:,61),r,c(:,71))
xlabel("r/R_{shell}")
ylabel("Concentration (a.u.)")
legend("t = 0 days","t = 10 days", "t = 20 days", "t = 30 days", "t = 40 days","t = 50 days", "t = 60 days","t = 70 days",'location','southwest')
axis([0 1 0 1])


%% Balanced diffusion
load("balanced_diffusion.mat")

%plot 7 different time steps
subplot(2,3,2)
plot(r,c(:,1),'k-')
hold on
plot(r,c(:,11),r,c(:,21),r,c(:,31),r,c(:,41),r,c(:,51),r,c(:,61),r,c(:,71))
xlabel("r/R_{shell}")
ylabel("Concentration (a.u.)")
legend("t = 0 days","t = 10 days", "t = 20 days", "t = 30 days", "t = 40 days","t = 50 days", "t = 60 days","t = 70 days",'location','southwest')
axis([0 1 0 1])

%% Shell-limited diffusion
load("shell_limited_diffusion.mat")

%plot 7 different time steps
plot(r,c(:,1),'k-')
subplot(2,3,3)
hold on
plot(r,c(:,11),r,c(:,21),r,c(:,31),r,c(:,41),r,c(:,51),r,c(:,61),r,c(:,71))
box on
xlabel("r/R_{shell}")
ylabel("Concentration (a.u.)")
legend("t = 0 days","t = 10 days", "t = 20 days", "t = 30 days", "t = 40 days","t = 50 days", "t = 60 days","t = 70 days",'location','southwest')
axis([0 1 0 1])

labelstring = {'a)', 'b)', 'c)'};
for v = 1:3
    subplot(2,3,v)
    hold on
    text(-0.25, 1.1, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize', 12)
end

ScriptForExportingImages