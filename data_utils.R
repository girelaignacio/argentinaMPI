read_all_sheets = function(xlsxFile) {
  sheet_names = openxlsx::getSheetNames(xlsxFile)
  sheet_list = as.list(rep(NA, length(sheet_names)))
  names(sheet_list) = sheet_names
  for (sn in sheet_names) {
    sheet_list[[sn]] = openxlsx::read.xlsx(xlsxFile, sheet=sn, colNames = F,rows = c(9:111))
  }
  return(sheet_list)
}

data_list <- read_all_sheets("~/Descargas/Table-1-National-Results-MPI-2022.xlsx")[1:5]

MPI_colnames <- function(xlsx_list){
  colnames(xlsx_list[[1]]) <- c("ISO_number","ISO","Country","World Region","Survey","Year","MPI",
                                "H","A","Vurnerability","Severe","Inequality","D","","Total population",
                                "Total Population t-1","Total Population t",
                                "Total of Poor","Total of Poor t-1","Total of Poor t",
                                "Number of Indicators","Indicators missings")
  colnames(xlsx_list[[2]]) <- c("ISO_number","ISO","Country","World Region","Survey","Year","MPI",
                                "Nutrition","Child Mortality",
                                "Years of Schooling","School Attendance",
                                "Cooking Fuel","Sanitation","Drinking Water",
                                "Electricity","Housing","Assets",
                                "Number of Indicators","Indicators missings")
  colnames(xlsx_list[[3]]) <- c("ISO_number","ISO","Country","World Region","Survey","Year","MPI",
                                "% Health","% Education","% Living Standards",
                                "% Nutrition","% Child Mortality",
                                "% Years of Schooling","% School Attendance",
                                "% Cooking Fuel","% Sanitation","% Drinking Water",
                                "% Electricity","% Housing","% Assets",
                                "Number of Indicators","Indicators missings")
  
  colnames(xlsx_list[[4]]) <- c("ISO_number","ISO","Country","World Region","Survey","Year",
                                "MPI","H","A",
                                "1.90 USD", "Year 1.90 USD", "3.10 USD", "Year 3.10 USD",
                                "National Poverty Line", "Year National Poverty Line",
                                "GNI per cápita","Gini","Year Gini","HDI","Category HDI", "Income Category")
  
  colnames(xlsx_list[[5]]) <- c("ISO_number","ISO","Country","World Region","Survey","Year",
                                "MPI","MPI_se","MPI_lb","MPI_ub",
                                "H","H_se","H_lb","H_ub",
                                "A","Number of Indicators","Indicators missings")
  return(xlsx_list)
}

data_list <- MPI_colnames(data_list)

data <- Reduce(function(x, y) merge(x, y, all=T), data_list)


national_total <- openxlsx::read.xlsx("https://ophi.org.uk/wp-content/uploads/Table-1-National-Results-MPI-2022.xlsx",
                                sheet = "1.1 National MPI Results", startRow = 9, colNames = FALSE)[1:111,2:9]
colnames(national_total) <- c("ISO","country", "world_region", "survey", "year","MPI","H","A")

national_censH <- openxlsx::read.xlsx("https://ophi.org.uk/wp-content/uploads/Table-1-National-Results-MPI-2022.xlsx",
                                      sheet = "1.2 Censored Headcounts", startRow = 9, colNames = FALSE)[,c(2:6,8:17)]
colnames(national_censH) <- c("ISO","country", "world_region", "survey", "year",
                              "nutrition","child mortality",
                              "years of schooling", "school attendance", 
                              "cooking fuel", "sanitation", "drinking water","electricity","housing","assets")

national_contr <- openxlsx::read.xlsx("https://ophi.org.uk/wp-content/uploads/Table-1-National-Results-MPI-2022.xlsx",
                                      sheet = "1.3 Contribut'n of Deprivations", startRow = 9, colNames = FALSE)[,c(2:6,11:20)]
colnames(national_contr) <- c("ISO","country", "world_region", "survey", "year",
                              "ctr_nutrition","ctr_child mortality",
                              "ctr_years of schooling", "ctr_school attendance", 
                              "ctr_cooking fuel", "ctr_sanitation", "ctr_drinking water","ctr_electricity","ctr_housing","ctr_assets")
national_other <- openxlsx::read.xlsx("https://ophi.org.uk/wp-content/uploads/Table-1-National-Results-MPI-2022.xlsx",
                                      sheet = "1.4 MPI Results & Compl. Data", startRow = 9, colNames = FALSE)[1:111,c(2:6,9,11,13,15:17,19)]
colnames(national_other) <- c("ISO","country", "world_region", "survey", "year",
                              "1.9USD","3.10USD","NationalPovertyLine","GNIpercapita",
                              "Gini","HDI","IncomeCategory")





df_list <- list(national_total, national_censH, national_contr, national_other)
data <- Reduce(function(x, y) merge(x, y, all=T), df_list)
data$ISO <- factor(data$ISO, levels = data$ISO[order(data$MPI)])
data$world_region <- as.factor(data$world_region)
data$ARG <- ifelse(data$ISO == "ARG", "yes", "no")
data <- data[complete.cases(data$ISO),]

