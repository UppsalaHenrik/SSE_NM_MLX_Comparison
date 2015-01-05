
### Not anywhere near done

plotParams <- function(finalEsts) {
  dir.create("Plots")
  for(i in 2:ncol(data)){
    png(paste('./Plots/', "parameter", i-1, ".png", sep="")
        , height=600, width=600)
    boxplot(data[[i]]~Model, data=finalEsts, outline=FALSE,
            col="lightgray", xlab="", main=paste(, i-1, "- Warfarin, n=100", sep = " "), 
            cex.main=3, cex.axis=1.2)
    dev.off()
  }
}






boxplot(finalEsts[[3]]~finalEsts$Model, data=finalEsts)

