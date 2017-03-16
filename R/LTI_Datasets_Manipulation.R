#. 1. Load Data using csv
####. You can load your data using excel format using xlsx package

LibGuides <- read.csv("File_Name.csv", header=TRUE)

#. 2. Remove unnecessary courses
####. Using Course Department Code like ANAT (Anatomy) LAW (LAW)

LibGuides <- filter(canvas, !grepl("-Department_Code-", CourseID),
                    !grepl("-Department_Code-", CourseID),
                    !grepl("-Department_Code-", CourseID),
                    !grepl("-Department_Code-", CourseID))

#. 3. Add guide types (Subject, Course, Generic, and LTI Default)
####. Naming at IUPUI
####. Generic Research Guide: Introduction to Library Research is automatically embedded if there is no specific course or subject guide matched.
####. Course Guide: It starts with Department Code and Number like BUS X103 except I-Core Research and Bloomberg guides.
######. Therefore, [[:digit:]] in the regular expression identifies any guides containing number in the guide name.

LibGuides <- within(LibGuides, {
  guide_type = ifelse(grepl("Introduction to Library Research", Guide), "Generic Research Guide",
                      ifelse(grepl("[[:digit:]]", Guide), "Course Guide",
                             ifelse(grepl("Guide: I-Core Research Guide", Guide), "Course Guide",
                                    ifelse(grepl("Guide: Bloomberg Guide", Guide), "Course Guide",
                                           ifelse(grepl("Library LTI Page", Guide), "LTI Default", "Subject Guide")
                                    ))))
})

#. 4. Add School

LibGuides <- within(LibGuides, {
  School = ifelse(grepl("-AFRO-", CourseID), "Liberal Arts",
                  ifelse(grepl("-AMST", CourseID), "Liberal Arts", "Last Course"))
})

#. 5. Add Department

LibGuides <- within(LibGuides, {
  Department = ifelse(grepl("-AFRO-", CourseID), "Afro-American Studies",
                  ifelse(grepl("-AMST", CourseID), "American Studies", "Last Course"))
})
