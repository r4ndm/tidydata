
#Introduction
The tidydata project contains an R script and related documentation to demonstrate collection and cleanup of a data set. 
The data used in this project is from experiments for wearable computing. Details of the dataset are listed in the "Input data section below.
This project is part of the "Getting and Cleaning Data" course project.

This repository contains the following files:
* README.md - this file
* CodeBook.md - description of the variables in the processed data
* run_analysis.R - script to process the data
* tidydata.txt - processed (tidy) data output from the script


#Prerequisites
The script requires dplyr package to be installed. If can be installed using

```r
install.packages("dplyr")
```

#Installation
Fetch the contents of this repository. This includes the run_analysis.R script. In addition to the contents of this repository, the raw data is
also needed. This is described in the next section.

#Input data
Raw data for this project is at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The contents of the zip file should be extracted into the same directory where the project files were installed in the previous step.

#Running
Start R and set the working directory to where the project files are installed. Then run the commands below
to acquire the raw data, run the analysis and write the output data.
Exact commands may differ based on platform.

```r
# Set working directory
dir <- "path to working directory"
setwd(dir)
url <- "url from the input data section"
download.file(url, destfile="rawdata.zip", mode="wb")

# unzip raw data files. This will create a subfolder named "UCI HAR Dataset" in the working directory

source("run_analysis.R")
tidyData <- runAnalysis()

# write output to file
write.table(tidyData, file="tidydata.txt", row.names=FALSE)
```

#Output
The output of the runAnalysis() function is a data frame that is the tidy data. The data frame contains data grouped by 
the test subject and activity. The other columns are the average (mean) of variables identified in the code book.

#Session information

```r
sessionInfo()
```

```
R version 3.1.2 (2014-10-31)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] dplyr_0.4.1

loaded via a namespace (and not attached):
[1] assertthat_0.1  DBI_0.3.1       lazyeval_0.1.10 magrittr_1.5    parallel_3.1.2  Rcpp_0.11.4     tools_3.1.2    
```