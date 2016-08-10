# Load and format data
data.all <- read.csv("./data/eml-data.csv", sep = ",", header = T)
str(data.all)

# Remove "advanced" economies data
data.dev <- subset(data.all, data.all$IMF == "Developing")
data.dev$IMF <- sapply(data.dev$IMF, factor, labels = "Developing")
levels(data.dev$IMF)

# Remove "undefined" World.Bank data
levels(data.dev$World.Bank)
data.dev <- subset(data.dev, !data.dev$World.Bank == "Undefined")
data.dev$World.Bank <- sapply(data.dev$World.Bank, factor)
levels(data.dev$World.Bank)

# Order World.Bank catagories
data.dev$World.Bank <- factor(data.dev$World.Bank,
                            levels = c("Low", "Lower middle", "Upper middle",
                                       "High"),
                            ordered = T)
str(data.dev$World.Bank)

########################
# Basic stats for income
########################
library(fifer)
library(vcd)
library(vcdExtra)

#####
# TCA
# Amitriptyline
ami.1 <- subset(data.dev, data.dev$Drug == "Amitriptyline")
ami.1$Drug <- sapply(ami.1$Drug, factor)
# Fisher's test - income as a predictor (.4a)
ami.4 <- xtabs(~ ami.1$Listed + ami.1$World.Bank)
ami.4
ami.4a <- fisher.test(ami.4, conf.int = T,
                      simulate.p.value = T, B = 10000)
ami.4a
ami <- CMHtest(ami.4, type = 'cmeans')
ami

