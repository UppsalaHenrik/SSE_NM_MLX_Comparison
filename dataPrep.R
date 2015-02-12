### Prep the PsN SSE data in the folder of choice to Monolix suitable format. 
### Returns list of generated data files. Currently all this does is remove
### the top line that says "Table 1" or so. Seems to work though. Doing this
### without reading in the data would probably be preferable.

# dataPath <- "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/SSE30_datasets"

doDataPrep <- function(dataPath){
  
  # List SSE simulated data sets and order them correctly with 10 coming after 9 and so on
  dataSets <- list.files(dataPath, pattern="^mc")
  fileNum <- as.numeric(gsub('^mc-sim-([0-9]*)\\.dat$','\\1',dataSets))
  dataSetList <- dataSets[order(fileNum)]

  # Create a data folder
  dataFolderName <- "Data"
  dir.create(dataFolderName)
  
  # For each data file in the previously defined list
  nDataSets <- length(dataSetList)
  for(i in 1:nDataSets){
    data <- read.table(paste0(dataPath, "/", dataSets[[i]]), header=T, skip=1)
    write.table(data, paste0("./Data/", "mlx_", dataSetList[[i]]), quote=F, row.names=F, sep=" ")
  }
  
  # Return a correctly ordered list of the created data sets
  newDataSets <- list.files(dataFolderName, pattern="^mlx")
  newFileNum <- as.numeric(gsub('^mlx_mc-sim-([0-9]*)\\.dat$','\\1',newDataSets))
  newDataSetList <- newDataSets[order(fileNum)]
  return(newDataSetList)
}
