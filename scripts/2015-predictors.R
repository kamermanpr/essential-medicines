# Load and format data
data.all <- read.csv("./data/2015-neml-data.csv", sep=",", header = T)
str(data.all)

# Remove "advanced" economies data
data.dev <- subset(data.all, data.all$IMF == "Developing")
data.dev$IMF <- sapply(data.dev$IMF, factor, labels = "Developing")
data.dev$Country <- sapply(data.dev$Country, factor)
str(data.dev)
data.dev[1:21,]

########################################
# Stats for drug class listings on NEMLs
########################################
library(plyr)
library(fifer)
drug.line.1 <- ddply(data.dev, .(Country, Type, World.Bank, Region),
                     summarize,
                   TCA.yes = sum(Listed == "Yes" & Class == "TCA"),
                   SNRI.yes = sum(Listed == "Yes" & Class == "SNRI"),
                   a2delta.yes = sum(Listed == "Yes" & Class == "Anticonvulsant" & (Drug == "Pregabalin" | Drug == "Gabapentin")),
                   Tramadol.yes = sum(Listed == "Yes" & Drug == "Tramadol"),
                   Lido.yes = sum(Listed == "Yes" & Drug == "Lidocaine"),
                   Strong.opioid.yes = sum(Listed == "Yes" & (Drug == "Morphine" | Drug == "Methadone" | Drug == "Oxycodone")),
                   Other.yes = sum(Listed == "Yes" & (Drug == "Carbamazepine" | Drug == "Oxcarbazepine" | Drug == "Valproate")))
drug.line.1
drug.line.2 <- drug.line.1
drug.line.2[,5:11][drug.line.2[,5:11]>0] <- "1"
drug.line.2

# Convert to numeric
drug.line.2[,5:11]<-sapply(drug.line.2[,5:11], as.numeric)
str(drug.line.2)
drug.line.3 <- ddply(drug.line.2, .(Country, Type, World.Bank, Region), summarize,
                   First.line = sum(TCA.yes, SNRI.yes, a2delta.yes),
                   Second.line = sum(Tramadol.yes, Lido.yes),
                   First.Second = sum(TCA.yes, SNRI.yes, a2delta.yes,
                                      Tramadol.yes, Lido.yes),
                   Third.line = sum(Strong.opioid.yes),
                   Other.anticonvulsants = sum(Other.yes))
drug.line.3
drug.line.num <- drug.line.3

# Convert back to factors
drug.line.3[,5:6]<-lapply(drug.line.3[,5:6], factor)
str(drug.line.3)

# Remove "Undefined" World.Bank category
drug.line.3 <- drug.line.3[!drug.line.3$World.Bank == "Undefined", ]
str(drug.line.3)
drug.line.3$World.Bank <- sapply(drug.line.3$World.Bank, factor)
str(drug.line.3)
drug.line.4 <- drug.line.3

# Ordered factors - for use if required
drug.line.4$World.Bank <- factor(drug.line.4$World.Bank,
                                 levels = c("Low", "Lower middle",
                                            "Upper middle", "High"),
                                 ordered = T)
str(drug.line.4)
drug.line.4$First.line <- factor(drug.line.4$First.line, ordered = T)
str(drug.line.4)
drug.line.4$Second.line <- factor(drug.line.4$Second.line, ordered = T)
str(drug.line.4)

# First line vs region (tab.1)
tab.1 <- with(drug.line.4, xtabs(~ First.line + Region))
tab.1
tab.1.prop <- round(prop.table(tab.1,2),3) * 100
tab.1.prop
tab.1a <- fisher.test(tab.1, simulate.p.value = T, B = 10000)
tab.1a
tab.1b <- subset(chisq.post.hoc(tab.1, popsInRows = F, control = "holm"),
                 adj.p<0.05)
tab.1b

# First line vs income (tab.2)
tab.2 <- with(drug.line.3, xtabs(~ First.line + World.Bank))
tab.2
tab.2.prop <- round(prop.table(tab.2,2),4) * 100
tab.2.prop
tab.2a <- fisher.test(tab.2, simulate.p.value = T, B = 10000)
tab.2a
tab.2b <- subset(chisq.post.hoc(tab.2, popsInRows = F, control = "holm"),
                 adj.p<0.05)
