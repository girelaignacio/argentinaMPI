library(ggplot2)

##### MPI global all of the world
ggplot(data, aes(x=ISO, y=MPI, fill=world_region)) + 
  geom_bar(position='dodge', stat = "identity") + theme_minimal() +
  theme(#legend.key.size = unit(1, 'cm'), #change legend key size
        #legend.key.height = unit(1, 'cm'), #change legend key height
        #legend.key.width = unit(1, 'cm'), #change legend key width
        legend.title = element_text(size=8), #change legend title font size
        legend.text = element_text(size=5),
        axis.text.x=element_text(angle=90,hjust=1)) + xlab("")

### MPI Latin America and Argentina ####
ggplot(data[data$world_region == "Latin America and the Caribbean",], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  scale_fill_manual( values = c( "yes"="tomato", "no"="gray" ) )

### MPI Arab States and Argentina ####
ggplot(data[(data$world_region == "Arab States") | (data$country == "Argentina"),], aes(x=ISO, y=MPI,fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  scale_fill_manual( values = c( "yes"="tomato", "no"="gray" ) )

### MPI East Asia and the Pacific and Argentina ####
ggplot(data[(data$world_region == "East Asia and the Pacific") | (data$country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  scale_fill_manual( values = c( "yes"="tomato", "no"="gray" ) )

### MPI Europe and Central Asia and Argentina ####
ggplot(data[(data$world_region == "Europe and Central Asia") | (data$country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  scale_fill_manual( values = c( "yes"="tomato", "no"="gray" ) )

### MPI South Asia and Argentina ####
ggplot(data[(data$world_region == "South Asia") | (data$country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  scale_fill_manual( values = c( "yes"="tomato", "no"="gray" ) )

### MPI Sub-Saharan Africa and Argentina ####
ggplot(data[(data$world_region == "Sub-Saharan Africa") | (data$country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  scale_fill_manual( values = c( "yes"="tomato", "no"="gray" ) )



ggplot(data[data$world_region == "Latin America and the Caribbean",], aes(x=ISO, y=H)) + 
  geom_bar(stat = "identity") + theme_minimal()


ggplot(data[data$world_region == "Latin America and the Caribbean",], aes(x=ISO, y=A)) + 
  geom_bar(stat = "identity") + theme_minimal()




ggplot(data[(data$world_region == "East Asia and the Pacific") | (data$country == "Argentina"),], aes(x=ISO, y=MPI)) + 
  geom_bar(stat = "identity") + theme_minimal()

ggplot(data[(data$world_region == "Europe and Central Asia") | (data$country == "Argentina"),], aes(x=ISO, y=MPI)) + 
  geom_bar(stat = "identity") + theme_minimal()

indicators = reshape2::melt(national_contr[(national_contr$world_region == "Latin America and the Caribbean") | (national_contr$country == "Argentina"),c(2,6:15)],id.vars=c("country"))
ggplot(data=indicators, aes(x=country, y=value, fill=variable)) +
  geom_bar(stat="identity") +labs(fill="Indicators") + theme_classic()


ggplot(data = dat, mapping = aes(x = CNT, y = science)) +
  geom_boxplot() +
  labs(x=NULL, y="Science Scores") +
  theme_bw()