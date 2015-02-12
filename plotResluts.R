
### Not anywhere near done. Need to fix the subtraction of the initial!

plotResults <- function(rawResults, initEsts) {
  dir.create("Plots")
  
  rawResultsCorr <- rawResults

  
  for(i in 3:ncol(rawResults)){
    
    
    png(paste('./Plots/', "Param", i-1, "-", colnames(rawResults[i]), ".png", sep=""),
        height=600, width=1200)
    boxplot((rawResults[[i]]-trueValue)~Description, data=rawResults, outline=FALSE,
            col="lightgray", xlab="", main=paste(colnames(rawResults[i]) ,", Param ", i-1, " - n=100", sep=""), 
            cex.main=3, cex.axis=1.2)
    dev.off()
  }
}

