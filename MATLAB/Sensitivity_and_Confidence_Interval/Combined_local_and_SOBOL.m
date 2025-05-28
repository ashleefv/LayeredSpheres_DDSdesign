%% Local sensitivity calculations
% Dchi = 1e-15 cm2/s, Dpcl=1e-12 cm2/s, b=10%, k=1
parameters=categorical({'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});
%Results obtained from MATLAB
y1 = [0.193177, 0.334039, 0.000883, 0.002286];

% Plotting
figure(2)
figname = 'figure2';
subplot(2,3,1)
bar(parameters,y1,'k')
ylabel('$\left|N_{Q(28,p)}\right|$','Interpreter','latex','FontName','Arial','FontSize',8)
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
set(gca,'YScale','log','XTickLabel',labels,'TickLabelInterpreter','latex','FontName','Arial','FontSize',8)
ylim([10e-8 10e-1])

% Dchi = 1e-14 cm2/s, Dpcl=1e-14 cm2/s, b=10%, k=1
parameters=categorical({'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});
%Results obtained from MATLAB
y1 = [0.111371, 0.196599, 0.436615, 0.273063];
%Plotting
subplot(2,3,2)
bar(parameters,y1,'k')
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
set(gca,'YScale','log','XTickLabel',labels,'TickLabelInterpreter','latex','FontName','Arial','FontSize',8)
ylim([10e-8 10e-1])

% Dchi = 1e-12 cm2/s, Dpcl=1e-15 cm2/s, b=10%, k=1
parameters=categorical({'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});
%Results obtained from MATLAB
y1 = [0.806381, 0.201462, 0.33742, 0.247183];
%Plotting
subplot(2,3,3)
bar(parameters,y1,'k')
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
set(gca,'YScale','log','XTickLabel',labels,'TickLabelInterpreter','latex','FontName','Arial','FontSize',8)
ylim([10e-8 10e-1])

%% Sobol
% Dchi = 1e-15 cm2/s, Dpcl=1e-12 cm2/s, b=10%, k=1
parameters=categorical({'D_{Chi}', 'B', '\kappa', 'D_{PCL}'});
%Results obtained from COMSOL
y1 = [0.74953, 0.25035, 6.0652e-5, 3.0560e-5];
y2 = [0.74953, 0.25035, 6.0652e-5, 3.0560e-5];

%Plotting
subplot(2,3,4)
bar(parameters,[y1;y2])
xlabel('Parameters','FontName','Arial','FontSize',8)
ylabel('Sobol indices','FontName','Arial','FontSize',8)
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
set(gca,'YScale','log','XTickLabel',labels,'TickLabelInterpreter','latex','FontName','Arial','FontSize',8)
ylim([10e-8 10e-1])

% Dchi = 1e-14 cm2/s, Dpcl=1e-14 cm2/s, b=10%, k=1
parameters=categorical({'D_{PCL}', '\kappa', 'D_{Chi}', 'B'});
%Results obtained from COMSOL
y1 = [0.61063, 0.23222, 0.11762, 0.039533];
y2 = [0.61063, 0.23222, 0.11762, 0.039533];

%Plotting
subplot(2,3,5)
bar(parameters,[y1;y2])
xlabel('Parameters','FontName','Arial','FontSize',8)
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
set(gca,'YScale','log','XTickLabel',labels,'TickLabelInterpreter','latex','FontName','Arial','FontSize',8)
ylim([10e-8 10e-1])

% Dchi = 1e-12 cm2/s, Dpcl=1e-15 cm2/s, b=10%, k=1
parameters=categorical({'B', 'D_{PCL}', '\kappa', 'D_{Chi}'});
%Results obtained from COMSOL
y1 = [0.70498, 0.26738, 0.027632, 5.8289e-7];
y2 = [0.70498, 0.26738, 0.027632, 5.8289e-7];

%Plotting
subplot(2,3,6)
bar(parameters,[y1;y2])
xlabel('Parameters','FontName','Arial','FontSize',8)
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
set(gca,'YScale','log','XTickLabel',labels,'TickLabelInterpreter','latex','FontName','Arial','FontSize',8)
ylim([10e-8 10e-1])

%Overall legend

legend('First-order Sobol index', 'Total Sobol index','FontName','Arial','FontSize',8)
h = legend('Location','northoutside', 'Orientation', 'horizontal');
p = [0.5 0.51 0.03 0.03]; %Format: [left bottom width height] in normalized units
set(h,'Position', p,'Units', 'normalized');

labelstring = {'a)', 'b)', 'c)','d)','e)','f)'};
for v = 1:6
    subplot(2,3,v)
    hold on
    text(-0.225, 1.1, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize',8)
end

widthInches = 6.5;
heightInches = 5;
run('../ScriptForExportingImages.m')