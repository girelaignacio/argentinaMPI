summary(data$MPI)
summary(data$H)
summary(data$A)
for (region in levels(data$world_region)){
  results <- summary(subset(data, world_region == region)$MPI)
  cat(region,"\n",names(results),"\n",results,"\n")
}


