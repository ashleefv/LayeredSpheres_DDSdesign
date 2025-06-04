clear variables
%clc
%%

% Customizable variables
percent = 1; %percent parameter perturbation
file_name = 'MPs_release_6_months_data.xlsx';
sheet_num = 1;

%Experimental time points
trange = 'A2:A12';
t = xlsread(file_name,sheet_num,trange)';
num_meas = length(t); %Number of measurements

%% Set the multiplier (params) and optimal values for the parameters
params = [1,1,1,1];
k0 = 1; % dimensionless partition coefficient
burst0 = 10; % %
DD0chitosan = 1e-14; % cm^2/s,
DD0pcl= 1e-14; %cm^2/s.
p = [burst0, DD0pcl, DD0chitosan, k0];


%% Loop over three radius data sets for BSA

y_out = solve_FD_spheres_sensitivity(params,t,burst0,DD0chitosan,DD0pcl,k0);
S_FD_norm = [];

for i = 1:length(params)
    dp = params; %reset parameters
    dp(i) = dp(i)*(1+percent*1e-2); %perturb i-th parameter by a small amount
    dy = solve_FD_spheres_sensitivity(dp,t,burst0,DD0chitosan,DD0pcl,k0);

% Obtain the sensitivities of all time points for each parameter perturbation
    S_FD_norm = [S_FD_norm ((abs(dy(9)-y_out(9))))/(percent*1e-2)/(y_out(9))]; %i=9 is equivalent to 28 days
end

S_FD_norm_ordered = [S_FD_norm(:,1), S_FD_norm(:,3), S_FD_norm(:,2), S_FD_norm(:,4)]; %Reordering to have Dchi followed by Dpcl

parameters=categorical({'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});
parameters=reordercats(parameters,{'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});  %Formatting the bar graph X axis
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
figure()

bar(parameters, S_FD_norm_ordered),xlabel('Parameters'), ylabel('Normalized absolute change on cumulative drug release after 28 days')
set(gca,'YScale','log','xtick',parameters,'XTickLabel',labels,'TickLabelInterpreter','latex');
ylim([10e-8 10e-1])