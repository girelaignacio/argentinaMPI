read_all_sheets = function(xlsxFile) {
  sheet_names = openxlsx::getSheetNames(xlsxFile)
  sheet_list = as.list(rep(NA, length(sheet_names)))
  names(sheet_list) = sheet_names
  for (sn in sheet_names) {
    sheet_list[[sn]] = openxlsx::read.xlsx(xlsxFile, sheet=sn, startRow = 9, colNames = F)
  }
  return(sheet_list)
}

data_list <- read_all_sheets("~/Descargas/Table-1-National-Results-MPI-2022.xlsx")


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

