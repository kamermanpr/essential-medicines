# Load and format data
data.all<-read.csv("./data/eml-data.csv", sep=",", header=T)
str(data.all)

# Remove "advanced" economies data
data.dev<-subset(data.all, data.all$IMF=="Developing")
data.dev$IMF<-sapply(data.dev$IMF, factor, labels="Developing")
data.dev$Country<-sapply(data.dev$Country, factor)
str(data.dev)

# Remove "undefined" World.Bank data
levels(data.dev$World.Bank)
data.dev<-subset(data.dev, !data.dev$World.Bank=="Undefined")
data.dev$World.Bank<-sapply(data.dev$World.Bank, factor)
levels(data.dev$World.Bank)
str(data.dev)

########################
# Stats for type of NEML
########################
library(plyr)
type.1<-ddply(data.dev, .(Type, Country), summarise,
              NeuP.yes = sum(Any.NeuP=="Yes")); type.1
type.1$NeuP.yes[type.1$NeuP.yes>0]<-"Yes"
type.1$NeuP.yes[type.1$NeuP.yes==0]<-"No"
type.1
type.2<-with(type.1, xtabs(~NeuP.yes+Type)); type.2
type.2.prop<-round(prop.table(type.2,2),3)*100; type.2.prop
type.2a<-fisher.test(type.2, simulate.p.value=T, B=10000); type.2a
library(fifer)
type.3<-subset(chisq.post.hoc(type.2, popsInRows=F, control="holm"), adj.p<0.05); type.3

#####################################################################################
# Basic stats for region, subregion & income - no correction for multiple comparisons
#####################################################################################
#####
# TCA
# Amitriptyline
ami.1<-subset(data.dev, data.dev$Drug=="Amitriptyline")
ami.1$Drug<-sapply(ami.1$Drug, factor)
# Fisher's test - region as a predictor (.2a)
ami.2<-xtabs(~ami.1$Listed+ami.1$Region); ami.2
ami.2a<-fisher.test(ami.2, simulate.p.value=T, B=10000); ami.2a
# Fisher's test - subregion as a predictor (.3a)
ami.3<-xtabs(~ami.1$Listed+ami.1$Subregion); ami.3
ami.3a<-fisher.test(ami.3, simulate.p.value=T, B=10000); ami.3a
# Fisher's test - income as a predictor (.4a)
ami.4<-xtabs(~ami.1$Listed+ami.1$World.Bank); ami.4
ami.4a<-fisher.test(ami.4, conf.int=T, simulate.p.value=T, B=10000); ami.4a

# Nortriptyline
nort.1<-subset(data.dev, data.dev$Drug=="Nortriptyline")
nort.1$Drug<-sapply(nort.1$Drug, factor)
str(nort.1)
# Fisher's test - region as a predictor
nort.2<-xtabs(~nort.1$Listed+nort.1$Region); nort.2
nort.2a<-fisher.test(nort.2, simulate.p.value=T, B=10000); nort.2a
# Fisher's test - subregion as a predictor
nort.3<-xtabs(~nort.1$Listed+nort.1$Subregion); nort.3
nort.3a<-fisher.test(nort.3, simulate.p.value=T, B=10000); nort.3a
# Fisher's test - income as a predictor
nort.4<-xtabs(~nort.1$Listed+nort.1$World.Bank); nort.4
nort.4a<-fisher.test(nort.4, conf.int=T, simulate.p.value=T, B=10000); nort.4a

# Imipramine
imip.1<-subset(data.dev, data.dev$Drug=="Imipramine")
imip.1$Drug<-sapply(imip.1$Drug, factor)
str(imip.1)
# Fisher's test - region as a predictor
imip.2<-xtabs(~imip.1$Listed+imip.1$Region); imip.2
imip.2.prop<-round(prop.table(imip.2,2),2)*100; imip.2.prop
imip.2a<-fisher.test(imip.2, simulate.p.value=T, B=10000); imip.2a
# Fisher's test - subregion as a predictor
imip.3<-xtabs(~imip.1$Listed+imip.1$Subregion); imip.3
imip.3a<-fisher.test(imip.3, simulate.p.value=T, B=10000); imip.3a
# Fisher's test - income as a predictor
imip.4<-xtabs(~imip.1$Listed+imip.1$World.Bank); imip.4
imip.4a<-fisher.test(imip.4, conf.int=T, simulate.p.value=T, B=10000); imip.4a
imip.4b<-subset(chisq.post.hoc(imip.4, popsInRows=F, control="holm"), adj.p<0.05); imip.4b
CMHtest(imip.4, type='cmeans')

