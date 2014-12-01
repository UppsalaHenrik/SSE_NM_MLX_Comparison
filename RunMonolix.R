#mlxModelPath <- "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/WarfSAEM2comp_run2_141113_182028"
#i <- 5

doRunMlx <- function(mlxModelName){  
  
  # List the files in that dir and make sure that the order is correct: 10 comes after 9 rather than after 1
  newModels <- list.files(, pattern=paste0("^", mlxModelName)
  newFileNum <- as.numeric(gsub('^mlxestim([0-9]*)\\.mlxtran$','\\1',newModels))
  newMlxFileList <- newModels[order(newFileNum)]
  
  # Count the model files
  nMlxFiles <- length(newMlxFileList)

  # Set the directory to the Monolix dir for Monolix reasons... 
  # Not sure why but we have to be in that dir and point out to the model. 
  # Their batch files are odd
  MonolixWD <- 'C:\\ProgramData\\Monolix\\Monolix432s\\bin'
  setwd(MonolixWD)
  
  # Run each model in series. I use Monolix2.bat which is my manual edit with the %PATH% ECHO removed
  for(i in 1:nMlxFiles){
    command <- paste('Monolix2.bat -nowin -p ', mlxModelPath, '/', newMlxFileList[[i]], ' -f run', sep="")
    system(command)    
  }
  
  return(newMlxFileList)
}



#command <- 'Monolix2.bat -nowin -p C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/WarfSAEM2comp_run2.mlxtran -f run'
