# A function for all of it
# setwd("C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/MLX_SSE_141205_141826")

repeatSSEinMonolix <- function(dataPath, mlxModelList){
  
  # Pick up the user's WD
  userWD <- getwd()
  
  # Create a date and time stamped folder for the run and make it the wd 
  mlxDirName <- paste("MLX_SSE", format(Sys.time(), "%y%m%d_%H%M%S"), sep="_")
  dir.create(mlxDirName)
  setwd(mlxDirName)
  
  # Prepare Monolix datasets from the PsN SSE datasets
  dataSetList <- doDataPrep(dataPath)
  
  # Prepare one Monolix model file for each input model and data set 
  initEstList <- lapply(mlxModelList, FUN = function(x) {doMlxtranPrep(x, dataSetList) })
  
  # Combine the initial estimates into one 
  initEsts <- do.call("rbind", initEstList)
  
  # Run all the runs!
  lapply(mlxModelList, FUN = function(x) {doRunMlx(x) })
  
  #Read in the results
  rawResults <- readMlxRun(mlxModelList)

  # Plot the results in boxplots
  boxPlotResults(rawResults, initEsts)  
  
  setwd(userWD)
  
  return(rawResults)
}