# Desipramine
desip.1<-subset(data.dev, data.dev$Drug=="Desipramine")
desip.1$Drug<-sapply(desip.1$Drug, factor)
str(desip.1)
# Fisher's test - region as a predictor
desip.2<-xtabs(~desip.1$Listed+desip.1$Region); desip.2
desip.2.prop<-round(prop.table(desip.2,2),2)*100; desip.2.prop
desip.2a<-fisher.test(desip.2, simulate.p.value=T, B=10000); desip.2a
# Fisher's test - subregion as a predictor
desip.3<-xtabs(~desip.1$Listed+desip.1$Subregion); desip.3
desip.3a<-fisher.test(desip.3, simulate.p.value=T, B=10000); desip.3a
# Fisher's test - income as a predictor
desip.4<-xtabs(~desip.1$Listed+desip.1$World.Bank); desip.4
desip.4a<-fisher.test(desip.4, conf.int=T, simulate.p.value=T, B=10000); desip.4a

# Clomipramine
clomip.1<-subset(data.dev, data.dev$Drug=="Clomipramine")
clomip.1$Drug<-sapply(clomip.1$Drug, factor)
str(clomip.1)
# Fisher's test - region as a predictor
clomip.2<-xtabs(~clomip.1$Listed+clomip.1$Region); clomip.2
clomip.2.prop<-round(prop.table(clomip.2,2),2)*100; clomip.2.prop
clomip.2a<-fisher.test(clomip.2, simulate.p.value=T, B=10000); clomip.2a
# Fisher's test - subregion as a predictor
clomip.3<-xtabs(~clomip.1$Listed+clomip.1$Subregion); clomip.3
clomip.3a<-fisher.test(clomip.3, simulate.p.value=T, B=10000); clomip.3a
# Fisher's test - income as a predictor
clomip.4<-xtabs(~clomip.1$Listed+clomip.1$World.Bank); clomip.4
clomip.4a<-fisher.test(clomip.4, conf.int=T, simulate.p.value=T, B=10000); clomip.4a

###########
# SNRI/NDRI
# Venlafaxine
venla.1<-subset(data.dev, data.dev$Drug=="Venlafaxine")
venla.1$Drug<-sapply(venla.1$Drug, factor)
str(venla.1)
# Fisher's test - region as a predictor
venla.2<-xtabs(~venla.1$Listed+venla.1$Region); venla.2
venla.2.prop<-round(prop.table(venla.2,2),2)*100; venla.2.prop
venla.2a<-fisher.test(venla.2, simulate.p.value=T, B=10000); venla.2a
# Fisher's test - subregion as a predictor
venla.3<-xtabs(~venla.1$Listed+venla.1$Subregion); venla.3
venla.3a<-fisher.test(venla.3, simulate.p.value=T, B=10000); venla.3a
# Fisher's test - income as a predictor
venla.4<-xtabs(~venla.1$Listed+venla.1$World.Bank); venla.4
venla.4a<-fisher.test(venla.4, conf.int=T, simulate.p.value=T, B=10000); venla.4a

# Duloxetine
dulox.1<-subset(data.dev, data.dev$Drug=="Duloxetine")
dulox.1$Drug<-sapply(dulox.1$Drug, factor)
str(dulox.1)
# Fisher's test - region as a predictor
dulox.2<-xtabs(~dulox.1$Listed+dulox.1$Region); dulox.2
dulox.2.prop<-round(prop.table(dulox.2,2),2)*100; dulox.2.prop
dulox.2a<-fisher.test(dulox.2, simulate.p.value=T, B=10000); dulox.2a
# Fisher's test - subregion as a predictor
dulox.3<-xtabs(~dulox.1$Listed+dulox.1$Subregion); dulox.3
dulox.3a<-fisher.test(dulox.3, simulate.p.value=T, B=10000); dulox.3a
# Fisher's test - income as a predictor
dulox.4<-xtabs(~dulox.1$Listed+dulox.1$World.Bank); dulox.4
dulox.4a<-fisher.test(dulox.4, conf.int=T, simulate.p.value=T, B=10000); dulox.4a

