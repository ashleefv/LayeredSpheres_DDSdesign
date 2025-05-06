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

## MATLAB Folder Scripts

* bilayer_numerical_diffn_paramest.m This file initializes the parameter estimation problem and calls the following code scripts to perform necessary functions.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* simps.m This file performs Simpson's numerical integration. [Source](https://www.mathworks.com/matlabcentral/fileexchange/25754-simpson-s-rule-for-numerical-integration)
* solve_cumul_drug_rel.m This file runs the forward problem for the average and best results for the parameter estimation.
* solve_FD_spheres_variable_diffusivity.m This file solves the PDE for Fickian diffusion within a radially symmetric sphere.

## MATLAB Folder Data
* two_spheres_data_form1_PCL_and_Chitosan.mat This data file contains the data for the experiments involving drug release from chitosan microparticles. A mat file must be loaded to perform the parameter estimation.
* two_spheres_data_form2_PCL_and_Chitosan.mat This data file contains the data for the experiments involving drug release from PCL-chitosan microparticles. A mat file must be loaded to perform the parameter estimation.


## Acknowledgements
This work was supported by National Institutes of Health grant R35GM133763 to ANFV, R01EB032870 to KESR and ANFV, and the Owen Locke Foundation to KESR. The content is solely the responsibility of the authors and does not necessarily represent the official views of the funding agencies.