tab.2b

# CMH test: First line vs region, controlling for income
library(coin)
coin.3 <- with(drug.line.4, xtabs(~ First.line + Region + World.Bank))
coin.3
ftable(coin.3)
coin.3b <- as.data.frame.table(coin.3)
coin.3b
coin.3.p <- round(prop.table(coin.3, 2) * 100,0)
ftable(coin.3.p)
coin.4 <- with(drug.line.4, xtabs(~ First.line + World.Bank + Region))
coin.4
ftable(coin.4)
coin.4.p <- round(prop.table(coin.4, 2) * 100,0)
ftable(coin.4.p)
coin.paste <- paste0(paste(coin.3,coin.3.p, sep=" ("),")")
coin.paste
coin.array <- array(coin.paste, dim = c(4, 5, 4),
                  dimnames = list(c("0", "1", "2", "3"),
                                c("Africa", "Americas", "Asia", "Europe",
                                  "Oceania"),
                                c("Low", "Lower middel", "Upper middle",
                                  "High")))
ftable(coin.array)
write.csv(ftable(coin.array), "first.line.array.csv", row.names = T)
cmh_test(coin.3)
lbl_test(coin.4)
tab.3.glm <- as.data.frame.table(coin.3)
tab.3.glm #GLM to test for three-way interaction between terms
glm.1 <- with(tab.3.glm, glm(Freq ~ First.line  *  Region  *  World.Bank,
                             poisson))
glm.2 <- update(glm.1, ~. -First.line:Region:World.Bank)
anova(glm.1, glm.2, test = "Chi") # no three-way interaction, therefore leave term out
glm.3 <- update(glm.2, ~. -Region:World.Bank)
anova(glm.3,glm.2, test = "Chi") # MAJOR PROBLEM: INTERACTION BETWEEN INCOME AND REGION
summary(glm.2)

# Second line vs region (tab.2nd.1)
tab.2nd.1 <- with(drug.line.4, xtabs(~ Second.line + Region))
tab.2nd.1
tab.2nd.1.prop <- round(prop.table(tab.2nd.1,2),3) * 100
tab.2nd.1.prop
tab.2nd.1a <- fisher.test(tab.2nd.1, simulate.p.value = T, B = 10000)
tab.2nd.1a
tab.2nd.1b <- subset(chisq.post.hoc(tab.2nd.1, popsInRows = F,
                                    control = "holm"), adj.p<0.05)
tab.2nd.1b

# Second line vs income (tab.2nd.2)
tab.2nd.2 <- with(drug.line.3, xtabs(~ Second.line + World.Bank))
tab.2nd.2
tab.2nd.2.prop <- round(prop.table(tab.2nd.2,2),4) * 100
tab.2nd.2.prop
tab.2nd.2a <- fisher.test(tab.2nd.2, simulate.p.value = T, B = 10000)
tab.2nd.2a
tab.2nd.2b <- subset(chisq.post.hoc(tab.2nd.2, popsInRows = F,
                                    control = "holm"), adj.p<0.05)
tab.2nd.2b

# Third line vs income (tab.3rd.3)
tab.3rd.3 <- with(drug.line.3, xtabs(~ Third.line + World.Bank))
tab.3rd.3
tab.3rd.3.prop <- round(prop.table(tab.3rd.3,2),4) * 100
tab.3rd.3.prop
tab.3rd.3a <- fisher.test(tab.3rd.3, simulate.p.value = T, B = 10000)
tab.3rd.3a

# Other anticonvulsants (tab.anti.4)
tab.anti.4 <- with(drug.line.3, xtabs(~ Other.anticonvulsants + World.Bank))
tab.anti.4
tab.anti.4.prop <- round(prop.table(tab.anti.4,2),4) * 100
tab.anti.4.prop
tab.anti.4a <- fisher.test(tab.anti.4, simulate.p.value = T, B = 10000)
tab.anti.4a
