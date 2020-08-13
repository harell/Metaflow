FROM rocker/tidyverse:4.0.0
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2020-04-24\'

# Setup ------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure R for Package Development ------------------------------------------
RUN R -q -e "if(!require(remotes)) install.packages('remotes', repos = ${R_REPOS})"
RUN R -q -e "remotes::install_cran(c('devtools', 'testthat', 'covr', 'roxygen2'), repos = ${R_REPOS})"

# Package Management System ----------------------------------------------------
ARG R_PACKAGE_NAME=sample-package
COPY ./DESCRIPTION ./${R_PACKAGE_NAME}/DESCRIPTION
WORKDIR /${R_PACKAGE_NAME}
RUN R -q -e "if(!require(remotes)) install.packages('remotes', repos = ${R_REPOS})"
RUN R -q -e "remotes::install_deps(dependencies = 'Depends',   repos = ${R_REPOS})"
RUN R -q -e "remotes::install_deps(dependencies = 'Imports',   repos = ${R_REPOS})"
RUN R -q -e "remotes::install_deps(dependencies = 'Suggests',  repos = ${R_REPOS})"

# Prepare Package Files --------------------------------------------------------
COPY . /${R_PACKAGE_NAME}
RUN rm -rf .Rprofile

# Prepare Package Files --------------------------------------------------------
RUN R -q -e "devtools::check(error_on = 'error')"
RUN R -q -e "system.time({\
               devtools::load_all(export_all = FALSE, helpers = FALSE);\
               testthat::test_dir('./tests/testthat', stop_on_failure = TRUE)\
             })"
