#. 1. Merge Datasets

combined_datasets <- merge(canvas, LibGuides, by=c("CourseID", "School", "Department"))

#. 2. Replace N/A with 0 in the LaunchCount

combined_datasets <- within(combined_datasets,
                   LaunchCount <- ifelse (is.na(LaunchCount),0, LaunchCount))
