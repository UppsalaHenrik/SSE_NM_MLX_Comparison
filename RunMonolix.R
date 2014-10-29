#mlxModelPath <- "C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\SSE30_datasets\\WarfSAEM2comp_run2_141029_101757"


doRunMlx <- function(mlxModelPath){  
  userWD <- getwd()
  setwd(mlxModelPath)
  newModels <- list.files(, pattern="^mlxestim")
  newFileNum <- as.numeric(gsub('^mlxestim([0-9]*)\\.mlxtran$','\\1',newModels))
  newMlxFileList <- newModels[order(newFileNum)]
  nMlxFiles <- length(newMlxFileList)
  MonolixWD <- 'C:\\ProgramData\\Monolix\\Monolix432s\\bin'
  setwd(MonolixWD)
  for(i in 1:nMlxFiles){
    command <- paste('Monolix2.bat -nowin -p ', mlxModelPath, '\\', newMlxFileList[[i]], ' -f run', sep="")
    system(command)    
  }
  setwd(userWD)
  return()
}