# Nortriptyline
nort.1 <- subset(data.dev, data.dev$Drug  == "Nortriptyline")
nort.1$Drug <- sapply(nort.1$Drug, factor)
nort.4 <- xtabs(~ nort.1$Listed + nort.1$World.Bank)
nort.4
nort.4a <- fisher.test(nort.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
nort.4a
nort <- CMHtest(nort.4, type = 'cmeans')
nort

# Imipramine
imip.1 <- subset(data.dev, data.dev$Drug  == "Imipramine")
imip.1$Drug <- sapply(imip.1$Drug, factor)
imip.4 <- xtabs(~imip.1$Listed + imip.1$World.Bank)
imip.4
imip.4a <- fisher.test(imip.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
imip.4a
imip <- CMHtest(imip.4, type = 'cmeans')
imip

# Desipramine
desip.1 <- subset(data.dev, data.dev$Drug == "Desipramine")
desip.1$Drug <- sapply(desip.1$Drug, factor)
desip.4 <- xtabs(~desip.1$Listed + desip.1$World.Bank)
desip.4
desip.4a <- fisher.test(desip.4, conf.int = T,
                        simulate.p.value = T, B = 10000)
desip.4a
des <- CMHtest(desip.4, type = 'cmeans')
des

# Clomipramine
clomip.1 <- subset(data.dev, data.dev$Drug == "Clomipramine")
clomip.1$Drug <- sapply(clomip.1$Drug, factor)
clomip.4 <- xtabs(~clomip.1$Listed + clomip.1$World.Bank)
clomip.4
clomip.4a <- fisher.test(clomip.4, conf.int = T,
                         simulate.p.value = T, B = 10000)
clomip.4a
clom <- CMHtest(clomip.4, type = 'cmeans')
clom

###########
# SNRI/NDRI
# Venlafaxine
venla.1 <- subset(data.dev, data.dev$Drug == "Venlafaxine")
venla.1$Drug <- sapply(venla.1$Drug, factor)
venla.4 <- xtabs(~venla.1$Listed + venla.1$World.Bank)
venla.4
venla.4a <- fisher.test(venla.4, conf.int = T,
                        simulate.p.value = T, B = 10000)
venla.4a
ven <- CMHtest(venla.4, type = 'cmeans')
ven

# Duloxetine
dulox.1 <- subset(data.dev, data.dev$Drug == "Duloxetine")
dulox.1$Drug <- sapply(dulox.1$Drug, factor)
dulox.4 <- xtabs(~dulox.1$Listed + dulox.1$World.Bank)
dulox.4
dulox.4a <- fisher.test(dulox.4, conf.int = T,
                        simulate.p.value = T, B = 10000)
dulox.4a
dul <- CMHtest(dulox.4, type = 'cmeans')
dul

#################
# Anticonvulsants
# Gabapentin
gaba.1 <- subset(data.dev, data.dev$Drug == "Gabapentin")
gaba.1$Drug <- sapply(gaba.1$Drug, factor)
gaba.4 <- xtabs(~gaba.1$Listed + gaba.1$World.Bank)
gaba.4
gaba.4a <- fisher.test(gaba.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
gaba.4a
gaba <- CMHtest(gaba.4, type = 'cmeans')
gaba

# Pregabalin
preg.1 <- subset(data.dev, data.dev$Drug == "Pregabalin")
preg.1$Drug <- sapply(preg.1$Drug, factor)
preg.4 <- xtabs(~preg.1$Listed + preg.1$World.Bank)
preg.4
preg.4a <- fisher.test(preg.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
preg.4a
preg <- CMHtest(preg.4, type = 'cmeans')
preg

# Carbamazepine
carba.1 <- subset(data.dev, data.dev$Drug == "Carbamazepine")
carba.1$Drug <- sapply(carba.1$Drug, factor)
carba.4 <- xtabs(~carba.1$Listed + carba.1$World.Bank)
carba.4
carba.4a <- fisher.test(carba.4, conf.int = T,
                        simulate.p.value = T, B = 10000)
carba.4a
carb <- CMHtest(carba.4, type = 'cmeans')
carb

# Oxcarbazepine
oxcarb.1 <- subset(data.dev, data.dev$Drug == "Oxcarbazepine")
oxcarb.1$Drug <- sapply(oxcarb.1$Drug, factor)
oxcarb.4 <- xtabs(~oxcarb.1$Listed + oxcarb.1$World.Bank)
oxcarb.4
oxcarb.4a <- fisher.test(oxcarb.4, conf.int = T,
                         simulate.p.value = T, B = 10000)
oxcarb.4a
ox <- CMHtest(oxcarb.4, type = 'cmeans')
ox

# Valproate
valp.1 <- subset(data.dev, data.dev$Drug == "Valproate")
valp.1$Drug <- sapply(valp.1$Drug, factor)
valp.4 <- xtabs(~valp.1$Listed + valp.1$World.Bank)
valp.4
valp.4a <- fisher.test(valp.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
valp.4a
valp <- CMHtest(valp.4, type = 'cmeans')
valp

#########
# Opioids
# Morphine
morph.1 <- subset(data.dev, data.dev$Drug == "Morphine")
morph.1$Drug <- sapply(morph.1$Drug, factor)
morph.4 <- xtabs(~morph.1$Listed + morph.1$World.Bank)
morph.4
morph.4a <- fisher.test(morph.4, conf.int = T,
                        simulate.p.value = T, B = 10000)
morph.4a
morph <- CMHtest(morph.4, type = 'cmeans')
morph

# Oxycodone
oxycod.1 <- subset(data.dev, data.dev$Drug == "Oxycodone")
oxycod.1$Drug <- sapply(oxycod.1$Drug, factor)
oxycod.4 <- xtabs(~oxycod.1$Listed + oxycod.1$World.Bank)
oxycod.4
oxycod.4a <- fisher.test(oxycod.4, conf.int = T,
                         simulate.p.value = T, B = 10000)
oxycod.4a
oxycod <- CMHtest(oxycod.4, type = 'cmeans')
oxycod

# Methadone
meth.1 <- subset(data.dev, data.dev$Drug == "Methadone")
meth.1$Drug <- sapply(meth.1$Drug, factor)
meth.4 <- xtabs(~meth.1$Listed + meth.1$World.Bank)
meth.4
meth.4a <- fisher.test(meth.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
meth.4a
meth <- CMHtest(meth.4, type = 'cmeans')
meth

# Tramadol
tram.1 <- subset(data.dev, data.dev$Drug == "Tramadol")
tram.1$Drug <- sapply(tram.1$Drug, factor)
tram.4 <- xtabs(~tram.1$Listed + tram.1$World.Bank)
tram.4
tram.4a <- fisher.test(tram.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
tram.4a
tram <- CMHtest(tram.4, type = 'cmeans')
tram

##########
# Topicals
# Capsaicin = NA
# Lidocaine
lido.1 <- subset(data.dev, data.dev$Drug ==  "Lidocaine")
lido.1$Drug <- sapply(lido.1$Drug, factor)
lido.4 <- xtabs(~lido.1$Listed + lido.1$World.Bank)
lido.4
lido.4a <- fisher.test(lido.4, conf.int = T,
                       simulate.p.value = T, B = 10000)
lido.4a
lido <- CMHtest(lido.4, type = 'cmeans')
lido

###################################################################
# Correction for multiple comparisons - region as a predictor (.2a)
###################################################################
nam.2 <- c("Amitriptyline", "Nortriptyline", "Imipramine", "Desipramine",
         "Clomipramine","Venlafaxine", "Duloxetine", "Gabapentin",
         "Pregabalin", "Carbamazepine", "Oxcarbazepine", "Morphine",
         "Oxycodone", "Methadone", "Tramadol", "Lidocaine") # no capsaicin or levorphanol because they were not included on any NEMLs
income.p <- c(ami$table[,3], nort$table[,3], imip$table[,3], des$table[,3],
            clom$table[,3],ven$table[,3], dul$table[,3], gaba$table[,3],
            preg$table[,3], carb$table[,3], ox$table[,3], morph$table[,3],
            oxycod$table[,3], meth$table[,3], tram$table[,3], lido$table[,3])
income.p

# Calculate adjusted p-values
income.p.2 <- p.adjust(income.p, method = "holm")
income.p.2

# Make data.frame of adjusted p-values with drug names
income.p.3 <- data.frame(cbind(nam.2, income.p.2), row.names = NULL)
colnames(income.p.3) <- c("Drug", "Adjusted.p.value")
str(income.p.3)
income.p.3$Adjusted.p.value <-
    as.numeric(as.character(income.p.3$Adjusted.p.value))
income.p.3

# Make a table of significant adjusted p-values
income.p.sig <- subset(income.p.3, Adjusted.p.value<0.05)
income.p.sig
