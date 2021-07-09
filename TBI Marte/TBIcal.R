library(lattice)
library(readxl)
library(ggplot2)

tbi_mf <- read_csv("Personlig/tbi_mf.csv")
TBIref <- read_excel("Personlig/TBIref.xlsx")


dotchart(tbi_mf$WeightBagLabel)
table(tbi_mf$Day)
table(tbi_mf$Tea_type)
table(tbi_mf$Bag_ID)
dotchart(tbi_mf$`BeforeWeight(TeaOnly)`)
dotchart(tbi_mf$`AfterWeight(TeaOnly)`)
plot(tbi_mf$`AfterWeight(TeaOnly)`, tbi_mf$`BeforeWeight(TeaOnly)`)
plot(tbi_mf$`AfterWeight(TeaOnly)`, tbi_mf$WeightLoss)
names(tbi_mf)
names(tbi_mf)[6]<- "startWeight"
names(tbi_mf)[7]<- "endWeight"

tbi_mf$weightLosts <- tbi_mf$startWeight-tbi_mf$endWeight
plot(tbi_mf$WeightLoss, tbi_mf$weightLosts)
# hvorfor er ikke disse like?
# og hva har skjedd med den som har negativ verdi?
# jeg må gjøre denne positiv for å regne ut brøk senere:
tbi_mf$weightLosts[tbi_mf$weightLosts<0] <- 0.0001
dotchart(tbi_mf$weightLosts)

tbi_mf$massRemaining <- tbi_mf$startWeight-tbi_mf$weightLosts
dotchart(tbi_mf$massRemaining)

tbi_mf$fractionRemaining <- tbi_mf$massRemaining/tbi_mf$startWeight 
dotchart(tbi_mf$fractionRemaining)




ggplot()+
  geom_point(data=tbi_mf, aes(x=Day, y=fractionRemaining,
                              fill=Tea_type),
             size=3, stroke=2, pch=21)+
  geom_point(data=TBIref, aes(x=x, y=y, colour=type),
             size=2, pch=1, stroke=2)+
  geom_smooth(data=TBIref, aes(x=x, y=y, colour=type),
              se=F, method="loess", span=0.8)+
  theme_bw()

# Jeg har regnet ut en mye lavere fractionRemaining enn hva Marte hadde

plot(tbi_mf$fractionRemaining, tbi_mf$WeightLossPercentage/100)
  


