################################################################################
## Episode 0: Vanilla R
################################################################################
# Setup -------------------------------------------------------------------
pkgload::load_all()
setwd(usethis::proj_path("./inst/user2020_tutorials/episode0_vanilla_R"))
source("./scripts/pull_data.R")
source("./scripts/compute_features.R")
source("./scripts/build_model.R")
source("./scripts/utils.R")

# Data Modelling ----------------------------------------------------------
message("==== ingest and clean data ====")
dt <- pull_house_data()

message("==== compute features ====")
features <- compute_features(dt)

message("==== build a model ====")
fitted.model <- build_model(features)

message("==== summarize a model ====")
summarize_model(fitted.model)

# Cleanup -----------------------------------------------------------------
setwd(usethis::proj_get())
