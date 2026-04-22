# Thermodynamic calculations for phosphorylation reactions

This repository accompanies a manuscript in preparation by D. E. LaRowe et al. (2026).

## Installation and usage

Install R and run these commands to install the development version of CHNOSZ (>= 2.2.0-13).
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
