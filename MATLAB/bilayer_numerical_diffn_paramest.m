%function bilayer_numerical_diffn_paramest
clear variables
clc

%% This file deals with the parameter estimation of the microspheres.
%Themicrospheres can be composed of chitosan-only, or PCL-chitosan.
%The inner layer is always chitosan and the drug is loaded in this layer.
%The parameters that are being estimated are: drug diffusion coefficient in
% chitosan, drug diffusion coefficient in PCL, initial burst release, and 
% drug partition coefficient.

%% Initialize data for BSA from Berkland IntJPharm 2007 Data not normalized
format long e
use_stdv = 'no'; %Allows for the consideration of standard deviation. 'yes' for active, 'no' for inactive
material = 2; %Allows for mono- or bi-layered device. '1' for chitosan-only, and '2' for Chitosan-PCL
num_estim_param = 4; %For PCL-chitosan. '3' if fixing drug diffusion coefficient in chitosan. '4' if estimating all parameters

%Reading and organizing experimental data
data = matfile(['two_spheres_data_form', num2str(material), '_PCL_and_Chitosan.mat']); 
cumulreldata_all  = data.drugdelivery_rel; 
stddev_all = data.error_drugdelivery_rel;
tdata_all  = data.tdata; % days
R = data.R;
MAX_Number_of_times_to_include = length(tdata_all);
nondiffusion_points = 0;
Number_of_times_to_include = MAX_Number_of_times_to_include-nondiffusion_points;
cumulreldata = cumulreldata_all(1:Number_of_times_to_include);
stddev = stddev_all(1:Number_of_times_to_include);
tdata = tdata_all(1:Number_of_times_to_include);


%Setting standard deviation to a small number in case there is a 
%standard deviation equal to zero
if strcmp(use_stdv,'no')
    stddev_wt = ones(size(stddev));
    for i=1:length(stddev)
        if stddev(i) < 1e-10
            stddev(i) = 1e-10;
        end
    end
else
    stddev_wt = stddev; 
    for i=1:length(stddev_wt)
        if stddev_wt(i) < 1e-10
            stddev_wt(i) = 1e-10;
        end
    end
end


%% Set optimization options and initial guess for alpha
OPTIONS = optimoptions('lsqcurvefit','TolX', 1e-3, 'TolFun', 1e-3,'MaxFunctionEvaluations', 8.0e2); %Solver options

%The following values are acting as the upper limits for the parameter
%estimation. Inside the algorithm, the values are normalized so that the
%parameter estimation is going between 0-1.
DD0chitosan = 1e-13; % cm^2/s. For PCL-chitosan, it can be a fixed value (num_estim_param = 3) or can be estimated (num_estim_param = 4).
DD0pcl=5e-11; %cm^2/s. Used for PCL-chitosan.
burst0 = 100; % %
k0 = 10; % dimensionless

n_restart = 2; %Number of initializations

%This will help making sure we have a fair distribution between different
% orders of magnitude when using rand function ahead
ll = 0.01; %Lower limit guess for parameter estimation
ll2 = 0.00002; %Lower limit guess for parameter estimation of Dpcl
ul = 1; %Upper limit guess for parameter estimation
log_ll = log10(ll);
log_ll2 = log10(ll2);
log_ul = log10(ul);



%% Parameter estimation
%For the case of chitosan-only we are doing a single start. For the case of
%PCL-chitosan we are doing a multi-start process. In this multi-start
%process we are using a latin hypercube sampling for initial guesses at
%each of the iterations.
Ydata = cumulreldata./stddev_wt; %Experimental data to be compared to model


%Chitosan-only
if material == 1  %% Note: Multi-start currently set for the case of PCL-chitosan
   burst = zeros(1,n_restart);
   DDChi = zeros(1,n_restart);
   num_estim_param = 2;

   guess = lhsdesign(n_restart,num_estim_param); %Applying latin hypercube sampling for initial guesses
   for i=1:num_estim_param-1
       for j=1:n_restart
           guess(j,i) = 10^(log_ll + (log_ul-log_ll) * guess(j,i));
       end
   end

   parfor n=1:n_restart  %Executes for-loop iterations in parallel in available workers
       cumulreldata = cumulreldata_all(1:Number_of_times_to_include);
       [params, resnorm_fitted] = lsqcurvefit(@(params,t) solve_FD_spheres_variable_diffusivity(params,t,burst0,DD0chitosan,stddev_wt), [guess(n,1),guess(n,2)], tdata, Ydata,[0,0],[1,1],OPTIONS);
       burst(n) = params(1)*burst0
       DDChi(n) = params(2)*DD0chitosan

       if strcmp(use_stdv,'no')
           unweighted_norm(n) = resnorm_fitted
           cumulreldata = cumulreldata ./ stddev;
           Ycalc = solve_FD_spheres_variable_diffusivity(params,tdata,burst0,DD0chitosan,stddev);
           weighted_norm(n) = sum((Ycalc - cumulreldata).^2)
       elseif strcmp(use_stdv,'yes')
           Ycalc_weighted = solve_FD_spheres_variable_diffusivity(params,tdata,burst0,DD0chitosan,stddev_wt);
           Ycalc = Ycalc_weighted.*stddev_wt;
           unweighted_norm(n) = sum((Ycalc - cumulreldata).^2)
           weighted_norm(n) = resnorm_fitted
       end
   end




