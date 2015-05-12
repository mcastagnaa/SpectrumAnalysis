library(reshape2)
library(PerformanceAnalytics)


rm(list =ls(all=TRUE))

load("SpecExpSet.Rda")
load("CombByDate.Rda")

RollingObs <- 20

FundsExp <- reshape(SpecExpSet[SpecExpSet$Calc == "NetExp" &
                                SpecExpSet$Class =="ByFundType" &
                                SpecExpSet$Typ == "Equity Fund" & 
                                SpecExpSet$DetsDate != as.Date("2014-12-12"),
                               ],  
                    drop = c("Typ", "Class", "Calc"),
                    idvar = c("DetsDate"),
                    timevar = "Fund", 
                    direction = "wide")
names(FundsExp) <- c("Date", 
                     "Spec3EqFuExp", 
                     "Spec4EqFuExp", 
                     "Spec5EqFuExp",
                     "Spec6EqFuExp",
                     "Spec7EqFuExp",
                     "Spec8EqFuExp")
FundsExp <- FundsExp[complete.cases(FundsExp),]
RollFuExpAv <- data.frame(cbind(FundsExp$Date, 
                              rollapplyr(FundsExp[c("Spec3EqFuExp", 
                                                   "Spec4EqFuExp", 
                                                   "Spec5EqFuExp", 
                                                   "Spec6EqFuExp", 
                                                   "Spec7EqFuExp", 
                                                   "Spec8EqFuExp")], 
                                         RollingObs, mean, fill=NA)))
colnames(RollFuExpAv)[1] <- "Date"
RollFuExpAv$Date <- as.Date(RollFuExpAv$Date)


EquityExp <- reshape(SpecExpSet[SpecExpSet$Calc == "NetExp" &
                                SpecExpSet$Class =="BySecGroup" &
                                SpecExpSet$Typ == "Equities"&
                                SpecExpSet$DetsDate != as.Date("2014-12-12"),
                                ],  
                    drop = c("Typ", "Class", "Calc"),
                    idvar = c("DetsDate"),
                    timevar = "Fund", 
                    direction = "wide")
names(EquityExp) <- c("Date", 
                      "Spec3EqExp", 
                      "Spec4EqExp", 
                      "Spec5EqExp",
                      "Spec6EqExp",
                      "Spec7EqExp",
                      "Spec8EqExp")
EquityExp <- FundsExp[complete.cases(EquityExp),]

RollEqExpAv <- data.frame(cbind(EquityExp$Date, 
                                rollapplyr(EquityExp[c("Spec3EqExp", 
                                                      "Spec4EqExp", 
                                                      "Spec5EqExp", 
                                                      "Spec6EqExp", 
                                                      "Spec7EqExp", 
                                                      "Spec8EqExp")], 
                                           RollingObs, mean, fill=NA)))
colnames(RollEqExpAv)[1] <- "Date"
RollEqExpAv$Date <- as.Date(RollEqExpAv$Date)


###########################
## Pick the "right" exposure variable
## RollFuExAv for equity funds exposure
## RollEqExAv for equity exposure

ExpRollMelt <- melt(RollFuExpAv, id.var = c("Date"), value.name = "Exposure")
ExpRollMelt$variable <- substr(ExpRollMelt$variable, 1, 5)

###########################

Returns <- subset(CombByDate, select = c(Date,
                                         Spec3Ret,
                                         Spec4Ret,
                                         Spec5Ret,
                                         Spec6Ret,
                                         Spec7Ret,
                                         Spec8Ret,
                                         VIX)
)

RollRetSd <- data.frame(cbind(Returns$Date, 
                           rollapplyr(Returns[c("Spec3Ret", 
                                                "Spec4Ret", 
                                                "Spec5Ret", 
                                                "Spec6Ret", 
                                                "Spec7Ret", 
                                                "Spec8Ret")], 
                                      RollingObs, sd, fill=NA)))
colnames(RollRetSd)[1] <- "Date"

RollRetSd$Date <- as.Date(RollRetSd$Date)

RetSdRollMelt <- melt(RollRetSd, id.var=c("Date"), value.name = "SdRet")
RetSdRollMelt$variable <- substr(RetSdRollMelt$variable, 1, 5)

############

VIXdf <- data.frame(cbind(Returns$Date, 
                              rollapplyr(Returns[c("VIX")], 
                                         RollingObs, mean, fill=NA)))
colnames(VIXdf)[1] <- "Date"

VIXdf$Date <- as.Date(VIXdf$Date)


############

RegSet <- merge(ExpRollMelt, RetSdRollMelt, by = c("Date", "variable"))
RegSet <- merge(RegSet, VIXdf, by = "Date")