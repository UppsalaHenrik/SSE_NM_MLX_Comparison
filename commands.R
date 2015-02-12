
setwd('C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix')



dataPath <- "C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\SSE34_datasets"

mlxModelList = c("C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/Original15CV.mlxtran",
                 "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/Offset15CV.mlxtran",
                 "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/Original1CV.mlxtran",
                 "C:/Users/hnyberg/Dropbox/Doktorandsaker/WarfarinSAEM/Monolix/Offset1CV.mlxtran")

names(mlxModelList) <- c("A. SAEM 15%CV", "B. SAEM 15%CV 100% Misspec", 
                         "C. SAEM 1%CV", "D. SAEM 1%CV 100% Misspec")

repeatSSEinMonolix(dataPath,mlxModelList)










### Old


### Prep the data in the folder of choice. 
### Returns list of generated data files

mlxDataFileList <- doDataPrep(dataPath)


### Take a mlxtran file and create one for each data set
### Returns the subfolder name that contains the generated mlxtran files

mlxModelPath <- doMlxtranPrep("WarfSAEM2comp_run2.mlxtran")


### Run all the generated mlxtran files
### 

mlxFileList <- doRunMlx(mlxModelPath)
