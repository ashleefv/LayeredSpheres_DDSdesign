clear variables
clc
%% Dchi = 1e-15 cm2/s, Dpcl=1e-12 cm2/s, b=10%, k=1

% Customizable variables
sheet_num = 1; 
file_name = 'Moat_Info_COMSOL.xlsx'; %Reading spreadsheets

%Experimental time points
xrange = 'A2:A5';
x = xlsread(file_name,sheet_num,xrange)';

yrange = 'B2:B5';
y = xlsread(file_name,sheet_num,yrange)';

figure()
subplot(1,3,1)
plot(x,y,'ko')
xlabel('MOAT mean')
ylabel('MOAT standard deviation')
txt = '$D_{Chi}$';
text(0.93*x(1),0.9*y(1),txt,'interpreter','latex')
txt = '$B$';
text(1.08*x(2),1.03*y(2),txt,'interpreter','latex')
txt = '$\kappa$';
text(1.5*x(3),3*y(3),txt,'interpreter','latex')
txt = '$D_{PCL}$';
text(4.3*x(4),-15*y(4),txt,'interpreter','latex')
axis([-0.05 0.5 -1e-4 0.0012])

%% Dchi = 1e-14 cm2/s, Dpcl=1e-14 cm2/s, b=10%, k=1

% Customizable variables
sheet_num = 2; 
file_name = 'Moat_Info_COMSOL.xlsx'; %Reading spreadsheets

%Experimental time points
xrange = 'A2:A5';
x = xlsread(file_name,sheet_num,xrange)';

yrange = 'B2:B5';
y = xlsread(file_name,sheet_num,yrange)';

subplot(1,3,2)
plot(x,y,'ko')
xlabel('MOAT mean')
txt = '$D_{PCL}$';
text(0.96*x(1),0.91*y(1),txt,'interpreter','latex')
txt = '$\kappa$';
text(1.03*x(2),0.97*y(2),txt,'interpreter','latex')
txt = '$D_{Chi}$';
text(1*x(3),0.95*y(3),txt,'interpreter','latex')
txt = '$B$';
text(1.08*x(4),1.01*y(4),txt,'interpreter','latex')
axis([-0.05 0.5 -1e-4 0.0012])

%% Dchi = 1e-12 cm2/s, Dpcl=1e-15 cm2/s, b=10%, k=1

% Customizable variables
sheet_num = 3; 
file_name = 'Moat_Info_COMSOL.xlsx'; %Reading spreadsheets

%Experimental time points
xrange = 'A2:A5';
x = xlsread(file_name,sheet_num,xrange)';

yrange = 'B2:B5';
y = xlsread(file_name,sheet_num,yrange)';

subplot(1,3,3)
plot(x,y,'ko')
xlabel('MOAT mean')
txt = '$B$';
text(1.03*x(1),0.75*y(1),txt,'interpreter','latex')
txt = '$D_{PCL}$';
text(1.08*x(2),1.1*y(2),txt,'interpreter','latex')
txt = '$\kappa$';
text(1*x(3),0.95*y(3),txt,'interpreter','latex')
txt = '$D_{Chi}$';
text(60*x(4),3*y(4),txt,'interpreter','latex')
axis([-0.05 0.5 -1e-4 0.0012])