#mlxtranFileName <- "WarfSAEM2comp_run2.mlxtran"
#dataPath <- "C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\SSE30_datasets"


doMlxtranPrep <- function(mlxtranFileName, dataPath, mlxDataFileList){
  # Read in Mlxtran
  mlxtranFile <- readLines(mlxtranFileName)
  mlxtranFileNameNoExt <- sub("\\.[[:alnum:]]+$", "", basename(as.character(mlxtranFileName)))
  userWD <- getwd()
  # Create a folder for the mlxtran files
  mlxDirName <- paste(mlxtranFileNameNoExt, format(Sys.time(), "%y%m%d_%H%M%S"), sep="_")
  dir.create(mlxDirName)
  setwd(mlxDirName)
  # Find the DATA line and assume the path and file name comes on the consecutive lines... not brilliant
  dataRowNumber <- grep("^DATA", mlxtranFile)
  dataPathRowNumber <- dataRowNumber + 1
  dataFileRowNumber <- dataRowNumber + 2
  # Find the DESCRIPTION line and assume the next line should be altered
  descRowNumber <- grep("^DESCRIPTION", mlxtranFile) + 1
  # Find the resultFolder and set it to the file name
  resFolderRowNumber <- grep("resultFolder", mlxtranFile)
  # Create one mlxtran file for each dataset
  nDataSets <- length(mlxDataFileList)
  for(i in 1:nDataSets){
    newMlxFileName <- paste("mlxestim", i, ".mlxtran", sep="")
    newMlxResFolderName <- paste("mlxestim", i, sep="")
    newMlxFile <- mlxtranFile
    newMlxFile[[descRowNumber]] <- newMlxFileName
    newMlxFile[[dataPathRowNumber]] <- paste('    path = "', dataPath, '",', sep="")
    newMlxFile[[dataFileRowNumber]] <- paste('    file  ="', mlxDataFileList[[i]], '",', sep="")
    newMlxFile[[resFolderRowNumber]] <- paste('        resultFolder="%MLXPROJECT%/', newMlxResFolderName, '"},', sep="")
    fileConn<-file(newMlxFileName)
    writeLines(newMlxFile, fileConn)
    close(fileConn)
  }
  setwd(userWD)
  mlxModelPath <- normalizePath(mlxDirName)
  return(mlxModelPath)
}


