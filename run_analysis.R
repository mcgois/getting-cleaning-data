library(reshape2)

download.file.and.unzip <- function(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                                    distDir = "data") {

  # creates data dir if necessary.
  if (!dir.exists(distDir)) {
    dir.create(distDir)
  }
  
  # zipFile.
  zipFile <- file.path(distDir, "data.zip")
  
  # if zip not present, download it.
  if (!file.exists(zipFile)) {
    download.file(url, zipFile, method = "curl")
  }
    
  # unzip data
  unzip(zipFile, exdir = distDir)
}

# read activity labels, ignoring first column
read.activities.labels <- function(filename = file.path("data", "UCI HAR Dataset", "activity_labels.txt")) {
  df <- read.table(filename, col.names = c("code", "name"), colClasses = c("integer", "character"))
  df
}

# read features
read.features <- function(filename = file.path("data", "UCI HAR Dataset", "features.txt")) {
  df <- read.table(filename, col.names = c("id", "features"), colClasses = c("NULL", "character"))
  df$features
}

read.data <- function(features, activities, dataType) {
  
  # check data type
  if (!dataType %in% c("train", "test")) {
    stop("Data type should be: train or test.")
  }
  
  # create filenames
  filenameMeasurements <- file.path("data", "UCI HAR Dataset", dataType, paste0("X_", dataType, ".txt"))
  filenameActivities <- file.path("data", "UCI HAR Dataset", dataType, paste0("y_", dataType, ".txt"))
  filenameSubjects <- file.path("data", "UCI HAR Dataset", dataType, paste0("subject_", dataType, ".txt"))
  
  # retrieve index of features of interest
  features.of.interest.indexes <- grep("mean|std", features)
  
  # retrive features names
  features.names <- gsub("-mean", "Mean", features)
  features.names <- gsub("-std", "Std", features.names)
  features.names <- gsub("[()-]", "", features.names)
  
  # retrieve measurements of interest
  measurements <- read.table(filenameMeasurements, colClasses = "numeric")
  colnames(measurements) <- features.names
  measurements <- measurements[features.of.interest.indexes]
  
  # retrieve activity measurements
  activities.measurements <- read.table(filenameActivities, col.names = c("activity"), colClasses = c("integer"))
  measurements$activity <- factor(activities.measurements$activity, activities$code, activities$name)
  
  # retrieve subject measurements
  subjects.measurements <- read.table(filenameSubjects, col.names = c("subject"), colClasses = c("integer"))
  measurements$subject <- subjects.measurements$subject
  
  measurements
  
}

create.all.data <- function() {
  
  # read features and activity
  features <- read.features()
  activityLabels <- read.activities.labels()
  
  # create train and test df
  train <- read.data(features, activityLabels, "train")
  test <- read.data(features, activityLabels, "test")
  
  all.data <- rbind(train, test)
  all.data
  
}

create.tidy <- function(all.data) {
  
  # melt by subject and activity
  all.data.melted <- melt(all.data, id = c("subject", "activity"))

  # creates tidy  
  tidy <- dcast(all.data.melted, subject + activity ~ variable, mean)
  
  # generates tidy data file
  write.table(tidy, "tidy.txt", quote = FALSE, row.names = FALSE)
  
  tidy
}

##### Script #########

download.file.and.unzip()
all.data <- create.all.data()
tidy <- create.tidy(all.data)