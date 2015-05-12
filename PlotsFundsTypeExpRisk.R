library(ggplot2)
library(scales)

FundExpTypeSet <- SpecExpSet[SpecExpSet$Class == "ByFundType" &
                        SpecExpSet$Calc == "NetExp" & 
                        SpecExpSet$DetsDate != as.Date("2014-12-12"), 
                      c("DetsDate", "Val", "Fund", "Typ")]
rownames(FundExpTypeSet) <- NULL

ggplot(data = FundExpTypeSet[complete.cases(FundExpTypeSet),] , 
       aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), position = 'stack') +
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent) +
  facet_wrap(~ Fund)


FundExpTypeSet <- SpecExpSet[SpecExpSet$Class == "ByFundType" &
                               SpecExpSet$Calc == "RiskShare" & 
                               SpecExpSet$DetsDate != as.Date("2014-12-12"), 
                             c("DetsDate", "Val", "Fund", "Typ")]
rownames(FundExpTypeSet) <- NULL

ggplot(data = FundExpTypeSet[complete.cases(FundExpTypeSet),] , 
       aes(DetsDate,  Val)) + 
  geom_area(aes(colour = Typ, fill = Typ), position = 'stack') +
  scale_fill_brewer(palette="Greens") + 
  scale_y_continuous(labels = percent) +
  facet_wrap(~ Fund)

