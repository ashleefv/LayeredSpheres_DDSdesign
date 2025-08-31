close all
%figure 2
run('Sensitivity_and_Confidence_Interval/Combined_local_and_SOBOL.m')
%figure 3
run('Parameter_Estimation_Results/Plots_BSA_50_IC.m')
%figure 4
run('Parameter_Estimation_Results/Plots_Bev_50_IC.m')
%figures 5 and 6
run('Design_Characteristics/Cumul_rel_and_rel_rate.m')
%figure 7  
run('Design_Characteristics/Plot_3D_Surface_Results.m')

%figure S2
run('Concentration_Comparisons/Plot_concentration_profiles.m')
%figure S3('Cumulative_Release_Verification/Plot_cumul_rel,m')
run('Concentration_Comparisons/Plot_concentration_profiles.m')
%figure S4
run('Diffusion_Boundaries/LowerAndUpperLimitsForDiffusions.m')
%figure S5
run('Parameter_Estimation_Results/Plots_BSA_100_IC.m')
%figure S6
run('Parameter_Estimation_Results/Plots_Bev_100_IC.m')
%figure S7
run('Diffusion_Regimes/Plot_Diffusion_Regimes.m')
%figure S8
run('Sensitivity_and_Confidence_Interval/MOAT.m')
%figure S9 and S10
run('Design_Characteristics/Cumul_rel_and_rel_rate_Supplementary.m')
%figure S11
run('Design_Characteristics/Plot_3D_Surface_Results_Supplementary.m')

% figure S1
% run this one last because it overrides some font choices in other figures
CreateNodeFigure
