# Design_Characteristics
Scripts for exploring or plotting different sizes of bi-layered microparticles.


## Overview
These different scripts are used to visualize the effect of different microparticles design on cumulative drug release and drug release rate.

## Authors
Eduardo A. Chacin Ruiz<sup>a</sup>,  Ashlee N. Ford Versypt<sup>a,b,c</sup>

<sup>a</sup>Department of Chemical and Biological Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>b</sup>Department of Biomedical Engineering, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>
<sup>c</sup>Institute for Artificial Intelligence and Data Science, University at Buffalo, The State University of New York, Buffalo, NY, USA<br/>

## Manuscript
E.A. Chacin Ruiz and S. L. Carpenter and K. E. Swindle-Reilly and A. N. Ford Versypt, Mathematical Modeling of Drug Delivery from Bi-Layered Core-Shell Polymeric Microspheres, bioRxiv preprint, DOI: 10.1101/2024.01.11.575289 [Preprint](https://doi.org/10.1101/2024.01.11.575289)

## Scripts

* Cumul_rel_and_rel_rate.m This script reads the information from Bilayered_MPs_Prediction.xlsx and makes two 6x4 figures with microparticles of different sizes. One figure shows the cumulative drug release and the other the drug release rate.
* FD_spheres_variable_diffusivity_two_spheres.m This file contains the finite difference discretization scheme for spheres.
* Multiple_Designs_Output.mlx This script allows to define a set of chitosan and PCL radii to test and the output is two mxn figures with microparticles of the different sizes chosen. One figure shows the cumulative drug release and the other the drug release rate.
* plotfill.m This scripts serves as a function to color the area that is within a predefined threshold.
* simps.m This file performs Simpson's numerical integration.
* Surface_Plot_3D.m The output from this script are 3 3D surface plots where one of the axis represents chitosan radii, another one PCL radii, and the last one depends on the plot. One plot is for days it takes to release a certain drug threshold, one plot is for days releasing a determined amount of drug, and the final plot is the intersection between the previous two plots.
 

## Data
* Bilayered_MPs_Prediction.xlsx This datasheet contains the cumulative drug release and drug release rate vs time data for the different core-shell designs.
* MPs_release_6_months.xlsx This datasheet contains the experimental data for cumulative drug release with time, and its standard deviation.



## Acknowledgements
Research reported in this publication was supported by the National Institute of General Medical Sciences of the National Institutes of Health under award number R35GM133763 and NSF CAREER 2133411. The content is solely the responsibility of the authors and does not necessarily represent the official views of the funding agencies.
