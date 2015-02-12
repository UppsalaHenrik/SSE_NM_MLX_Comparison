

readMlxRun <- function(mlxModelList){
  
  #Get all of the file names, give the full path to all files
  files <- list.files(recursive = TRUE, full.names = TRUE)
  
  #Just keep the estimates and population param files
  popParamFiles <- grep("pop_parameters.txt$", files, value = TRUE)
  estFiles <- grep("estimates.txt$", files, value = TRUE)
  
  # Get the Monolix run dirs
  mlxRunDirs <- dirname(estFiles)
  
  # Pick out the model names from the list
  mlxModelNames <- sub("\\.[[:alnum:]]+$", "", basename(as.character(mlxModelList)))
  
  ## Loop around all of the estimates files
  allRows <- lapply(mlxRunDirs, function(x){
    
    # Pick out the estimates and pop param files 
    estFile <- paste0(x, "/", "estimates.txt")
    popParamFile <- paste0(x, "/", "pop_parameters.txt")
    
    # read in the CPU time line of the pop_parameters.txt file
    CPULine <- readLines(popParamFile)[[grep("CPU", readLines(popParamFile))]]
    
    # Pick out the number of seconds from that line
    CPULine <- gsub("CPU time is ", "", CPULine)
    CPUTime <- as.numeric(gsub(" seconds.", "", CPULine))
    
    
    # On to the parameter estimates! 
    
    # read in the data
    data <- read.csv(estFile, sep = ";")
    
    # remove white space, pop and _ from the column that will become column names
    colNames <- gsub("\\s", "", as.vector(data$X))
    colNames <- gsub("_", "", colNames)
    colNames <- gsub("pop", "", colNames)
    
    # Add a column name for the folder
    colNames <- c("Model", "Description", "CPU_time", colNames)
    
    # Pick up the current model name and make that x instead
    model <- mlxModelNames[sapply(mlxModelNames, grepl, x)]
    
    # build the data that will be in the row, quote the name so that it retains the quotes in the eval
    rows <- c(quote(model),quote(names(mlxModelList[sapply(mlxModelNames, grepl, x)])), CPUTime, data$parameter)
    
    # build up the call to data frame with column names and one row of data
    callString <- paste("data.frame(", paste(colNames, rows, sep = " = ", collapse = ","), ")")
    
    # evaluate the call to data.frame
    eval(parse(text = callString))
  })
  
  # Bind together all of the rows from the list 
  allData <- do.call("rbind", allRows)
  
  # Write our the results to a raw results file
  write.csv(allData, file="mlx_raw_results.csv", row.names=FALSE)
  
  # Return the data frame
  return(allData)
}
