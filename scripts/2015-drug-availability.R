# Load and format data
data.all <- read.csv("./data/2015-neml-data.csv",
                     sep=",",
                     header=T)
str(data.all)

# Remove "advanced" economies data
data.dev <- subset(data.all, data.all$IMF=="Developing")
data.dev$IMF <- sapply(data.dev$IMF, factor, labels="Developing")
data.dev$Country <- sapply(data.dev$Country, factor)
str(data.dev)
data.dev[1:25,]

########################################
# Stats for drug class listings on NEMLs
########################################
library(plyr)
library(fifer)
drug.avail.1 <- ddply(data.dev, .(World.Bank), summarise,
            Amitriptyline = sum(Listed == "Yes" & Drug == "Amitriptyline"),
            Clomipramine = sum(Listed == "Yes" & Drug == "Clomipramine"),
            Imipramine = sum(Listed == "Yes" & Drug == "Imipramine"),
            Nortriptyline = sum(Listed == "Yes" & Drug == "Nortriptyline"),
            Desipramine = sum(Listed == "Yes" & Drug == "Desipramine"),
            Duloxetine = sum(Listed == "Yes" & Drug == "Duloxetine"),
            Venlafaxine = sum(Listed == "Yes" & Drug == "Venlafaxine"),
            Gabapentin = sum(Listed == "Yes" & Drug == "Gabapentin"),
            Pregabalin = sum(Listed == "Yes" & Drug == "Pregabalin"),
            Tramadol = sum(Listed == "Yes" & Drug == "Tramadol"),
            Lidocaine = sum(Listed == "Yes" & Drug == "Lidocaine"),
            Methadone = sum(Listed == "Yes" & Drug == "Methadone"),
            Morphine = sum(Listed == "Yes" & Drug == "Morphine"),
            Oxycodone = sum(Listed == "Yes" & Drug == "Oxycodone"),
            Carbemazepine = sum(Listed == "Yes" & Drug == "Carbamazepine"),
            Oxcarbazepine = sum(Listed == "Yes" & Drug == "Oxcarbazepine"),
            Valproate = sum(Listed == "Yes" & Drug == "Valproate"))
drug.avail.1
drug.avail.2 <- drug.avail.1

# Number of countries in each income category
Income <- xtabs(~ World.Bank + Drug, data = data.dev)
Income[,-c(2:21)]

# Rearrange rows using "match"
target<-c("Low", "Lower middle", "Upper middle", "High", "Undefined")
drug.avail.2<-drug.avail.2[match(target, drug.avail.2$World.Bank),]
drug.avail.2
write.csv(drug.avail.2,
          "./data/2015-drug-availability.csv", row.names = FALSE)

# Convert counts to percentages
str(drug.avail.2)
drug.avail.2
drug.avail.2[1,2:18] <- round(drug.avail.2[1,2:18]/24, 2)*100
drug.avail.2[2,2:18] <- round(drug.avail.2[2,2:18]/40, 2)*100
drug.avail.2[3,2:18] <- round(drug.avail.2[3,2:18]/37, 2)*100
drug.avail.2[4,2:18] <- round(drug.avail.2[4,2:18]/8, 2)*100
drug.avail.2[5,2:18] <- round(drug.avail.2[5,2:18]/3, 2)*100
drug.avail.2 # now as percentage
write.csv(drug.avail.2,
          "./data/2015-drug-availability-percent.csv", row.names = FALSE)
