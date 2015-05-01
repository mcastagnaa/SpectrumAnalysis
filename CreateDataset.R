rm(list =ls(all=TRUE))

FundPrices <- read.csv("CitiPrices.csv", header = TRUE)
FundPrices$Date <- as.Date(FundPrices$Date, "%d/%m/%Y")
str(FundPrices)
names(FundPrices)

SectorRet <- read.csv("IMAreturns.csv", header = TRUE)
SectorRet$Date <- as.Date(SectorRet$Date, "%d-%b-%y")
str(SectorRet)
names(SectorRet)
SectorRet$IMA35Ret <- SectorRet$IMAmix35/100
SectorRet$IMA60Ret <- SectorRet$IMAmix60/100
SectorRet$IMA85Ret <- SectorRet$IMAmix85/100
SectorRet$IMAfRet <- SectorRet$IMAflex/100


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

.pardefault <- par()

par(mfrow = c(2,3), mar= c(3,3,2,1))
boxplot(CombByDate$Spec3Ret, main = "Spectrum 3")
boxplot(CombByDate$Spec4Ret, main = "Spectrum 4")
boxplot(CombByDate$Spec5Ret, main = "Spectrum 5")
boxplot(CombByDate$Spec6Ret, main = "Spectrum 6")
boxplot(CombByDate$Spec7Ret, main = "Spectrum 7")
boxplot(CombByDate$Spec8Ret, main = "Spectrum 8")

par(mfrow = c(2,2), mar= c(3,3,2,1))
boxplot(CombByDate$IMA35Ret, main = "IMA mix 0-35")
boxplot(CombByDate$IMA60Ret, main = "IMA mix 35-60")
boxplot(CombByDate$IMA85Ret, main = "IMA mix 60-85")
boxplot(CombByDate$IMAfRet, main = "IMA Flex")

par(.pardefault)
