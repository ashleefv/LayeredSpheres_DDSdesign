# LayeredSpheres_DDSdesign
Code for performing parameter estimation on core-shell or core microparticles using available data.


## Overview
This repository contains the MATLAB and COMSOL files from the manuscript cited below that simulates drug delivery from a single- or bi-layered microsphere and estimates the parameters (drug diffusion coefficient in chitosan, drug diffusion coefficient in PCL, burst release, and partition coefficient) that best fit a given input dataset of cumulative release vs. time. Latin hypercube sampling is used to determine the initial guesses in the multi-start approach.

## Code Authors
Eduardo A. Chacin Ruiz<sup>a</sup>,  Ashlee N. Ford Versypt<sup>a,b,c</sup>

<sup>a</sup>Department of Chemical and Biological Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>b</sup>Department of Biomedical Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>c</sup>Institute for Artificial Intelligence and Data Science, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>

## Manuscript
E.A. Chacin Ruiz, S. L. Carpenter, K. E. Swindle-Reilly, and A. N. Ford Versypt, Mathematical Modeling of Drug Delivery from Bi-Layered Core-Shell Polymeric Microspheres, bioRxiv preprint, DOI: 10.1101/2024.01.11.575289 [Preprint](https://doi.org/10.1101/2024.01.11.575289)

## MATLAB Folder scripts and data
* bilayer_numerical_diffn_paramest.m This file initializes the parameter estimation problem and calls the following code scripts to perform necessary functions.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* simps.m This file performs Simpson's numerical integration. [Source](https://www.mathworks.com/matlabcentral/fileexchange/25754-simpson-s-rule-for-numerical-integration)
* solve_cumul_drug_rel.m This file runs the forward problem for the average and best results for the parameter estimation.
* solve_FD_spheres_variable_diffusivity.m This file solves the PDE for Fickian diffusion within a radially symmetric sphere.
* CreateNodeFigure.m creates Figure S1
* two_spheres_data_form1_PCL_and_Chitosan.mat This data file contains the data for the experiments involving drug release from chitosan microparticles. A mat file must be loaded to perform the parameter estimation.
* two_spheres_data_form2_PCL_and_Chitosan.mat This data file contains the data for the experiments involving drug release from PCL-chitosan microparticles. A mat file must be loaded to perform the parameter estimation.

## Concentration_Comparisons folder scripts and data
* Plot_concentration_profiles.m This script reads the information from the datasheet and makes a figure composed of four concentration subplots.
* Concentration_comparison.xlsx This datasheet contains the concentration vs time data at four different microparticle position. At the center, at the middle of the core, at the interface, and at the middle of the shell.

## Design_Characteristics folder scripts and data
* Bilayered_MPs_Prediction.xlsx This datasheet contains the cumulative drug release and drug release rate vs time data for the different core-shell designs.
* Cumul_rel_and_rel_rate.m This script reads the information from Bilayered_MPs_Prediction.xlsx and makes two 6x4 figures with microparticles of different sizes. One figure shows the cumulative drug release and the other the drug release rate.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* MPs_release_6_months.xlsx This datasheet contains the experimental data for cumulative drug release with time, and its standard deviation.
* Multiple_Designs_Output.mlx This script allows to define a set of chitosan and PCL radii to test and the output is two mxn figures with microparticles of the different sizes chosen. One figure shows the cumulative drug release and the other the drug release rate.
* plotfill.m This scripts serves as a function to color the area that is within a predefined threshold.
* simps.m This file performs Simpson's numerical integration. [Source](https://www.mathworks.com/matlabcentral/fileexchange/25754-simpson-s-rule-for-numerical-integration)
* Surface_Plot_3D.m The output from this script are 3 3D surface plots where one of the axis represents chitosan radii, another one PCL radii, and the last one depends on the plot. One plot is for days it takes to release a certain drug threshold, one plot is for days releasing a determined amount of drug, and the final plot is the intersection between the previous two plots.

## Parameter_Estimation_Results folder scripts and data
* InitialGuesses_100_Simulations.xlsx This datasheet contains the information used and results for the preliminary parameter estimation for both BSA and bevacizumab in MATLAB and COMSOL.
* InitialGuesses_50_Simulations.xlsx This datasheet contains the information used and results for the final parameter estimation for both BSA and bevacizumab in MATLAB and COMSOL.
* Plots_Bev_100_IC.m This script reads the preliminary parameter estimation results for bevacizumab from InitialGuesses_100_Simulations.xlsx and the output is a 2x2 plot comparing average and best results for COMSOL and MATLAB, and the error values obtained.
* Plots_Bev_50_IC.m This script reads the final parameter estimation results for bevacizumab from InitialGuesses_50_Simulations.xlsx and the output is a 2x2 plot comparing average and best results for COMSOL and MATLAB, and the error values obtained.
* Plots_BSA_100_IC.m This script reads the preliminary parameter estimation results for bevacizumab from InitialGuesses_100_Simulations.xlsx and the output is a 2x2 plot comparing average and best results for COMSOL and MATLAB, and the error values obtained.
* Plots_BSA_50_IC.m This script reads the final parameter estimation results for BSA from InitialGuesses_50_Simulations.xlsx and the output is a 2x2 plot comparing average and best results for COMSOL and MATLAB, and the error values obtained.

## Sensitivity_and_Confidence_Interval folder scripts and data
* Combined_local_and_SOBOL.m This file plots a 3x2 figure where the top row is composed of local sensitivity analysis obtained from MATLAB and the bottom row is composed of SOBOL indices obtained from COMSOL.
* Confidence_Intervals.m This plots allows for the calculation of local sensitivity of the obtained estimated parameters, as well as calculation of the confidence interval of those parameters.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* InitialGuesses50Simulations.xlsx This datasheet contains the information used and results for the final parameter estimation for both BSA and bevacizumab in MATLAB and COMSOL.
* MOAT.m This script is used to plot the Morris one-at-a-time results obtained from COMSOL.
* MOAT_Info_COMSOL.xlsx This datasheet contains the COMSOL results of the MOAT mean and MOAT standard deviation for the parameters under different drug release regimens.
* MPs_release_6_months.xlsx This datasheet contains the experimental data for cumulative drug release with time, and its standard deviation.
* simps.m This file performs Simpson's numerical integration. [Source](https://www.mathworks.com/matlabcentral/fileexchange/25754-simpson-s-rule-for-numerical-integration)
* solve_FD_spheres_variable_diffusivity.m This file solves the PDE for Fickian diffusion within a radially symmetric sphere.

## COMSOL Folder Scripts
* Optimization_MP_Chitosan_PCL.mph This file can be used to perform the parameter estimation for a given dataset.
* Uncertainty_MP_Chitosan_PCL.mph This file can be used to perform sensitivity analysis (MOAT and SOBOL) for the model parameters.

## COMSOL Folder Data
* BSA_Experimental_data_MPs_Chitosan-PCL.csv This datasheet contains the experimental data for the cumulative release of BSA with time (in seconds)
* Bevacizumab_Experimental_data_MPs_Chitosan-PCL.csv This datasheet contains the experimental data for the cumulative release of bevacizumab with time (in seconds)

## Acknowledgements
This work was supported by National Institutes of Health grant R35GM133763 to ANFV, R01EB032870 to KESR and ANFV, and the Owen Locke Foundation to KESR. The content is solely the responsibility of the authors and does not necessarily represent the official views of the funding agencies.
