clear variables
%clc
%%

% Customizable variables
num_params = 2; %Number of parameters estimated
percent = 1; %percent parameter perturbation
sheet_num = 2; %Use 1 for BSA, 2 for Bevacizumab
file_name = 'MPs_release_6_months_data.xlsx'; %Reading spreadsheets
conf_lvl = 95; % desired confidence level in %
software = 'MATLAB'; % 'MATLAB' for MATLAB or 'COMSOL' for COMSOL
scaling_factor = 1e-13; %To avoid inverting small values in matrices (Scaling factor for DChi)

%Experimental time points
trange = 'A2:A12';
t = xlsread(file_name,sheet_num,trange)';
num_meas = length(t); %Number of measurements

%% Set the multiplier (params) and optimal values for the parameters
params = [1,1];

results_file = 'Initial_Guesses_50_Simulations.xlsx';
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
    p = [burst0, DD0chitosan];
elseif sheet_num == 2
    if strcmpi(software, 'MATLAB')
        sheet = 3;
    elseif strcmpi(software, 'COMSOL')
        sheet = 4;
    end
    burst0 = xlsread(results_file,sheet,param1); % % 
    DD0chitosan = xlsread(results_file,sheet,param2); % cm^2/s, 
    p = [burst0, DD0chitosan];
end

%% Loop over three radius data sets for BSA
k0 = 1; %Fixed partition coefficient (k) value
DD0pcl = 1000*DD0chitosan; %Fixed drug diffusion coefficient in PCL (D_{PCL}) value
y_out = solve_FD_spheres_sensitivity(params,t,burst0,DD0chitosan,DD0pcl,k0);

S_FD = [];
for i = 1:length(p)
    dp = params; %reset parameters
    dp(i) = dp(i)*(1+percent*1e-2); %perturb i-th parameter by a small amount
    dy = solve_FD_spheres_sensitivity(dp,t,burst0,DD0chitosan,DD0pcl,k0);

% Obtain the sensitivities of all time points for each parameter perturbation
    if i == 2
        p(i) = p(i)/scaling_factor;
    end
    S_FD = [S_FD (dy-y_out)/p(i)/(percent*1e-2)];
end

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

%Var-covar matrix for the parameters
S = S_FD;
Vp = inv((S'*S))*S'*Vy*S*inv(S'*S); 

%Standard deviations for parameters
Sd = sqrt(diag(Vp));


%% Calculating confidence intervals for a desired confidence 
prob = 1-(1-conf_lvl/100)/2;

%Confidence interval for burst
burst_lb = p(1) - tinv(prob,num_meas-num_params) * Sd(1); %p(1) = burst0;
burst_ub =p(1) + tinv(prob,num_meas-num_params) * Sd(1);

%Confidence interval for D_chitosan
Dchitosan_lb = p(2) - tinv(prob,num_meas-num_params) * Sd(2); %p(2) =  DD0chitosan/scaling_factor;
Dchitosan_ub = p(2) + tinv(prob,num_meas-num_params) * Sd(2);

parameter = ["B";"D_{Chi}"];
Lower_Boundary = [burst_lb;Dchitosan_lb*scaling_factor];
Average = [p(1); p(2)*scaling_factor];
Upper_Boundary = [burst_ub;Dchitosan_ub*scaling_factor];

table(parameter,Lower_Boundary,Average,Upper_Boundary)