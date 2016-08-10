# Load and format data
data.all <- read.csv("./data/2015-neml-data.csv", sep = ",", header = T)
str(data.all)

# Remove "advanced" economies data
data.dev <- subset(data.all, data.all$IMF == "Developing")
data.dev$IMF <- sapply(data.dev$IMF, factor, labels="Developing")
data.dev$Country <- sapply(data.dev$Country, factor)
str(data.dev)

########################################
# Stats for drug class listings on NEMLs
########################################
library(plyr)
library(fifer)
library(vcd)
library(vcdExtra)
library(coin)
drug.line.1 <- ddply(data.dev, .(Country, Type, World.Bank, Region),
                     summarize,
                   TCA.yes = sum(Listed == "Yes" & Class == "TCA"),
                   SNRI.yes = sum(Listed == "Yes" & Class == "SNRI"),
                   a2delta.yes = sum(Listed == "Yes" & Class == "Anticonvulsant" & (Drug == "Pregabalin" | Drug == "Gabapentin")),
                   Tramadol.yes = sum(Listed == "Yes" & Drug == "Tramadol"),
                   Lido.yes = sum(Listed == "Yes" & Drug == "Lidocaine"),
                   Strong.opioid.yes = sum(Listed == "Yes" & (Drug == "Morphine" | Drug == "Methadone" | Drug == "Oxycodone")),
                   Other.yes = sum(Listed == "Yes" & (Drug == "Carbamazepine" | Drug == "Oxcarbazepine" | Drug == "Valproate")))
drug.line.2 <- drug.line.1
drug.line.2[,5:11][drug.line.2[,5:11]  >0] <- "1"

# Convert to numeric
drug.line.2[,5:11] <- sapply(drug.line.2[,5:11], as.numeric)
str(drug.line.2)

drug.line.3 <- ddply(drug.line.2, .(Country, Type, World.Bank, Region), summarize,
                   First.line = sum(TCA.yes, SNRI.yes, a2delta.yes),
                   Second.line = sum(Tramadol.yes, Lido.yes),
                   First.Second = sum(TCA.yes, SNRI.yes, a2delta.yes,
                                      Tramadol.yes, Lido.yes),
                   Third.line = sum(Strong.opioid.yes),
                   Other.anticonvulsants = sum(Other.yes))
drug.line.num <- drug.line.3

# Convert back to factors
drug.line.3[,5:6] <- lapply(drug.line.3[,5:6], factor); str(drug.line.3)

# Remove "Undefined" World.Bank category
drug.line.3 <- drug.line.3[!drug.line.3$World.Bank == "Undefined", ]
str(drug.line.3)
drug.line.3$World.Bank <- sapply(drug.line.3$World.Bank, factor)
str(drug.line.3)
drug.line.4 <- drug.line.3

# Ordered factors
drug.line.4$World.Bank <- factor(drug.line.4$World.Bank,
                               levels = c("Low", "Lower middle",
                                          "Upper middle", "High"),
                               ordered = T)
str(drug.line.4)
drug.line.4$First.line <- factor(drug.line.4$First.line, ordered = T)
str(drug.line.4)
drug.line.4$Second.line <- factor(drug.line.4$Second.line, ordered = T)
str(drug.line.4)

# Overall number of classes
class.1 <- with(drug.line.4, xtabs(~First.line))
class.1
class.1b <- (class.1/109)*100; round(class.1b,0)
sum(class.1b)
class.2 <- with(drug.line.4, xtabs(~Second.line))
class.2
class.2b <- (class.2/109)*100; round(class.2b,0)
sum(class.2b)
#
# First line vs income (tab.2)
tab.2 <- with(drug.line.4, xtabs(~First.line+World.Bank))
tab.2
tab.2.prop <- round(prop.table(tab.2,2),4)*100
tab.2.prop
tab.2a <- fisher.test(tab.2, simulate.p.value = T, B = 10000)
tab.2a
tab.2b <- subset(chisq.post.hoc(tab.2, popsInRows = F, control = "holm"),
                 adj.p<0.05)
tab.2b
tab.2c <- CMHtest(tab.2, type = "cor")
tab.2c

# Second line vs income (tab.2nd.2)
tab.2nd.2 <- with(drug.line.4, xtabs(~Second.line+World.Bank))
tab.2nd.2
tab.2nd.2.prop <- round(prop.table(tab.2nd.2,2),4)*100
tab.2nd.2.prop
tab.2nd.2a <- fisher.test(tab.2nd.2, simulate.p.value = T, B = 10000)
tab.2nd.2a
tab.2nd.2b <- subset(chisq.post.hoc(tab.2nd.2, popsInRows = F,
                                    control = "holm"), adj.p<0.05)
tab.2nd.2b
tab.2nd.2c <- CMHtest(tab.2nd.2, type = "cor")
tab.2nd.2c

#################
# Adjust p-values
#################
nam <- c("First line", "Second line")
nam
pval <- c(tab.2c$table[3], tab.2nd.2c$table[3])
pval
adj.pval <- p.adjust(pval, method = "holm")
adj.pval
data.frame(cbind(nam, pval, adj.pval))

