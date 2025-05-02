# LayeredSpheres_DDSdesign
Code for performing parameter estimation on Core-Shell or Core microparticles using available data.


## Overview
This MATLAB model estimates the parameters (drug diffusion coefficient in chitosan, drug diffusion coefficient in PCL, burst release, and partition coefficient) that best describe a given input dataset. Latin hypercube sampling is used to determine the initial guesses in the multi-start approach.

## Authors
Eduardo A. Chacin Ruiz<sup>a</sup>,  Ashlee N. Ford Versypt<sup>a,b,c</sup>

<sup>a</sup>Department of Chemical and Biological Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>b</sup>Department of Biomedical Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>c</sup>Institute for Artificial Intelligence and Data Science, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>

## Manuscript
E.A. Chacin Ruiz and S. L. Carpenter and K. E. Swindle-Reilly and A. N. Ford Versypt, Mathematical Modeling of Drug Delivery from Bi-Layered Core-Shell Polymeric Microspheres, bioRxiv preprint, DOI: 10.1101/2024.01.11.575289 [Preprint](https://doi.org/10.1101/2024.01.11.575289)

## Scripts

* bilayer_numerical_diffn_paramest.m This file initializes the parameter estimation problem and calls the following code scripts to perform necessary functions.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* simps.m This file performs Simpson's numerical integration.
* solve_cumul_drug_rel.m This file runs the forward problem for the average and best results for the parameter estimation.
* solve_FD_spheres_variable_diffusivity.m This file solves the PDE for Fickian diffusion within a radially symmetric sphere.

## Data
* two_spheres_data_form1_PCL_and_Chitosan.mat This data file contains the data for the experiments involving drug release from chitosan microparticles. A mat file must be loaded to perform the parameter estimation.
* two_spheres_data_form2_PCL_and_Chitosan.mat This data file contains the data for the experiments involving drug release from PCL-chitosan microparticles. A mat file must be loaded to perform the parameter estimation.


## Acknowledgements
Research reported in this publication was supported by the National Institute of General Medical Sciences of the National Institutes of Health under award number R35GM133763 and NSF CAREER 2133411. The content is solely the responsibility of the authors and does not necessarily represent the official views of the funding agencies.