# Buproprion
bupr.1<-subset(data.dev, data.dev$Drug=="Bupropion")
bupr.1$Drug<-sapply(bupr.1$Drug, factor)
str(bupr.1)
# Fisher's test - region as a predictor
bupr.2<-xtabs(~bupr.1$Listed+bupr.1$Region); bupr.2
bupr.2.prop<-round(prop.table(bupr.2,2),2)*100; bupr.2.prop
bupr.2a<-fisher.test(bupr.2, simulate.p.value=T, B=10000); bupr.2a
# Fisher's test - subregion as a predictor
bupr.3<-xtabs(~bupr.1$Listed+bupr.1$Subregion); bupr.3
bupr.3a<-fisher.test(bupr.3, simulate.p.value=T, B=10000); bupr.3a
# Fisher's test - income as a predictor
bupr.4<-xtabs(~bupr.1$Listed+bupr.1$World.Bank); bupr.4
bupr.4a<-fisher.test(bupr.4, conf.int=T, simulate.p.value=T, B=10000); bupr.4a

#################
# Anticonvulsants
# Gabapentin
gaba.1<-subset(data.dev, data.dev$Drug=="Gabapentin")
gaba.1$Drug<-sapply(gaba.1$Drug, factor)
str(gaba.1)
# Fisher's test - region as a predictor
gaba.2<-xtabs(~gaba.1$Listed+gaba.1$Region); gaba.2
gaba.2.prop<-round(prop.table(gaba.2,2),2)*100; gaba.2.prop
gaba.2a<-fisher.test(gaba.2, simulate.p.value=T, B=10000); gaba.2a
# Fisher's test - subregion as a predictor
gaba.3<-xtabs(~gaba.1$Listed+gaba.1$Subregion); gaba.3
gaba.3a<-fisher.test(gaba.3, simulate.p.value=T, B=10000); gaba.3a
# Fisher's test - income as a predictor
gaba.4<-xtabs(~gaba.1$Listed+gaba.1$World.Bank); gaba.4
gaba.4a<-fisher.test(gaba.4, conf.int=T, simulate.p.value=T, B=10000); gaba.4a

# Pregabalin
preg.1<-subset(data.dev, data.dev$Drug=="Pregabalin")
preg.1$Drug<-sapply(preg.1$Drug, factor)
str(preg.1)
# Fisher's test - region as a predictor
preg.2<-xtabs(~preg.1$Listed+preg.1$Region); preg.2
preg.2.prop<-round(prop.table(preg.2,2),2)*100; preg.2.prop
preg.2a<-fisher.test(preg.2, simulate.p.value=T, B=10000); preg.2a
# Fisher's test - subregion as a predictor
preg.3<-xtabs(~preg.1$Listed+preg.1$Subregion); preg.3
preg.3a<-fisher.test(preg.3, simulate.p.value=T, B=10000); preg.3a
# Fisher's test - income as a predictor
preg.4<-xtabs(~preg.1$Listed+preg.1$World.Bank); preg.4
preg.4a<-fisher.test(preg.4, conf.int=T, simulate.p.value=T, B=10000); preg.4a

# Carbamazepine
carba.1<-subset(data.dev, data.dev$Drug=="Carbamazepine")
carba.1$Drug<-sapply(carba.1$Drug, factor)
str(carba.1)
# Fisher's test - region as a predictor
carba.2<-xtabs(~carba.1$Listed+carba.1$Region); carba.2
carba.2.prop<-round(prop.table(carba.2,2),2)*100; carba.2.prop
carba.2a<-fisher.test(carba.2, simulate.p.value=T, B=10000); carba.2a
# Fisher's test - subregion as a predictor
carba.3<-xtabs(~carba.1$Listed+carba.1$Subregion); carba.3
carba.3a<-fisher.test(carba.3, simulate.p.value=T, B=10000); carba.3a
# Fisher's test - income as a predictor
carba.4<-xtabs(~carba.1$Listed+carba.1$World.Bank); carba.4
carba.4a<-fisher.test(carba.4, conf.int=T, simulate.p.value=T, B=10000); carba.4a

