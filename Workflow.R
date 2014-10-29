
setwd('C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix')


### Prep the data in the folder of choice. 
### Returns list of generated data files

mlxDataFileList <- doDataPrep("C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\SSE30_datasets")


### Take a mlxtran file and create one for each data set
### Returns the subfolder name that contains the generated mlxtran files

mlxModelPath<- doMlxtranPrep("WarfSAEM2comp_run2.mlxtran", 
                            "C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\SSE30_datasets",
                            mlxDataFileList)


### Run all the generated mlxtran files
### 

mlxResults <- doRunMlx(mlxModelPath)