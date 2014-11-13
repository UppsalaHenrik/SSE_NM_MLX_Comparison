### Prep the PsN SSE data in the folder of choice to Monolix suitable format. 
### Returns list of generated data files.

# dataPath <- "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/SSE30_datasets"

doDataPrep <- function(dataPath){
  
  # Get use wd to be able to reset 
  userWD <- getwd()
  
  #Set wd to dataPath
  setwd(dataPath)
  
  
  dataSets <- list.files(dataPath, pattern="^mc")
  fileNum <- as.numeric(gsub('^mc-sim-([0-9]*)\\.dat$','\\1',dataSets))
  dataSetList <- dataSets[order(fileNum)]
  nDataSets <- length(dataSetList)
  for(i in 1:nDataSets){
    data <- read.table(dataSets[[i]], header=T, skip=1)
    write.table(data, paste("mlx_", dataSetList[[i]], sep=""), quote=F, row.names=F, sep=" ")
  }
  setwd(userWD)
  newDataSets <- list.files(dataPath, pattern="^mlx")
  newFileNum <- as.numeric(gsub('^mlx_mc-sim-([0-9]*)\\.dat$','\\1',newDataSets))
  newDataSetList <- newDataSets[order(fileNum)]
  return(newDataSetList)
}