# Oxcarbazepine
oxcarb.1<-subset(data.dev, data.dev$Drug=="Oxcarbazepine")
oxcarb.1$Drug<-sapply(oxcarb.1$Drug, factor)
str(oxcarb.1)
# Fisher's test - region as a predictor
oxcarb.2<-xtabs(~oxcarb.1$Listed+oxcarb.1$Region); oxcarb.2
oxcarb.2.prop<-round(prop.table(oxcarb.2,2),2)*100; oxcarb.2.prop
oxcarb.2a<-fisher.test(oxcarb.2, simulate.p.value=T, B=10000); oxcarb.2a
# Fisher's test - subregion as a predictor
oxcarb.3<-xtabs(~oxcarb.1$Listed+oxcarb.1$Subregion); oxcarb.3
oxcarb.3a<-fisher.test(oxcarb.3, simulate.p.value=T, B=10000); oxcarb.3a
# Fisher's test - income as a predictor
oxcarb.4<-xtabs(~oxcarb.1$Listed+oxcarb.1$World.Bank); oxcarb.4
oxcarb.4a<-fisher.test(oxcarb.4, conf.int=T, simulate.p.value=T, B=10000); oxcarb.4a

# Valproate
valp.1<-subset(data.dev, data.dev$Drug=="Valproate")
valp.1$Drug<-sapply(valp.1$Drug, factor)
str(valp.1)
# Fisher's test - region as a predictor
valp.2<-xtabs(~valp.1$Listed+valp.1$Region); valp.2
valp.2.prop<-round(prop.table(valp.2,2),2)*100; valp.2.prop
valp.2a<-fisher.test(valp.2, simulate.p.value=T, B=10000); valp.2a
# Fisher's test - subregion as a predictor
valp.3<-xtabs(~valp.1$Listed+valp.1$Subregion); valp.3
valp.3a<-fisher.test(valp.3, simulate.p.value=T, B=10000); valp.3a
# Fisher's test - income as a predictor
valp.4<-xtabs(~valp.1$Listed+valp.1$World.Bank); valp.4
valp.4a<-fisher.test(valp.4, conf.int=T, simulate.p.value=T, B=10000); valp.4a

#########
# Opioids
# Morphine
morph.1<-subset(data.dev, data.dev$Drug=="Morphine")
morph.1$Drug<-sapply(morph.1$Drug, factor)
str(morph.1)
# Fisher's test - region as a predictor
morph.2<-xtabs(~morph.1$Listed+morph.1$Region); morph.2
morph.2.prop<-round(prop.table(morph.2,2),2)*100; morph.2.prop
morph.2a<-fisher.test(morph.2, simulate.p.value=T, B=10000); morph.2a
# Fisher's test - subregion as a predictor
morph.3<-xtabs(~morph.1$Listed+morph.1$Subregion); morph.3
morph.3a<-fisher.test(morph.3, simulate.p.value=T, B=10000); morph.3a
# Fisher's test - income as a predictor
morph.4<-xtabs(~morph.1$Listed+morph.1$World.Bank); morph.4
morph.4a<-fisher.test(morph.4, conf.int=T, simulate.p.value=T, B=10000); morph.4a

# Oxycodone
oxycod.1<-subset(data.dev, data.dev$Drug=="Oxycodone")
oxycod.1$Drug<-sapply(oxycod.1$Drug, factor)
str(oxycod.1)
# Fisher's test - region as a predictor
oxycod.2<-xtabs(~oxycod.1$Listed+oxycod.1$Region); oxycod.2
oxycod.2.prop<-round(prop.table(oxycod.2,2),2)*100; oxycod.2.prop
oxycod.2a<-fisher.test(oxycod.2, simulate.p.value=T, B=10000); oxycod.2a
# Fisher's test - subregion as a predictor
oxycod.3<-xtabs(~oxycod.1$Listed+oxycod.1$Subregion); oxycod.3
oxycod.3a<-fisher.test(oxycod.3, simulate.p.value=T, B=10000); oxycod.3a
# Fisher's test - income as a predictor
oxycod.4<-xtabs(~oxycod.1$Listed+oxycod.1$World.Bank); oxycod.4
oxycod.4a<-fisher.test(oxycod.4, conf.int=T, simulate.p.value=T, B=10000); oxycod.4a

