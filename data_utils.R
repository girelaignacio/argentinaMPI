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

# Order data
data$ISO <- factor(data$ISO, levels = data$ISO[order(data$MPI)])
data$Ranking <- seq(1:length(data$ISO))
data$Country <- as.factor(data$Country)
data$`World Region` <- as.factor(data$`World Region`)
data$ARG <- ifelse(data$ISO == "ARG", "yes", "no")

# Algo