##############################
# Only amitriptyline available
##############################
ami.1 <- ddply(data.dev, .(Country, World.Bank), summarize,
             Ami.yes = sum(Listed == "Yes" & Drug == "Amitriptyline"),
             TCA.yes = sum(Listed == "Yes" & Class == "TCA"),
             SNRI.yes = sum(Listed == "Yes" & Class == "SNRI"),
             a2delta.yes = sum(Listed == "Yes" & Class == "Anticonvulsant" & (Drug == "Pregabalin" | Drug == "Gabapentin")),
             Tramadol.yes = sum(Listed == "Yes" & Drug == "Tramadol"),
             Lido.yes = sum(Listed == "Yes" & Drug == "Lidocaine")); ami.1
ami.2 <- ami.1[!ami.1$Ami.yes == "0",] # select countries with amitriptyline listed
rownames(ami.2) <- NULL
ami.2
ami.3 <- subset(ami.2, TCA.yes == "1"); ami.3 # select countries where amitriptyline is the only TCA
ami.4 <- subset(ami.3, Ami.yes == "1" & TCA.yes == "1" & SNRI.yes == "0"& a2delta.yes == "0",
              select = c(World.Bank, Ami.yes, TCA.yes, SNRI.yes, a2delta.yes)) # select countries with amitriptyline and no other first-line drugs
ami.4
ami.5 <- ami.4[!ami.4$World.Bank == "Undefined",] # remove "undefined" World Bank class
ami.5
ami.6 <- with(ami.5, xtabs(~World.Bank+Ami.yes)) # tabulate
ami.7 <- subset(ami.3, Ami.yes == "1" & TCA.yes == "1" & SNRI.yes == "0" & a2delta.yes == "0" & Tramadol.yes == "0" & Lido.yes == "0",
              select = c(World.Bank, Ami.yes, TCA.yes, SNRI.yes, a2delta.yes,
                         Tramadol.yes, Lido.yes)) # select countries with amitriptyline and no other first-line AND second-line drugs
ami.7
ami.8 <- ami.7[!ami.7$World.Bank == "Undefined",]
ami.8 # remove "undefined" World Bank class
ami.9 <- with(ami.8, xtabs(~World.Bank+Ami.yes)) # tabulate

# First-line
round(prop.table(ami.6, 2),2)*100

# Second-line
round(prop.table(ami.9, 2),2)*100

#########
# Figure
#########
first <- round(cbind(class.1b, tab.2.prop),1)
first
colnames(first)[1] <- "All"
first

pdf("./figures/2015-figure.pdf", paper='a4r')
par(mfrow = c(2,1))
par(mar = c(3,6,4,6))
par(xpd = T)
barplot(first, col = c("red", "orange", "green", "blue"),
        xaxt='n', yaxt='n')
mtext("Percentage of NEMLs (%)", side = 2, line = 3, cex = 1.1)
mtext("First-line drug classes", side = 3, line = 0.8, at = 1.4, cex = 1.2)
axis(2, lwd = 2, cex.axis = 1.1, las = 2)
legend(6.2,80, legend = c("0", "1*", "2", "3"), ncol = 1,
       title = "Number of\ndrug classes\navailable",
       fill = c("red", "orange", "green", "blue"), xpd = T, bty='n')
second <- round(cbind(class.2b, tab.2nd.2.prop),2); second
colnames(second)[1] <- "All"; second
par(mar = c(7,6,0,6))
bp <- barplot(second, col = c("red", "orange", "green"),
        ylim = c(0,100), yaxt='n', xaxt='n')
mtext("Percentage of NEMLs (%)", side = 2, line = 3, cex = 1.1)
mtext("Second-line drug classes", side = 3, line = 0.8, at = 1.6, cex = 1.2)
axis(2, lwd = 2, cex.axis = 1.1, las = 2)
mtext("All", side = 1, line = 0.5, at = bp[1])
mtext("(n = 109)", side = 1, line = 2.2, at = bp[1], cex = 0.9)
mtext("Low", side = 1, line = 0.5, at = bp[2])
mtext("(n = 24)", side = 1, line = 2.2, at = bp[2], cex = 0.9)
mtext("Lower\nmiddle", side = 1, line = 0.5, at = bp[3], padj = 0.6)
mtext("(n = 40)", side = 1, line = 2.2, at = bp[3], cex = 0.9)
mtext("Higher\nmiddle", side = 1, line = 0.5, at = bp[4], padj = 0.6)
mtext("(n = 37)", side = 1, line = 2.2, at = bp[4], cex = 0.9)
mtext("High", side = 1, line = 0.5, at = bp[5])
mtext("(n = 8)", side = 1, line = 2.2, at = bp[5], cex = 0.9)
segments(bp[2]-0.3,-33,bp[5]+0.3,-33, lty = 1, lwd = 2)
mtext("World Bank income category", side = 1, at=((bp[5]-bp[2])/2)+bp[2], line = 3.7)
dev.off()