# Methadone
meth.1<-subset(data.dev, data.dev$Drug=="Methadone")
meth.1$Drug<-sapply(meth.1$Drug, factor)
str(meth.1)
# Fisher's test - region as a predictor
meth.2<-xtabs(~meth.1$Listed+meth.1$Region); meth.2
meth.2.prop<-round(prop.table(meth.2,2),2)*100; meth.2.prop
meth.2a<-fisher.test(meth.2, simulate.p.value=T, B=10000); meth.2a
# Fisher's test - subregion as a predictor
meth.3<-xtabs(~meth.1$Listed+meth.1$Subregion); meth.3
meth.3a<-fisher.test(meth.3, simulate.p.value=T, B=10000); meth.3a
# Fisher's test - income as a predictor
meth.4<-xtabs(~meth.1$Listed+meth.1$World.Bank); meth.4
meth.4a<-fisher.test(meth.4, conf.int=T, simulate.p.value=T, B=10000); meth.4a

# Tramadol
tram.1<-subset(data.dev, data.dev$Drug=="Tramadol")
tram.1$Drug<-sapply(tram.1$Drug, factor)
str(tram.1)
# Fisher's test - region as a predictor
tram.2<-xtabs(~tram.1$Listed+tram.1$Region); tram.2
tram.2.prop<-round(prop.table(tram.2,2),2)*100; tram.2.prop
tram.2a<-fisher.test(tram.2, simulate.p.value=T, B=10000); tram.2a
# Fisher's test - subregion as a predictor
tram.3<-xtabs(~tram.1$Listed+tram.1$Subregion); tram.3
tram.3a<-fisher.test(tram.3, simulate.p.value=T, B=10000); tram.3a
# Fisher's test - income as a predictor
tram.4<-xtabs(~tram.1$Listed+tram.1$World.Bank); tram.4
tram.4a<-fisher.test(tram.4, conf.int=T, simulate.p.value=T, B=10000); tram.4a

##########
# Topicals
# Capsaicin
cap.1<-subset(data.dev, data.dev$Drug=="Capsaicin")
cap.1$Drug<-sapply(cap.1$Drug, factor)
str(cap.1)
# Fisher's test - region as a predictor
cap.2<-xtabs(~cap.1$Listed+cap.1$Region); cap.2
cap.2.prop<-round(prop.table(cap.2,2),2)*100; cap.2.prop
cap.2a<-fisher.test(cap.2, simulate.p.value=T, B=10000); cap.2a
# Fisher's test - subregion as a predictor
cap.3<-xtabs(~cap.1$Listed+cap.1$Subregion); cap.3
cap.3a<-fisher.test(cap.3, simulate.p.value=T, B=10000); cap.3a
# Fisher's test - income as a predictor
cap.4<-xtabs(~cap.1$Listed+cap.1$World.Bank); cap.4
cap.4a<-fisher.test(cap.4, conf.int=T, simulate.p.value=T, B=10000); cap.4a

# Lidocaine
lido.1<-subset(data.dev, data.dev$Drug=="Lidocaine")
lido.1$Drug<-sapply(lido.1$Drug, factor)
str(lido.1)
# Fisher's test - region as a predictor
lido.2<-xtabs(~lido.1$Listed+lido.1$Region); lido.2
lido.2.prop<-round(prop.table(lido.2,2),2)*100; lido.2.prop
lido.2a<-fisher.test(lido.2, simulate.p.value=T, B=10000); lido.2a
# Fisher's test - subregion as a predictor
lido.3<-xtabs(~lido.1$Listed+lido.1$Subregion); lido.3
lido.3a<-fisher.test(lido.3, simulate.p.value=T, B=10000); lido.3a
# Fisher's test - income as a predictor
lido.4<-xtabs(~lido.1$Listed+lido.1$World.Bank); lido.4
lido.4a<-fisher.test(lido.4, conf.int=T, simulate.p.value=T, B=10000); lido.4a

###################################################################
# Correction for multiple comparisons - region as a predictor (.2a)
###################################################################
nam.2<-c("Amitriptyline", "Nortriptyline", "Imipramine", "Desipramine", "Clomipramine",
       "Venlafaxine", "Duloxetine",
       "Gabapentin", "Pregabalin", "Carbamazepine", "Oxcarbazepine",
       "Morphine", "Oxycodone", "Methadone", "Tramadol",
       "Lidocaine") # no capsaicin or levorphanol because they were not included on any NEMLs
region.p<-c(ami.2a$p.value, nort.2a$p.value, imip.2a$p.value, desip.2a$p.value, clomip.2a$p.value,
            venla.2a$p.value, dulox.2a$p.value,
            gaba.2a$p.value, preg.2a$p.value, carba.2a$p.value, oxcarb.2a$p.value,
            morph.2a$p.value, oxycod.2a$p.value, meth.2a$p.value, tram.2a$p.value,
            lido.2a$p.value); region.p