%PCL-chitosan   
elseif material == 2
    burst = zeros(1,n_restart);
    DDChi = zeros(1,n_restart);
    DDPCL = zeros(1,n_restart);
    k = zeros(1,n_restart);

    guess = lhsdesign(n_restart,num_estim_param); %Applying latin hypercube sampling for initial guesses
    for i=1:num_estim_param
        for j=1:n_restart
            if i == 2
                guess(j,i) = 10^(log_ll2 + (log_ul-log_ll2) * guess(j,i));
            else
                guess(j,i) = 10^(log_ll + (log_ul-log_ll) * guess(j,i));
            end
        end
    end
   
    parfor n=1:n_restart  %Executes for-loop iterations in parallel in available workers
        cumulreldata = cumulreldata_all(1:Number_of_times_to_include);
        if num_estim_param == 3
           [params, resnorm_fitted] = lsqcurvefit(@(params,t) solve_FD_spheres_variable_diffusivity(params,t,burst0,DD0chitosan,DD0pcl,stddev_wt,num_estim_param,k0), [guess(n,1),guess(n,2),guess(n,3)], tdata, Ydata,[0,0,0],[1,1,1],OPTIONS);
           burst (n) = params(1)*burst0;
           DDPCL (n) = params(2)*DD0pcl;
           k (n) = params (3)* k0;
        elseif num_estim_param == 4
           [params, resnorm_fitted] = lsqcurvefit(@(params,t) solve_FD_spheres_variable_diffusivity(params,t,burst0,DD0chitosan,DD0pcl,stddev_wt,num_estim_param,k0), [guess(n,1),guess(n,2),guess(n,3),guess(n,4)], tdata, Ydata,[0,0,0,0],[1,1,1,1],OPTIONS);
           burst (n) = params(1)*burst0;
           DDPCL (n) = params(2)*DD0pcl;
           DDChi (n) = params(3)*DD0chitosan;
           k (n) = params (4)*k0;
        end
        
       if strcmp(use_stdv,'no')
           unweighted_norm (n) = resnorm_fitted
           cumulreldata = cumulreldata ./ stddev;
           Ycalc = solve_FD_spheres_variable_diffusivity(params,tdata,burst0,DD0chitosan,DD0pcl,stddev,num_estim_param,k0);
           weighted_norm (n) = sum((Ycalc - cumulreldata).^2)
       elseif strcmp(use_stdv,'yes')
           Ycalc_weighted = solve_FD_spheres_variable_diffusivity(params,tdata,burst0,DD0chitosan,DD0pcl,stddev_wt,num_estim_param,k0);
           Ycalc = Ycalc_weighted.*stddev_wt;
           unweighted_norm (n) = sum((Ycalc - cumulreldata).^2)
           weighted_norm (n) = resnorm_fitted
       end
    end
end 

%% Overall best value
if strcmp(use_stdv,'no')
    [best_fit,best_fit_index] = min (unweighted_norm);
    b_unweighted_norm = best_fit;
    b_weighted_norm = weighted_norm(best_fit_index);
else
    [best_fit,best_fit_index] = min (weighted_norm);
    b_weighted_norm = best_fit;
    b_unweighted_norm = unweighted_norm(best_fit_index);
end

%% Plotting
if material == 1
    [cumul_rel_best, timevector] = solve_cumul_drug_rel(burst(best_fit_index),DDChi(best_fit_index));
    [cumul_rel_ave, timevector] = solve_cumul_drug_rel(mean(burst),mean(DDChi));
    data = matfile(['two_spheres_data_form', num2str(material), '_PCL_and_Chitosan.mat']);
    figure()
    errorbar(data.tdata, data.drugdelivery_rel, data.error_drugdelivery_rel, 'ko')
    hold on
    plot(timevector, cumul_rel_best, 'b', timevector, cumul_rel_ave,'--r')
    ylabel('Cumulative drug release (%)')
    xlabel('Time (days)')
    legend('Experimental data','Simulation results for best value', 'Simulation results for average value')
else
    [cumul_rel_best, timevector] = solve_cumul_drug_rel(burst(best_fit_index),DDChi(best_fit_index), DDPCL(best_fit_index), k(best_fit_index));
    [cumul_rel_ave, timevector] = solve_cumul_drug_rel(mean(burst),mean(DDChi), mean(DDPCL), mean(k));
    data = matfile(['two_spheres_data_form', num2str(material), '_PCL_and_Chitosan.mat']);
    figure()
    errorbar(data.tdata, data.drugdelivery_rel, data.error_drugdelivery_rel, 'ko')
    hold on
    plot(timevector, cumul_rel_best, 'b', timevector, cumul_rel_ave,'--r')
    ylabel('Cumulative drug release (%)')
    xlabel('Time (days)')
    legend('Experimental data','Simulation results for best value', 'Simulation results for average value')
end

%end