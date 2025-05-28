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

figure(57) %Figure S7
figname = 'figureS7';
subplot(2,3,1)
plot(x,y,'ko')
xlabel('MOAT mean')
ylabel('MOAT standard deviation')
txt = '$D_{Chi}$';
text(x(1)+0.02,y(1),txt,'interpreter','latex','FontSize',8)
txt = '$B$';
text(x(2)+0.02,y(2),txt,'interpreter','latex','FontSize',8)
txt = '$\kappa$';
text(x(3)-0.01,y(3)+8e-5,txt,'interpreter','latex','FontSize',8)
txt = '$D_{PCL}$';
text(x(4)+0.02,y(4)-4e-5,txt,'interpreter','latex','FontSize',8)
axis([-0.05 0.6 -1e-4 0.00123])

%% Dchi = 1e-14 cm2/s, Dpcl=1e-14 cm2/s, b=10%, k=1

% Customizable variables
sheet_num = 2; 
file_name = 'Moat_Info_COMSOL.xlsx'; %Reading spreadsheets

%Experimental time points
xrange = 'A2:A5';
x = xlsread(file_name,sheet_num,xrange)';

yrange = 'B2:B5';
y = xlsread(file_name,sheet_num,yrange)';

subplot(2,3,2)
plot(x,y,'ko')
xlabel('MOAT mean')
txt = '$D_{PCL}$';
text(x(1)+0.02,y(1),txt,'interpreter','latex','FontSize',8)
txt = '$\kappa$';
text(x(2)+0.02,y(2),txt,'interpreter','latex','FontSize',8)
txt = '$D_{Chi}$';
text(x(3)+0.02,y(3),txt,'interpreter','latex','FontSize',8)
txt = '$B$';
text(x(4)+0.02,y(4),txt,'interpreter','latex','FontSize',8)
axis([-0.05 0.6 -1e-4 0.00123])

%% Dchi = 1e-12 cm2/s, Dpcl=1e-15 cm2/s, b=10%, k=1

% Customizable variables
sheet_num = 3; 
file_name = 'Moat_Info_COMSOL.xlsx'; %Reading spreadsheets

%Experimental time points
xrange = 'A2:A5';
x = xlsread(file_name,sheet_num,xrange)';

yrange = 'B2:B5';
y = xlsread(file_name,sheet_num,yrange)';

subplot(2,3,3)
plot(x,y,'ko')
xlabel('MOAT mean')
txt = '$B$';
text(x(1)+0.02,y(1),txt,'interpreter','latex','FontSize',8)
txt = '$D_{PCL}$';
text(x(2)+0.02,y(2),txt,'interpreter','latex','FontSize',8)
txt = '$\kappa$';
text(x(3)+0.02,y(3),txt,'interpreter','latex','FontSize',8)
txt = '$D_{Chi}$';
text(x(4)+0.02,y(4),txt,'interpreter','latex','FontSize',8)
axis([-0.05 0.6 -1e-4 0.00123])


labelstring = {'a)', 'b)', 'c)'};
for v = 1:3
    subplot(2,3,v)
    hold on
    text(-0.25, 1.05, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize',8)
    set(gca,'FontName','Arial','FontSize',8)
end


widthInches = 6.5;
heightInches = 5;
run('../ScriptForExportingImages.m')