# calculated adjusted p-values
region.p.2<-p.adjust(region.p, method="holm"); region.p.2
# Make data.frame of adjusted p-values with drug names
region.p.3<-data.frame(cbind(nam.2, region.p.2), row.names=NULL)
colnames(region.p.3)<-c("Drug", "Adjusted.p.value")
str(region.p.3)
region.p.3$Adjusted.p.value<-as.numeric(as.character(region.p.3$Adjusted.p.value)); region.p.3

# Make a table of significant adjusted p-values
region.p.sig<-subset(region.p.3, Adjusted.p.value<0.05); region.p.sig

# Do post-hoc tests on significant results
library(fifer)
# Imipramine
imip.2
round(prop.table(imip.2,2),3)*100
imip.r<-subset(chisq.post.hoc(imip.2, popsInRows=F, control="holm"), adj.p<0.05); imip.r
# Venlafaxine
venla.2
round(prop.table(venla.2,2),3)*100
venla.r<-subset(chisq.post.hoc(venla.2, popsInRows=F, control="holm"), adj.p<0.05); venla.r
# Gabapentin
gaba.2
round(prop.table(gaba.2,2),3)*100
gaba.r<-subset(chisq.post.hoc(gaba.2, popsInRows=F, control="holm"), adj.p<0.05); gaba.r
# Oxcarbazepine
oxcarb.2
round(prop.table(oxcarb.2,2),3)*100
oxcarb.r<-subset(chisq.post.hoc(oxcarb.2, popsInRows=F, control="holm"), adj.p<0.05); oxcarb.r
# Methadone
meth.2
round(prop.table(meth.2,2),3)*100
meth.r<-subset(chisq.post.hoc(meth.2, popsInRows=F, control="holm"), adj.p<0.05); meth.r
# Oxycodone
oxycod.2
round(prop.table(oxycod.2,2),3)*100
oxycod.r<-subset(chisq.post.hoc(oxycod.2, popsInRows=F, control="holm"), adj.p<0.05); oxycod.r

###################################################################
# Correction for multiple comparisons - income as a predictor (.4a)
###################################################################
nam.4<-c("Amitriptyline", "Nortriptyline", "Imipramine", "Desipramine", "Clomipramine",
         "Venlafaxine", "Duloxetine",
         "Gabapentin", "Pregabalin", "Carbamazepine", "Oxcarbazepine",
         "Morphine", "Oxycodone", "Methadone", "Tramadol",
         "Lidocaine")
income.p<-c(ami.4a$p.value, nort.4a$p.value, imip.4a$p.value, desip.4a$p.value, clomip.4a$p.value,
            venla.4a$p.value, dulox.4a$p.value,
            gaba.4a$p.value, preg.4a$p.value, carba.4a$p.value, oxcarb.4a$p.value,
            morph.4a$p.value, oxycod.4a$p.value, meth.4a$p.value, tram.4a$p.value,
            lido.4a$p.value); income.p
# calculated adjusted p-values
income.p.2<-p.adjust(income.p, method="holm"); income.p.2
# Make data.frame of adjusted p-values with drug names
income.p.3<-data.frame(cbind(nam.4, income.p.2), row.names=NULL)
colnames(income.p.3)<-c("Drug", "Adjusted.p.value")
str(income.p.3)
income.p.3$Adjusted.p.value<-as.numeric(as.character(income.p.3$Adjusted.p.value)); income.p.3
# Make a table of significant adjusted p-values
income.p.sig<-subset(income.p.3, Adjusted.p.value<0.05); income.p.sig
# Do post-hoc tests on significant results
library(fifer)
# Imipramine
imip.4
round(prop.table(imip.4,2),3)*100
imip.i<-subset(chisq.post.hoc(imip.4, popsInRows=F, control="holm"), adj.p<0.05); imip.i
# Gabapentin
gaba.4
round(prop.table(gaba.4,2),3)*100
gaba.i<-subset(chisq.post.hoc(gaba.4, popsInRows=F, control="holm"), adj.p<0.05); gaba.i
# Methadone
meth.4
round(prop.table(meth.4,2),3)*100
meth.i<-subset(chisq.post.hoc(meth.4, popsInRows=F, control="holm"), adj.p<0.05); meth.i
