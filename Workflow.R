
setwd('C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix')


### Prep the data in the folder of choice. 
### Returns list of generated data files

mlxDataFileList <- doDataPrep("C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\SSE30_datasets")


### Take a mlxtran file and create one for each data set
### Returns the subfolder name that contains the generated mlxtran files

mlxModelPath <- doMlxtranPrep("WarfSAEM2comp_run2.mlxtran")


### Run all the generated mlxtran files
### 

mlxFileList <- doRunMlx(mlxModelPath)


###########################################################

# A function for all of it

modelList = c("C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/Original15CV.mlxtran",
              "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/Offset15CV.mlxtran")

repeatSSEinMonolix <- function(dataPath, modelList){
  
  userWD <- getwd()
  
  # Create a folder for the mlxtran files
  mlxDirName <- paste("MLX_SSE", format(Sys.time(), "%y%m%d_%H%M%S"), sep="_")
  dir.create(mlxDirName)
  setwd(mlxDirName)
  
  dataSetList <- doDataPrep(dataPath)
  
  lapply(i <- 1:length(modelList), doMlxtranPrep(modelList[[i]], dataSetList), modelList[[i]])
  
  
  
}