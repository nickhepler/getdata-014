#  downloading_files.R
#  Downloading Files

if (!file.exists("data")) {
    dir.create("data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,
  destfile = "./data/cameras.csv",
  method = "curl") #  Requied for Linux, Mac - use wb for Windows

list.files("./data")

dateDownloaded <- date()
dateDownloaded
