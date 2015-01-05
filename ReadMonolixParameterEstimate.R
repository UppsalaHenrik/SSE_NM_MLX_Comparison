#setwd("C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\MLX_SSE_141205_141826")
#x <- estFiles[[2]]


readMlxParams <- function(mlxModelList){

  #Get all of the file names, give the full path to all files
  files <- list.files(recursive = TRUE, full.names = TRUE)
  #Just keep the estimates files
  estFiles <- grep("estimates.txt$", files, value = TRUE)
  
  # Pick out the model names from the list
  mlxModelNames <- sub("\\.[[:alnum:]]+$", "", basename(as.character(mlxModelList)))

  ## Loop around all of the estimates files
  allRows <- lapply(estFiles, function(x){
  
    # read in the data
    data <- read.csv(x, sep = ";")
  
    # remove white space from the column that will become column names
    colNames <- gsub("\\s", "", as.vector(data$X))
    
    # Add a column name for the folder
    colNames <- c("Model", colNames)
  
    # Pick up the 
    x <- mlxModelNames[sapply(mlxModelNames, grepl, x)]
    
    # build the data that will be in the row, quote the name so that it retains the quotes in the eval
    rows <- c(quote(x), data$parameter)
  
    # build up the call to data frame with column names and one row of data
    callString <- paste("data.frame(", paste(colNames, rows, sep = " = ", collapse = ","), ")")
  
    # evaluate the call to data.frame
    eval(parse(text = callString))
  })

# Bind together all of the rows from the list 
allData <- do.call("rbind", allRows)

# Return that data frame
return(allData)
}

