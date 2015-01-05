

doRunMlx <- function(mlxModel){  
  
  # Pick out the model name from the path
  mlxModelNameNoExt <- sub("\\.[[:alnum:]]+$", "", basename(as.character(mlxModel)))
  
  # List the files in that dir and make sure that the order is correct: 10 comes after 9 rather than after 1
  newModels <- list.files(, pattern=paste0("^", mlxModelNameNoExt))
  newFileNum <- as.numeric(gsub(paste0("^", mlxModelNameNoExt, '([0-9]*)\\.mlxtran$'), '\\1',newModels))
  newMlxFileList <- newModels[order(newFileNum)]
  newMlxFilePaths <- normalizePath(newMlxFileList)
  
  # Count the model files
  nMlxModels <- length(newMlxFileList)
  
  # Print a message for the model that is being run
  print(paste("Running", nMlxModels, "samples of model", mlxModelNameNoExt))

  # Set the directory to the Monolix dir for Monolix reasons... 
  # Not sure why but we have to be in that dir and point out to the model. 
  # Their batch files are odd
  userWD <- getwd()
  MonolixWD <- 'C:\\ProgramData\\Monolix\\Monolix432s\\bin'
  setwd(MonolixWD)
  
  # Run each model in series. I use Monolix2.bat which is my manual edit with the %PATH% ECHO removed
  for(i in 1:nMlxModels){
    command <- paste('Monolix2.bat -nowin -p ', newMlxFilePaths[[i]], ' -f run', sep="")
    system(command)    
  }
  
  setwd(userWD)
  
  return()
}

