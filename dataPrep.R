### Prep the PsN SSE data in the folder of choice to Monolix suitable format. 
### Returns list of generated data files. Currently all this does is remove
### the top line that says "Table 1" or so. Seems to work though. Doing this
### without reading int the data would probably be preferable.

# dataPath <- "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/SSE30_datasets"

doDataPrep <- function(dataPath){
  
  # Get user wd to be able to reset and then set wd to the given folder 
  userWD <- getwd()
  setwd(dataPath)
  
  # List SSE simulated data sets and order them correctly with 10 coming after 9 and so on
  dataSets <- list.files(dataPath, pattern="^mc")
  fileNum <- as.numeric(gsub('^mc-sim-([0-9]*)\\.dat$','\\1',dataSets))
  dataSetList <- dataSets[order(fileNum)]

  # For each data file in the previously defined list
  nDataSets <- length(dataSetList)
  for(i in 1:nDataSets){
    data <- read.table(dataSets[[i]], header=T, skip=1)
    write.table(data, paste("mlx_", dataSetList[[i]], sep=""), quote=F, row.names=F, sep=" ")
  }
  
  # Set the wd back and return a correctly ordered list of the created data sets
  setwd(userWD)
  
  newDataSets <- list.files(dataPath, pattern="^mlx")
  newFileNum <- as.numeric(gsub('^mlx_mc-sim-([0-9]*)\\.dat$','\\1',newDataSets))
  newDataSetList <- newDataSets[order(fileNum)]
  return(newDataSetList)
}