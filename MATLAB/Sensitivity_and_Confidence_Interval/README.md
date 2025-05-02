# Sensitivity_and_Confidence_Interval
Codes for calculating or visualizing parameter sensitivity and confidence interval.


## Overview
This MATLAB scripts are used for the calculation and visualization of local sensitivity and confidence interval. Also, results obtained from COMSOL are used to visualize those results using MATLAB plots. 

## Authors
Eduardo A. Chacin Ruiz<sup>a</sup>,  Ashlee N. Ford Versypt<sup>a,b,c</sup>

<sup>a</sup>Department of Chemical and Biological Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>b</sup>Department of Biomedical Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>c</sup>Institute for Artificial Intelligence and Data Science, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>

## Manuscript
E.A. Chacin Ruiz and S. L. Carpenter and K. E. Swindle-Reilly and A. N. Ford Versypt, Mathematical Modeling of Drug Delivery from Bi-Layered Core-Shell Polymeric Microspheres, bioRxiv preprint, DOI: 10.1101/2024.01.11.575289 [Preprint](https://doi.org/10.1101/2024.01.11.575289)

## Scripts

* Combined_local_and_SOBOL.m This file plots a 3x2 figure where the top row is composed of local sensitivity analysis obtained from MATLAB and the bottom row is composed of SOBOL indices obtained from COMSOL.
* Confidence_Intervals.m This plots allows for the calculation of local sensitivity of the obtained estimated parameters, as well as calculation of the confidence interval of those parameters.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* MOAT.m This script is used to plot the Morris one-at-a-time results obtained from COMSOL.
* simps.m This file performs Simpson's numerical integration.
* solve_FD_spheres_variable_diffusivity.m This file solves the PDE for Fickian diffusion within a radially symmetric sphere.

## Data
* InitialGuesses_50_Simulations.xlsx This datasheet contains the information used and results for the final parameter estimation for both BSA and bevacizumab in MATLAB and COMSOL.
* MOAT_Info_COMSOL.xlsx This datasheet contains the COMSOL results of the MOAT mean and MOAT standard deviation for the parameters under different drug release regimens.
* MPs_release_6_months.xlsx This datasheet contains the experimental data for cumulative BSA and bevacizumab release with time.


## Acknowledgements
Research reported in this publication was supported by the National Institute of General Medical Sciences of the National Institutes of Health under award number R35GM133763 and NSF CAREER 2133411. The content is solely the responsibility of the authors and does not necessarily represent the official views of the funding agencies.
