library(ggplot2)
library(scales)
library(easyGgplot2)

rm(list =ls(all=TRUE))

load("SpecExpSet.Rda")
#source("multiplot.R")

p1 <- ggplot(data = SpecExpSet[SpecExpSet$Class == "ByFundType" &
                                 SpecExpSet$Calc == "RiskShare" & 
                                 SpecExpSet$Fund == "Spec3" & 
                                 SpecExpSet$DetsDate != as.Date("2014-12-12"),] , 
             aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), 
            position = 'stack') +
  ggtitle("Spec3") + 
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent)  +
  theme(legend.position="none")   


p2 <- ggplot(data = SpecExpSet[SpecExpSet$Class == "ByFundType" &
                                 SpecExpSet$Calc == "RiskShare" & 
                                 SpecExpSet$Fund == "Spec4" & 
                                 SpecExpSet$DetsDate != as.Date("2014-12-12"),] , 
             aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), 
            position = 'stack') +
  ggtitle("Spec4") + 
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent) +
  theme(legend.position="none")   


p3 <- ggplot(data = SpecExpSet[SpecExpSet$Class == "ByFundType" &
                                 SpecExpSet$Calc == "RiskShare" & 
                                 SpecExpSet$Fund == "Spec5" & 
                                 SpecExpSet$DetsDate != as.Date("2014-12-12"),] , 
             aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), 
            position = 'stack') +
  ggtitle("Spec5") + 
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent)


p4 <- ggplot(data = SpecExpSet[SpecExpSet$Class == "ByFundType" &
                                 SpecExpSet$Calc == "RiskShare" & 
                                 SpecExpSet$Fund == "Spec6" & 
                                 SpecExpSet$DetsDate != as.Date("2014-12-12"),] , 
             aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), 
            position = 'stack') +
  ggtitle("Spec6") + 
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent) +
  theme(legend.position="none")   


p5 <- ggplot(data = SpecExpSet[SpecExpSet$Class == "ByFundType" &
                                 SpecExpSet$Calc == "RiskShare" & 
                                 SpecExpSet$Fund == "Spec7" & 
                                 SpecExpSet$DetsDate != as.Date("2014-12-12"),] , 
             aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), 
            position = 'stack') +
  ggtitle("Spec7") + 
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent) +
  theme(legend.position="none")   


p6 <- ggplot(data = SpecExpSet[SpecExpSet$Class == "ByFundType" &
                                 SpecExpSet$Calc == "RiskShare" & 
                                 SpecExpSet$Fund == "Spec8" & 
                                 SpecExpSet$DetsDate != as.Date("2014-12-12"),] , 
             aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), 
            position = 'stack') +
  ggtitle("Spec8") + 
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent)


png(filename = "RiskShare.png", width=960, height=480)
ggplot2.multiplot(plotlist = list(p1, p2, p3, p4, p5, p6), cols = 3)
dev.off()
