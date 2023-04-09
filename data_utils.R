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
df_list <- list(national_total, national_censH, national_contr)
data <- Reduce(function(x, y) merge(x, y, all=T), df_list)
data$ISO <- factor(data$ISO, levels = data$ISO[order(data$MPI)])
data$world_region <- as.factor(data$world_region)

ggplot(data, aes(x=ISO, y=MPI, fill=world_region)) + 
         geom_bar(stat = "identity") + theme_minimal()

ggplot(data[data$world_region == "Latin America and the Caribbean",], aes(x=ISO, y=MPI)) + 
  geom_bar(stat = "identity") + theme_minimal()

ggplot(data[data$world_region == "Latin America and the Caribbean",], aes(x=ISO, y=H)) + 
  geom_bar(stat = "identity") + theme_minimal()


ggplot(data[data$world_region == "Latin America and the Caribbean",], aes(x=ISO, y=A)) + 
  geom_bar(stat = "identity") + theme_minimal()


ggplot(data[(data$world_region == "Arab States") | (data$country == "Argentina"),], aes(x=ISO, y=MPI)) + 
  geom_bar(stat = "identity") + theme_minimal()

ggplot(data[(data$world_region == "East Asia and the Pacific") | (data$country == "Argentina"),], aes(x=ISO, y=MPI)) + 
  geom_bar(stat = "identity") + theme_minimal()

ggplot(data[(data$world_region == "Europe and Central Asia") | (data$country == "Argentina"),], aes(x=ISO, y=MPI)) + 
  geom_bar(stat = "identity") + theme_minimal()

indicators = reshape2::melt(national_contr[(national_contr$world_region == "Latin America and the Caribbean") | (national_contr$country == "Argentina"),c(2,6:15)],id.vars=c("country"))
ggplot(data=indicators, aes(x=country, y=value, fill=variable)) +
  geom_bar(stat="identity") +labs(fill="Indicators") + theme_classic()
  