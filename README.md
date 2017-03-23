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

Total records: 2422 course records

#### R Script
[LTI_Datasets_Manipulation.R](R/LTI_Datasets_Manipulation.R)

### 2. Datasets from Canvas
---------------------------

Datasets from Canvas contain the following information:
* CANVAS_COURSE_ID
* SIS_COURSE_ID: same as CourseID in the datasets from LibGuides LTI Instance Details
* Tool Name: Library Research Guide
* Visibility: if public - not hidden from the menu while "admins" means hidden

| CANVAS_COURSE_ID | SIS_COURSE_ID           | Tool Name              | Visibility |
| ---------------- | ----------------------- | ---------------------- | ---------- |
| 1573104          | FA16-IN-AFRO-A140-23993 | Library Research Guide | public     |

These datasets contain information like which course hid the "Library Research Guide" tab as well as 0 usage. In order to merge these datasets to the first datasets, the datasets from Canvas should need to be massaged.

#### Installation
``` r
# Install xlsx package to load data in .xlsx format from Canvas administrator
install.packages("xlsx")
```

1. Remove unnecessary courses using `filter()` from `dplyr` like above
2. Remove unnecessary fields using `select()` from `dplyr` or `subset()` like CANVAS_COURSE_ID and Tool Name
3. Change the header name to match with datasets from LibGuides LTI Instance Details
4. Add school and department information using `grepl()` like above

After data manipulation, you will have like this:

| CourseID                | Visibility | School       | Department            |
| ----------------------- | ---------- | ------------ | --------------------- |
| FA16-IN-AFRO-A140-23993 | public     | Liberal Arts | Afro-American Studies |

Total records: 4150 course records

#### Why are the numbers different between LibGuides datasets and Canvas datasets?
The datasets from LibGuides provide information only when there is at least 1 click or usage. If the tab is hidden or nobody clicks, it is not provided.

#### R Script
[Canvas_Datasets_Manipulation.R](R/Canvas_Datasets_Manipulation.R)

### 3. Combine Two Datasets
---------------------------

Using `merge()`, the Canvas and LibGuides datasets will be merged horizontally into one dataset. Both datasets have 'CourseID', 'School', and 'Department' in common, so these are used as a key variable.

Total records: 4161 course records

#### Why not 4150 records?
Because there are 11 courses where they have both automatic and manual setup settings.

If you want to know more about merging datasets, please check out [this website](https://rstudio-pubs-static.s3.amazonaws.com/52230_5ae0d25125b544caab32f75f0360e775.html).

Then, zero will be added in the 'LaunchCount' for the records which exist in the Canvas dataset but not in the LibGuides as LibGuides provides datasets only when at least it is clicked.

#### R Script
[Combined_Datasets.R](R/Combined_Datasets.R)

### 4. Data Visualization
---------------------------
The package 'ggplot2' is applied to visualize datasets. This package is widely used and one of the most powerful data visualization tools in R. If you want to know more about it, please visit [this website](https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf).

#### Installation

``` r
# Install ggplot2 package to use filter() function
install.packages("ggplot2")
```
#### Q. How many times clicked? (Bar graph)
![Click Ranges](img/ClickRanges.png)

#### Q. Percentage of never clicked (Pie chart)
![Percentage of never clicked](img/PieChart_NeverClickedPercentage.png)

#### Q. Percentage of library resource tab hidden by instructors
![Percentage of library resource tab hidden](img/Pie_TabHiddenPercentage.png)

#### Q. Setup type (Automatic or Manual)
![setup type - automatic vs. manual](img/PieChart_SetUpTypes.png)

In order to better understand how students used the embedded guides in Canvas, courses whose usage was 0 was removed. In addition, there was no information provided on types of guides. The goal here was to identify what types of guides (generic research guide vs. subject guide vs. course guide) were mostly used.

#### Q. Percentage of guide types embedded
![Guide Type](img/GuideTypes.png)

#### Q. Average usage by guide types
![Average Usage](img/Bar_Overview_only_UL.png)

#### Q. Guide types among most used ones (condition: LaunchCount>100)
![Guide Type: Most Used Guides](img/Pie_GuideTypes_MostUsedGuides.png)

#### Q. Average usage by school
![Average usage by school](img/Bar_AverageUsage_School)

#### Q. Agerage usage by department
![Average usage by department](img/Bar_AverageUsage_Department)

#### R Script
