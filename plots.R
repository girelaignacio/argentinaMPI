library(ggplot2)

arg_MPI <- data$MPI[data$Country == "Argentina"]

##### MPI global all of the world
ggplot(data, aes(x=ISO, y=MPI, fill=`World Region`)) + 
  geom_bar(position='dodge', stat = "identity") + theme_minimal() +
  theme(#legend.key.size = unit(1, 'cm'), #change legend key size
        #legend.key.height = unit(1, 'cm'), #change legend key height
        #legend.key.width = unit(1, 'cm'), #change legend key width
        legend.title = element_text(size=8), #change legend title font size
        legend.text = element_text(size=5),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 5)) + xlab("") +
  annotate("segment", x = 8, y = arg_MPI + 0.03, xend = 8, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))

ggplot(data = data, mapping = aes(x = `World Region`, y = MPI, fill=`World Region`)) +
  geom_boxplot() +
  labs(x=NULL, y="MPI") +
  theme(legend.position = "none")

  ### MPI Latin America and Argentina ####
ggplot(data[data$`World Region` == "Latin America and the Caribbean",], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  annotate("segment", x = 1, y = arg_MPI + 0.03, xend = 1, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))

### MPI Arab States and Argentina ####
ggplot(data[(data$`World Region` == "Arab States") | (data$Country == "Argentina"),], aes(x=ISO, y=MPI,fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  annotate("segment", x = 1, y = arg_MPI + 0.03, xend = 1, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))

### MPI East Asia and the Pacific and Argentina ####
ggplot(data[(data$`World Region` == "East Asia and the Pacific") | (data$Country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  annotate("segment", x = 1, y = arg_MPI + 0.03, xend = 1, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))

### MPI Europe and Central Asia and Argentina ####
ggplot(data[(data$`World Region` == "Europe and Central Asia") | (data$Country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  annotate("segment", x = 8, y = arg_MPI + 0.005, xend = 8, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))

### MPI South Asia and Argentina ####
ggplot(data[(data$`World Region` == "South Asia") | (data$Country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  annotate("segment", x = 1, y = arg_MPI + 0.03, xend = 1, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))

### MPI Sub-Saharan Africa and Argentina ####
ggplot(data[(data$`World Region` == "Sub-Saharan Africa") | (data$Country == "Argentina"),], aes(x=ISO, y=MPI, fill=ARG)) + 
  geom_bar(stat = "identity") + theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1),
        legend.position = "none") + xlab("") +
  annotate("segment", x = 1, y = arg_MPI + 0.03, xend = 1, yend = arg_MPI,
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))



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


ggplot(data = data, aes(x = MPI, y = `1.90 USD`)) + 
  geom_point(stat = "identity")

ggplot(data = data, aes(x = MPI, y = `3.10 USD`)) + 
  geom_point(stat = "identity")
