Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS=TRUE);
options(timeout=30000);
# install.packages(c("feather"), dependencies=TRUE, repos=c("http://cran.us.r-project.org"));
install.packages(c("INLA"),  dependencies=TRUE, repos=c("https://inla.r-inla-download.org/R/testing"));
# install.packages("devtools")
# devtools::install_github("wesm/feather/R")