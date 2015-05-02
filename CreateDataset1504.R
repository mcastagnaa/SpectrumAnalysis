rm(list =ls(all=TRUE))

FundPrices <- read.csv("CitiPrices.csv", header = TRUE)
FundPrices$Date <- as.Date(FundPrices$Date, "%d/%m/%Y")
str(FundPrices)
names(FundPrices)

SectorRet <- read.csv("IMAreturns1504.csv", header = TRUE)
SectorRet$Date <- as.Date(SectorRet$Date, "%d-%b-%y")
str(SectorRet)
names(SectorRet)
SectorRet$IMA35Med <- SectorRet$IMA35Med/100
SectorRet$IMA60Med <- SectorRet$IMA60Med/100
SectorRet$IMA85Med <- SectorRet$IMA85Med/100
SectorRet$IMAfMed <- SectorRet$IMAfMed/100
SectorRet$IMA35Avg <- SectorRet$IMA35Avg/100
SectorRet$IMA60Avg <- SectorRet$IMA60Avg/100
SectorRet$IMA85Avg <- SectorRet$IMA85Avg/100
SectorRet$IMAfAvg <- SectorRet$IMAfAvg/100


FundPRes <- reshape(FundPrices[FundPrices$Class == "OA",],  
                    drop = c("Class", "SwingBasis", "Bid", "Offer"),
                    idvar = c("Date"),
                    timevar = "Fund", 
                    direction = "wide")
head(FundPRes)
n <- nrow(FundPRes)
FundPRes$Spec3Ret <- c(NA, FundPRes$Mid.SKSPEC3[2:n]/FundPRes$Mid.SKSPEC3[1:n-1]-1)
FundPRes$Spec4Ret <- c(NA, FundPRes$Mid.SKSPEC4[2:n]/FundPRes$Mid.SKSPEC4[1:n-1]-1)
FundPRes$Spec5Ret <- c(NA, FundPRes$Mid.SKSPEC5[2:n]/FundPRes$Mid.SKSPEC5[1:n-1]-1)
FundPRes$Spec6Ret <- c(NA, FundPRes$Mid.SKSPEC6[2:n]/FundPRes$Mid.SKSPEC6[1:n-1]-1)
FundPRes$Spec7Ret <- c(NA, FundPRes$Mid.SKSPEC7[2:n]/FundPRes$Mid.SKSPEC7[1:n-1]-1)
FundPRes$Spec8Ret <- c(NA, FundPRes$Mid.SKSPEC8[2:n]/FundPRes$Mid.SKSPEC8[1:n-1]-1)
#Worse code ever

#write.csv(FundPRes, file = "exportFundPRes.csv")

CombByDate <-merge(FundPRes, SectorRet, by = "Date", all = FALSE)
head(CombByDate)

lastDate

Set3y <- window(CombByDate, start = as.date("2012-4-30"), end = "2015-4-30")

# .pardefault <- par()
# 
# par(mfrow = c(2,3), mar= c(3,3,2,1))
# boxplot(CombByDate$Spec3Ret, main = "Spectrum 3")
# boxplot(CombByDate$Spec4Ret, main = "Spectrum 4")
# boxplot(CombByDate$Spec5Ret, main = "Spectrum 5")
# boxplot(CombByDate$Spec6Ret, main = "Spectrum 6")
# boxplot(CombByDate$Spec7Ret, main = "Spectrum 7")
# boxplot(CombByDate$Spec8Ret, main = "Spectrum 8")
# 
# par(mfrow = c(2,2), mar= c(3,3,2,1))
# boxplot(CombByDate$IMA35Med, main = "IMA med 0-35")
# boxplot(CombByDate$IMA60Med, main = "IMA med 20-60")
# boxplot(CombByDate$IMA85Med, main = "IMA med 40-85")
# boxplot(CombByDate$IMAfMed, main = "IMA med Flex")
# 
# par(mfrow = c(2,2), mar= c(3,3,2,1))
# boxplot(CombByDate$IMA35Med, main = "IMA avg 0-35")
# boxplot(CombByDate$IMA60Med, main = "IMA avg 20-60")
# boxplot(CombByDate$IMA85Med, main = "IMA avg 40-85")
# boxplot(CombByDate$IMAfMed, main = "IMA avg Flex")
# 
# 
# par(.pardefault)
