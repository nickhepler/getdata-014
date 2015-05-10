#  reading_local_flat_files.R
#  Reading Local Flat Files

cameraData <- read.table("./data/cameras.csv",
  sep = ",",
  header = TRUE)

head(cameraData)

rm(list = ls()) # Remove Global Environment variables.
unlink("./data/cameras.csv") # Delete downloaded file.