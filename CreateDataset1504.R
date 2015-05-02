rm(list =ls(all=TRUE))

FundPrices <- read.csv("CitiPrices.csv", header = TRUE)
FundPrices$Date <- as.Date(FundPrices$Date, "%d/%m/%Y")

SectorRet <- read.csv("IMAreturns1504.csv", header = TRUE)
SectorRet$Date <- as.Date(SectorRet$Date, "%d-%b-%y")

#################################################################
# Sector returns in percentage terms

SectorRet[, 2:dim(SectorRet)[2]] <- SectorRet[, 2:dim(SectorRet)[2]]/100


#################################################################
# Spectrum funds by columns on date - mid only
FundPRes <- reshape(FundPrices[FundPrices$Class == "OA",],  
                    drop = c("Class", "SwingBasis", "Bid", "Offer"),
                    idvar = c("Date"),
                    timevar = "Fund", 
                    direction = "wide")

rownames(FundPRes) <- FundPRes$Date
n <- nrow(FundPRes)


FundPRes$Spec3Ret <- c(NA, FundPRes$Mid.SKSPEC3[2:n]/FundPRes$Mid.SKSPEC3[1:n-1]-1)
FundPRes$Spec4Ret <- c(NA, FundPRes$Mid.SKSPEC4[2:n]/FundPRes$Mid.SKSPEC4[1:n-1]-1)
FundPRes$Spec5Ret <- c(NA, FundPRes$Mid.SKSPEC5[2:n]/FundPRes$Mid.SKSPEC5[1:n-1]-1)
FundPRes$Spec6Ret <- c(NA, FundPRes$Mid.SKSPEC6[2:n]/FundPRes$Mid.SKSPEC6[1:n-1]-1)
FundPRes$Spec7Ret <- c(NA, FundPRes$Mid.SKSPEC7[2:n]/FundPRes$Mid.SKSPEC7[1:n-1]-1)
FundPRes$Spec8Ret <- c(NA, FundPRes$Mid.SKSPEC8[2:n]/FundPRes$Mid.SKSPEC8[1:n-1]-1)


CombByDate <-merge(FundPRes, SectorRet, by = "Date", all = FALSE)
rownames(CombByDate) <- CombByDate$Date

firstDate <- min(CombByDate$Date)
lastDate <- max(CombByDate$Date)

