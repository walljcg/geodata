Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS=TRUE);
options(timeout=30000);
install.packages(c("devtools"), dependencies=TRUE, repos="http://cran.rstudio.com/");
install.packages(c("rgdal"), dependencies=TRUE, repos="http://cran.rstudio.com/");
devtools::install_version(c("INLA"), version = "22.03.09", dependencies=TRUE, repos=c("https://inla.r-inla-download.org/R/testing"));
devtools::install_github(c("BastilleRousseau/moveNT@master"), dependencies=TRUE);
# devtools::install_github("inbo/inlatools", dependencies=TRUE);