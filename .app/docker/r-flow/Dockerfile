# R Package Development---------------------------------------------------------
FROM rocker/tidyverse:4.0.0

# Setup ------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    dos2unix \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpq-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure RStudio Server -----------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2020-04-24\'
RUN echo "options(repos = ${R_REPOS})" >> .Rprofile
RUN R -q -e "if(!require(remotes)) install.packages('remotes')"
RUN R -q -e "remotes::install_cran('renv')"
RUN R -q -e "remotes::install_cran('profvis')"
RUN R -q -e "remotes::install_cran(c('devtools', 'testthat', 'covr', 'roxygen2'))"

# Install Python ---------------------------------------------------------------
RUN apt-get update && apt-get -y install python3.7 && \
    apt-get -y install python3-pip
RUN pip3 install virtualenv && pip3 install requests

# Install Metaflow -------------------------------------------------------------
ARG METAFLOW_VER='2.2.0'
RUN R -q -e "remotes::install_github('Netflix/metaflow', ${METAFLOW_VER}, 'R')"
RUN R -q -e "metaflow::install(user_install = FALSE, upgrade = FALSE)"

# Install Project Dependencies -------------------------------------------------
COPY ./DESCRIPTION ./DESCRIPTION
RUN R -q -e "remotes::install_deps(dependencies = 'Depends')"
RUN R -q -e "remotes::install_deps(dependencies = 'Imports')"
RUN R -q -e "remotes::install_deps(dependencies = 'Suggests')"

# Run RStudio Server -----------------------------------------------------------
RUN chown rstudio:rstudio home/rstudio/
ENV PASSWORD 1234
ENV ROOT true
