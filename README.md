# Thermodynamic calculations for phosphorylation reactions

This repository accompanies a manuscript in preparation by D. E. LaRowe et al. (2026).

- `sugars.csv` contains thermodynamic parameters formatted for the OBIGT database in CHNOSZ.
  The parameters for organic phosphates and related species were developed in the manuscript.
- `plot.R` is an R script for creating plots of the non-standard Gibbs energy of phosphorylation reactions
  as a function of temperature (*T*), pressure (*P*), and pH.
  It depends on the `phospho.plot()` and `phosphorylate()` functions in the development version of CHNOSZ.

## Installation and usage

Install R and run these commands to install the development version of CHNOSZ (>= 2.2.0-61).
Note: Version 2.2.0 (the current release version on CRAN) is insufficient to run the code.

```r
install.packages("remotes")
remotes::install_github("jedick/CHNOSZ")
```

Put `plot.R` and `sugars.csv` in the R working directory.
Then, source the script and run the function to create the plots.

```r
source("plot.R")
plotall()
```

This saves the plots as PDF files in the working directory.

The *T*-pH and *P*-pH plots are made for constant *P* and *T*, respectively (defaults: *P*<sub>sat</sub> and 25 °C).
Modify the arguments to make the plots at different constant *P* and *T* (example: 5000 bar and 200 °C):

```r
plotall(const_T = 200, const_P = 5000)
```
