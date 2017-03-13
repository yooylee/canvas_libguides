# canvas_libguides

In order to better understand usage of embedded library guides in Canvas for the 2016 fall semester, R is applied for data manipulation (like removed unnecessary courses using Department Code), data merge, and visualization.

### 1. Datasets from LibGuides LTI Instance Details
------------------------------------------------------

Datasets from LibGuides LTI Instance Details contain the following information:
* ID
* Type
* CourseID
* CourseName
* Guide
* Created
* LastLaunch
* LaunchCount

| ID    | Type | CourseID                | CourseName                                   | Guide                                  | Created | LastLaunch | LaunchCount |
| ----- | ---- | ----------------------- | -------------------------------------------- | -------------------------------------- | ------- | ---------- | ----------- |
| 35987 | Auto | FA16-IN-AFRO-A140-23993 | FA16: INTR: AFR AMER&AFRI DIASP STUDY: 23993 | Guide: Africana Studies Research Guide | 8/31/16 | 12/5/16    | 6           |

In order to see what types of guides were mostly used, the guide types (Subject, Course, Generic, and LTI Default) should be added along with department and school information. In addition, courses like medicine, law, and dentistry which were covered by their libraries should be removed.

#### Installation

``` r
# Install dplyr package to use filter() function
install.packages("dplyr")
```

You can find more about dplyr at [https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html] (https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)

1. Remove unnecessary courses using `filter()` and [Department Code](http://registrar.iupui.edu/schedule.html)
2. Add guide types (Subject, Course, Generic, and LTI Default) using `grepl()`
3. Add school and department information using `grepl()` [Department Code](http://registrar.iupui.edu/schedule.html)

After data manipulation, you will have the following fields:
* guide_type
* School
* Department

| ID    | Type | CourseID                | CourseName                                   | Guide                                  | Created | LastLaunch | LaunchCount | guide_type | School       | Department            |
| ----- | ---- | ----------------------- | -------------------------------------------- | -------------------------------------- | ------- | ---------- | ----------- | ---------- | -----------  | --------------------- |
| 35987 | Auto | FA16-IN-AFRO-A140-23993 | FA16: INTR: AFR AMER&AFRI DIASP STUDY: 23993 | Guide: Africana Studies Research Guide | 8/31/16 | 12/5/16    | 6           | Subject    | Liberal Arts | Afro-American Studies |

#### R Script
[LTI_Datasets_Manipulation.R](../canvas_libguides/tree/master/R/LTI_Datasets_Manipulation.R)

### 2. Datasets from Canvas
---------------------------

### 3. Combine Two Datasets
---------------------------

### 4. Data Visualization
---------------------------
