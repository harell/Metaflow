# https://docs.metaflow.org/v/r/
pkgload::load_all()
# remotes::install_cran("reticulate")
# remotes::install_github("Netflix/metaflow", Sys.getenv("METAFLOW_VER"), subdir = "R")

#reticulate::use_miniconda(condaenv = Sys.getenv("METAFLOW_ENV"))
#reticulate::conda_create(envname = Sys.getenv("METAFLOW_ENV"), packages = c("python", "pip"))
#reticulate::use_condaenv(condaenv = Sys.getenv("METAFLOW_ENV"), required = TRUE)

metaflow::install(user_install = FALSE, upgrade = FALSE)
# Sys.setenv("USERNAME" = 'mfuser')
metaflow::test()
