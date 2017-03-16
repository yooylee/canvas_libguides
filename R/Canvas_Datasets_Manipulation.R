#. 1. Load Data using xlsx
####. You can load your data using excel format using xlsx package

canvas <- read.xlsx("File_Name.csv", sheetName="Sheet_Name", header=TRUE)

#. 2. Remove unnecessary courses
####. Using Course Department Code like ANAT (Anatomy) LAW (LAW)

canvas <- filter(canvas, !grepl("-Department_Code-", CourseID),
                    !grepl("-Department_Code-", CourseID),
                    !grepl("-Department_Code-", CourseID),
                    !grepl("-Department_Code-", CourseID))

#. 3. Remove unnecessary fields like CANVAS_COURSE_ID and Tool Name
canvas <- subset(canvas, select=c(SIS_COURSE_ID, Visibility))

#. 4. Change header's names
colnames(canvas) <- c("CourseID", "Hidden")

#. 5. Add School
canvas <- within(canvas, {
  School = ifelse(grepl("-AFRO-", CourseID), "Liberal Arts",
                  ifelse(grepl("-AMST", CourseID), "Liberal Arts", "Last Course"))
})

#. 6. Add Department
canvas <- within(canvas, {
  Department = ifelse(grepl("-AFRO-", CourseID), "Afro-American Studies",
                  ifelse(grepl("-AMST", CourseID), "American Studies", "Last Course"))
})
