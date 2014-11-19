#setwd("C:\\Users\\hnyberg\\Dropbox\\Doktorandsaker\\WarfarinSAEM\\Monolix\\WarfSAEM2comp_run2_141113_182028\\mlxestim1")



readMlxParams <- function(mlxModelPath){
  
  
}

?read.csv()
?list.dirs()
?as.data.frame()


as.vector(rawEstimates$X)



rawEstimates <- read.csv("estimates.txt", sep = ";")

v <- data.frame(rawEstimates$parameter, row.names(as.vector(rawEstimates$X)))


v <- c(v, rawEstimates$parameter)

colNames <- gsub("\\s", "", as.vector(rawEstimates$X))

colNames <- c("Folder", colNames)


callString <- paste("mydf <- data.frame(", paste(colNames, c("'blah'", rawEstimates$parameter), sep = " = ", collapse = ","), ")")

eval(parse(text = callString))


#Get all of the file names, give the full path to all files
files <- list.files(recursive = TRUE, full.names = TRUE)
#Just keep the estimates files
estFiles <- grep("estimates.txt$", files, value = TRUE)


## Loop around all of the estimates files
allRows <- lapply(estFiles, function(x){
  
  # read in the data
  data <- read.csv(x, sep = ";")
  
  # remove white space from the column that will become column names
  colNames <- gsub("\\s", "", as.vector(data$X))
  
  # Add a column name for the folder
  colNames <- c("Folder", colNames)
  
  # remove the ./ from the file path. This is dangerous. When it falls over look here first and blame Aimee:)
  x <- gsub("./", "", dirname(x))
  
  # build the data that will be in the row, quote the name so that it retains the quotes in the eval
  rows <- c(quote(x), data$parameter)
  
  # build up the call to data frame with column names and one row of data
  callString <- paste("data.frame(", paste(colNames, rows, sep = " = ", collapse = ","), ")")
  
  #evaluate the call to data.frame
  eval(parse(text = callString))
})

# Bind together all of the rows from the list 
allData <- do.call("rbind", allRows)


