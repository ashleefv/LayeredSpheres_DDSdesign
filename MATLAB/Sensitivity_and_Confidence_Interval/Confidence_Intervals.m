clear variables
%clc
%%

% Customizable variables
num_params = 2; %Number of parameters estimated
percent = 1; %percent parameter perturbation
sheet_num = 2; %Use 1 for BSA, 2 for Bevacizumab
file_name = 'MPs_release_6_months_data.xlsx'; %Reading spreadsheets
conf_lvl = 95; % desired confidence level in %
software = 'COMSOL'; % 'MATLAB' for MATLAB or 'COMSOL' for COMSOL

%Experimental time points
trange = 'A2:A12';
t = xlsread(file_name,sheet_num,trange)';
num_meas = length(t); %Number of measurements

%% Set the multiplier (params) and optimal values for the parameters
params = [1,1,1,1];
k0 = 1; % dimensionless partition coefficient

results_file = 'InitialGuesses50Simulations.xlsx';
param1 = 'J54';
param2 = 'K54';
param3 = 'L54';

if sheet_num == 1
    if strcmpi(software, 'MATLAB')
        sheet = 1;
    elseif strcmpi(software, 'COMSOL')
        sheet = 2;
    end
    burst0 = xlsread(results_file,sheet,param1); % % 
    DD0chitosan = xlsread(results_file,sheet,param2); % cm^2/s, 
    DD0pcl= xlsread(results_file,sheet,param3); %cm^2/s.
    p = [burst0, DD0pcl, DD0chitosan, k0];
elseif sheet_num == 2
    if strcmpi(software, 'MATLAB')
        sheet = 3;
    elseif strcmpi(software, 'COMSOL')
        sheet = 4;
    end
    burst0 = xlsread(results_file,sheet,param1); % % 
    DD0chitosan = xlsread(results_file,sheet,param2); % cm^2/s, 
    DD0pcl= xlsread(results_file,sheet,param3); %cm^2/s.
    p = [burst0, DD0pcl, DD0chitosan, k0];
end

%% Loop over three radius data sets for BSA

y_out = solve_FD_spheres_variable_diffusivity(params,t,burst0,DD0chitosan,DD0pcl,k0);

S_FD = [];
S_FD_norm = [];
for i = 1:length(params)
    dp = params; %reset parameters
    dp(i) = dp(i)*(1+percent*1e-2); %perturb i-th parameter by a small amount
    dy = solve_FD_spheres_variable_diffusivity(dp,t,burst0,DD0chitosan,DD0pcl,k0);

% Obtain the sensitivities of all time points for each parameter perturbation
    S_FD = [S_FD (dy-y_out)/p(i)/(percent*1e-2)];
    S_FD_norm = [S_FD_norm ((abs(dy(9)-y_out(9))))/(percent*1e-2)/(y_out(9))]; %i=9 is equivalent to 28 days
end

S_FD_ordered = [S_FD(:,1), S_FD(:,3), S_FD(:,2), S_FD(:,4)]; %Reordering to have Dchi followed by Dpcl
S_FD_norm_ordered = [S_FD_norm(:,1), S_FD_norm(:,3), S_FD_norm(:,2), S_FD_norm(:,4)]; %Reordering to have Dchi followed by Dpcl

parameters=categorical({'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});
parameters=reordercats(parameters,{'B', 'D_{Chi}', 'D_{PCL}', '\kappa'});  %Formatting the bar graph X axis
labels={'$B$', '$D_{Chi}$', '$D_{PCL}$', '$\kappa$'};
figure()

bar(parameters, S_FD_norm_ordered),xlabel('Parameters'), ylabel('Normalized absolute change on cumulative drug release after 28 days')
set(gca,'YScale','log','xtick',parameters,'XTickLabel',labels,'TickLabelInterpreter','latex');
ylim([10e-5 10e-1])

%% Calculating variance-covariance matrix 

%Experimental measurements
yrange1 = 'H2:H12';
yrange2 = 'I2:I12';
yrange3 = 'J2:J12';

if sheet_num == 1
    %BSA Measurements
    measurements_1 = xlsread(file_name,sheet_num,yrange1)';
    measurements_2 = xlsread(file_name,sheet_num,yrange2)';
    measurements_3 = xlsread(file_name,sheet_num,yrange3)';
elseif sheet_num == 2
    %Bevacizumab Measurements
    measurements_1 = xlsread(file_name,sheet_num,yrange1)';
    measurements_2 = xlsread(file_name,sheet_num,yrange2)';
    measurements_3 = xlsread(file_name,sheet_num,yrange3)';
end

%Measurement values and covariates
measurements_matrix = [measurements_1; measurements_2; measurements_3];
Vy=cov(measurements_matrix); 
S = S_FD_ordered;

%Var-covar matrix for the parameters
Vp = inv((S'*S))*S'*Vy*S*inv(S'*S); 

%Standard deviations for parameters
Sd = sqrt(diag(Vp));


%% Calculating confidence intervals for a desired confidence 
prob = 1-(1-conf_lvl/100)/2;

%Confidence interval for burst
burst_lb = burst0 - tinv(prob,num_meas-num_params) * Sd(1);
burst_ub = burst0 + tinv(prob,num_meas-num_params) * Sd(1);

%Confidence interval for D_chitosan
Dchitosan_lb = DD0chitosan - tinv(prob,num_meas-num_params) * Sd(2);
Dchitosan_ub = DD0chitosan + tinv(prob,num_meas-num_params) * Sd(2);

parameter = ["B";"D_{Chi}"];
Lower_Boundary = [burst_lb;Dchitosan_lb];
Average = [burst0; DD0chitosan];
Upper_Boundary = [burst_ub;Dchitosan_ub];

% %Confidence interval for D_PCL
% DPCL_lb = DD0pcl - tinv(prob,num_meas-num_params) * Sd(3);
% DPCL_ub = DD0pcl + tinv(prob,num_meas-num_params) * Sd(3);

% parameter = ["B";"D_{Chi}";"D_{PCL}"];
% Lower_Boundary = [burst_lb;Dchitosan_lb;DPCL_lb];
% Average = [burst0; DD0chitosan; DD0pcl];
% Upper_Boundary = [burst_ub;Dchitosan_ub;DPCL_ub];

table(parameter,Lower_Boundary,Average,Upper_Boundary)

% %Confidence interval for k
% k_lb = k0 - tinv(prob,num_meas-num_params) * Sd(4)
% k_ub = k0 + tinv(prob,num_meas-num_params) * Sd(4)